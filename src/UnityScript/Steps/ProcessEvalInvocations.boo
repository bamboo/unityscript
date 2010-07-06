namespace UnityScript.Steps

import System
import Boo.Lang.Environments
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.TypeSystem.Internal
import Boo.Lang.Compiler.TypeSystem.Builders
import UnityScript.Scripting
import UnityScript.TypeSystem

class ProcessEvalInvocations(AbstractVisitorCompilerStep):
	
	static final Evaluator_Eval = typeof(Evaluator).GetMethod("Eval")
	
	_currentMethod as InternalMethod
	_evaluationContextLocal as InternalLocal
	
	override def Run():
		return if Errors.Count > 0
		Visit(CompileUnit)
		
	override def OnConstructor(node as Constructor):
		OnMethod(node)
	
	override def OnMethod(node as Method):
		
		if not EvalAnnotation.IsMarked(node): return
		
		_currentMethod = GetEntity(node)
		
		evaluationContextType = DefineEvaluationContext()
		initialization = PrepareEvaluationContextInitialization(evaluationContextType)
		Visit(node.Body)
		node.Body.Insert(0, initialization)
		
		
	override def OnReferenceExpression(node as ReferenceExpression):
		entity = node.Entity as IInternalEntity
		if entity is null: return
		
		field = GetEvaluationContextField(entity.Node)
		if field is null: return
		
		node.ParentNode.Replace(
			node,
			CreateEvaluationContextFieldReference(field))
			
	override def LeaveClassDefinition(node as ClassDefinition):
		if not EvalAnnotation.IsMarked(node): return
		
		my(EvaluationDomainProviderImplementor).ImplementIEvaluationDomainProviderOn(node)
		
	def DefineEvaluationContext():
		
		builder = CodeBuilder.CreateClass(Context.GetUniqueName("EvaluationContext"), TypeMemberModifiers.Public)
		builder.AddBaseType(Map(EvaluationContext))
		
		ChainConstructorsFromBaseType(builder)
		AddLocalVariablesAsFields(builder)
		
		CurrentTypeNode.Members.Add(builder.ClassDefinition)
		return builder.Entity
		
	def PrepareEvaluationContextInitialization(evaluationContextType as IType):
		
		_evaluationContextLocal = CodeBuilder.DeclareTempLocal(CurrentMethodNode, evaluationContextType)
		
		initializationBlock = Block()
		
		// $context = EvaluationContext(...)
		initializationBlock.Add(
			CodeBuilder.CreateAssignment(
				CreateEvaluationContextReference(),
				CodeBuilder.CreateConstructorInvocation(
					ConstructorTakingNArgumentsFor(evaluationContextType, 1),
					GetSelfReferenceIfInInstanceMethod())))
		
		for parameter in CurrentMethodNode.Parameters:
			// $context.param = param
			initializationBlock.Add(
				CodeBuilder.CreateAssignment(
					CreateEvaluationContextFieldReference(GetEvaluationContextField(parameter)),
					CodeBuilder.CreateReference(parameter)))
					
		return initializationBlock
		
	def GetSelfReferenceIfInInstanceMethod():
		if _currentMethod.IsStatic: return CodeBuilder.CreateNullLiteral()
		return CodeBuilder.CreateSelfReference(CurrentType)
		
	def CreateEvaluationContextFieldReference(field as InternalField):
		return CodeBuilder.CreateMemberReference(
						CreateEvaluationContextReference(),
						field)
					
	def CreateEvaluationContextReference():
		return CodeBuilder.CreateReference(_evaluationContextLocal)
		
	def ReplaceEvalByEvaluatorEval(node as MethodInvocationExpression):
		node.ParentNode.Replace(node, CreateEvaluatorInvocation(node))
		
	def CreateEvaluatorInvocation(node as MethodInvocationExpression):
		return CodeBuilder.CreateMethodInvocation(
				Evaluator_Eval,
				CreateEvaluationContextReference(),
				node.Arguments[0])
		
	def AddLocalVariablesAsFields(builder as BooClassBuilder):
		for local in CurrentMethodNode.Locals:
			localEntity as InternalLocal = GetEntity(local)
			if localEntity.IsPrivateScope: continue
			field = builder.AddPublicField(localEntity.Name, localEntity.Type)
			SetEvaluationContextField(local, GetEntity(field))
			
		for parameter in CurrentMethodNode.Parameters:
			parameterEntity as InternalParameter = GetEntity(parameter)
			field = builder.AddPublicField(parameterEntity.Name, parameterEntity.Type)
			SetEvaluationContextField(parameter, GetEntity(field))
			
	def ChainConstructorsFromBaseType(builder as BooClassBuilder):
		for superCtor in builder.Entity.BaseType.GetConstructors():
			superInvocationStmt = CodeBuilder.CreateSuperConstructorInvocation(superCtor)
			superInvocation = superInvocationStmt.Expression as MethodInvocationExpression
			
			ctor = builder.AddConstructor()
			for superParam in superCtor.GetParameters():
				ctorParam = ctor.AddParameter(superParam.Name, superParam.Type)
				superInvocation.Arguments.Add(CodeBuilder.CreateReference(ctorParam))
				
			ctor.Body.Add(superInvocationStmt)
		
	override def LeaveMethodInvocationExpression(node as MethodInvocationExpression):
		if not IsEvalInvocation(node): return
		
		ReplaceEvalByEvaluatorEval(node)
		
	def IsEvalInvocation(node as MethodInvocationExpression):
		return node.Target.Entity is UnityScriptTypeSystem.UnityScriptEval
		
	def Map(type as System.Type):
		return TypeSystemServices.Map(type)
		
	CurrentType:
		get: return _currentMethod.DeclaringType
		
	CurrentTypeNode:
		get: return CurrentMethodNode.DeclaringType
				
	CurrentMethodNode:
		get: return _currentMethod.Method
		
	CurrentMethodBody:
		get: return CurrentMethodNode.Body
		
	def SetEvaluationContextField(node as Node, field as InternalField):
		node["EvaluationContextField"] = field
		
	def GetEvaluationContextField(node as Node) as InternalField:
		return node["EvaluationContextField"]
		

