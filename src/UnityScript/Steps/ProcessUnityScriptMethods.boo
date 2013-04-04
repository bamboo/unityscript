namespace UnityScript.Steps

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.TypeSystem.Internal
import Boo.Lang.Compiler.Steps

import Boo.Lang.Environments

import UnityScript.Core
import UnityScript.Macros
import UnityScript.TypeSystem

class ProcessUnityScriptMethods(ProcessMethodBodiesWithDuckTyping):
	
	deferred IEnumerable_GetEnumerator = typeof(System.Collections.IEnumerable).GetMethod("GetEnumerator");
		
	deferred IEnumerator_MoveNext = typeof(System.Collections.IEnumerator).GetMethod("MoveNext");
		
	deferred IEnumerator_get_Current = typeof(System.Collections.IEnumerator).GetProperty("Current").GetGetMethod();
	
	deferred _StartCoroutine = NameResolutionService.ResolveMethod(UnityScriptTypeSystem.ScriptBaseType, "StartCoroutine_Auto")		
	
	deferred _UnityRuntimeServices_GetEnumerator = ResolveUnityRuntimeMethod("GetEnumerator")													
	
	deferred _UnityRuntimeServices_Update = ResolveUnityRuntimeMethod("Update")
	
	deferred _UnityRuntimeServices_GetTypeOf = ResolveUnityRuntimeMethod("GetTypeOf")
	
	_implicit = false
	
	override def Initialize(context as CompilerContext):
		super(context)
		
		// don't transform
		//		 foo == null
		// into:
		//		 foo is null
		// but into:
		//		 foo.Equals(null)						
		self.OptimizeNullComparisons = false
		
	def ResolveUnityRuntimeMethod(name as string):
		return NameResolutionService.ResolveMethod(UnityRuntimeServicesType, name)
		
	def ResolveUnityRuntimeField(name as string):
		return NameResolutionService.ResolveField(UnityRuntimeServicesType, name)
		
	deferred UnityRuntimeServicesType = TypeSystemServices.Map(UnityScript.Lang.UnityRuntimeServices)
		
	UnityScriptTypeSystem as UnityScript.TypeSystem.UnityScriptTypeSystem:
		get: return self.TypeSystemServices
			
	UnityScriptParameters as UnityScript.UnityScriptCompilerParameters:
		get: return _context.Parameters
		
	override def GetGeneratorReturnType(generator as InternalMethod):
		return TypeSystemServices.IEnumeratorType
		
	override protected def MemberNotFound(node as MemberReferenceExpression, ns as INamespace):
		if Strict:			
			super(node, ns)
		else:
			BindQuack(node)
		
	override protected def LocalToReuseFor(d as Declaration):
		if DeclarationAnnotations.ShouldForceNewVariableFor(d):
			AssertUniqueLocal(d)
			return null
		return super(d)
				
	override def OnModule(module as Module):	
		ActiveModule = module
		super(module)
			
	override def VisitMemberPreservingContext(node as TypeMember):
		
		module = node.EnclosingModule
		if module is ActiveModule:
			super(node)
			return
			
		preserving ActiveModule:
			ActiveModule = module
			super(node)
			
	ActiveModule:
		get: return _activeModule
		set:
			_activeModule = value
			UpdateSettingsForActiveModule()
			
	_activeModule as Module
	
	def UpdateSettingsForActiveModule():
		Parameters.Strict = Pragmas.IsEnabledOn(ActiveModule, Pragmas.Strict)
		_implicit = Pragmas.IsEnabledOn(ActiveModule, Pragmas.Implicit)
		my(UnityDowncastPermissions).Enabled = Pragmas.IsEnabledOn(ActiveModule, Pragmas.Downcast)
		if ShouldDisableImplicitDowncastWarning():
			Parameters.DisableWarning(ImplicitDowncast)
		else:
			Parameters.EnableWarning(ImplicitDowncast)
			
	def ShouldDisableImplicitDowncastWarning():
		return not Parameters.Strict or ActiveModule.ContainsAnnotation(Pragmas.Downcast)
			
	ImplicitDowncast:
		get: return Boo.Lang.Compiler.CompilerWarningFactory.Codes.ImplicitDowncast
		
	Strict:
		get: return Parameters.Strict
		
	override def OnMethod(node as Method):
		super(node)
		CheckForEmptyCoroutine(node)
		return if Parameters.OutputType == CompilerOutputType.Library
		CheckEntryPoint(node)
		
	def CheckForEmptyCoroutine(node as Method):
		if not IsEmptyCoroutine(node):
			return
		node.Body.Add([| return $(EmptyEnumeratorReference) |])
			
	def IsEmptyCoroutine(node as Method):
		entity as InternalMethod = GetEntity(node)
		return entity.ReturnType is GetGeneratorReturnType(entity) and HasNeitherReturnNorYield(node)
		
	deferred EmptyEnumeratorReference = CodeBuilder.CreateMemberReference(ResolveUnityRuntimeField("EmptyEnumerator"))
		
	def CheckEntryPoint(node as Method):
		if not node.IsStatic: return
		if not node.IsPublic: return
		if node.Name != "Main": return
		if GetType(node.ReturnType) is not TypeSystemServices.VoidType: return
		
		ContextAnnotations.SetEntryPoint(_context, node)
		
	override def ProcessAutoLocalDeclaration(node as BinaryExpression, reference as ReferenceExpression):
		if (Strict and not _implicit) and not IsCompilerGenerated(reference):
			EmitUnknownIdentifierError(reference, reference.Name)
		else:
			super(node, reference)
			
	def IsCompilerGenerated(reference as ReferenceExpression):
		return reference.Name.Contains('$')
		
	override protected def ProcessBuiltinInvocation(node as MethodInvocationExpression, function as BuiltinFunction):
		if function is UnityScriptTypeSystem.UnityScriptEval:
			EvalAnnotation.Mark(CurrentMethod)
			BindExpressionType(node, TypeSystemServices.ObjectType)
			return
		if function is UnityScriptTypeSystem.UnityScriptTypeof:
			ProcessTypeofBuiltin(node);
			return
		super(node, function)
		
	private def ProcessTypeofBuiltin(node as MethodInvocationExpression):
		if node.Arguments.Count != 1:
			Error(node, CompilerError("UCE0001", node.Target.LexicalInfo, "'typeof' takes a single argument.", null))
			return
		
		type = node.Arguments[0].Entity as IType
		if type is not null:
			node.ParentNode.Replace(node, CodeBuilder.CreateTypeofExpression(type))
			return
			
		node.Target = CodeBuilder.CreateReference(_UnityRuntimeServices_GetTypeOf)
		BindExpressionType(node, TypeSystemServices.TypeType)		
		
	override protected def ProcessMethodInvocation(node as MethodInvocationExpression, method as IMethod):
	"""
	Automatically detects coroutine invocations in assignments and as standalone
	expressions and generates StartCoroutine invocations.
	"""
		super(node, method)
		
		if not IsPossibleStartCoroutineInvocationForm(node):
			return		

		tss = self.UnityScriptTypeSystem
		if not tss.IsScriptType(method.DeclaringType): return		
		if not tss.IsGenerator(method): return
		
		if CurrentMethod.IsStatic:
			Warnings.Add(UnityScriptWarnings.CannotStartCoroutineFromStaticFunction(node.LexicalInfo, method.Name))
			return
		
		parentNode = node.ParentNode
		parentNode.Replace(
			node,
			CodeBuilder.CreateMethodInvocation(
				CodeBuilder.CreateSelfReference(node.LexicalInfo, CurrentType),
				_StartCoroutine,
				node))
				
	override def ProcessStaticallyTypedAssignment(node as BinaryExpression):
		TryToResolveAmbiguousAssignment(node)		
		ApplyImplicitArrayConversion(node)
		if ValidateAssignment(node):
			BindExpressionType(node, GetExpressionType(node.Right))
		else:
			Error(node)
		
	def ApplyImplicitArrayConversion(node as BinaryExpression):
		leftType = GetExpressionType(node.Left)
		return unless leftType.IsArray
				
		rightType = GetExpressionType(node.Right)
		return unless rightType is UnityScriptLangArray()

		node.Right = CodeBuilder.CreateCast(leftType, 
						CodeBuilder.CreateMethodInvocation(
							node.Right,
							ResolveMethod(rightType, "ToBuiltin"),
							CodeBuilder.CreateTypeofExpression(leftType.ElementType)))
							
	def UnityScriptLangArray():
		return TypeSystemServices.Map(UnityScript.Lang.Array)
				
	override def OnForStatement(node as ForStatement):
		assert 1 == len(node.Declarations)
		Visit(node.Iterator)
		if NeedsUpdateableIteration(node):
			ProcessUpdateableIteration(node)
		else:
			ProcessNormalIteration(node)

	def ProcessNormalIteration(node as ForStatement):
		node.Iterator = ProcessIterator(node.Iterator, node.Declarations)
		VisitForStatementBlock(node)
		
	def ProcessUpdateableIteration(node as ForStatement):
		originalIterator = node.Iterator
		newIterator = CodeBuilder.CreateMethodInvocation(_UnityRuntimeServices_GetEnumerator, node.Iterator)
		newIterator.LexicalInfo = LexicalInfo(node.Iterator.LexicalInfo)
		node.Iterator = newIterator
		ProcessDeclarationForIterator(node.Declarations[0], GetEnumeratorItemType(GetExpressionType(originalIterator)))
		VisitForStatementBlock(node)
		TransformIteration(node)

	def TransformIteration(node as ForStatement):
		iterator = CodeBuilder.DeclareLocal(
						CurrentMethod,
						_context.GetUniqueName("iterator"),
						TypeSystemServices.IEnumeratorType)
		iterator.IsUsed = true
		body = Block(node.LexicalInfo)
		body.Add(
			CodeBuilder.CreateAssignment(
				node.LexicalInfo,
				CodeBuilder.CreateReference(iterator),
				node.Iterator))
				
		// while __iterator.MoveNext():
		ws = WhileStatement(node.LexicalInfo)
		ws.Condition = CodeBuilder.CreateMethodInvocation(
						CodeBuilder.CreateReference(iterator),
						IEnumerator_MoveNext)
			
		current = CodeBuilder.CreateMethodInvocation(
							CodeBuilder.CreateReference(iterator),
							IEnumerator_get_Current)
			
		//	item = __iterator.Current
		loopVariable as InternalLocal = TypeSystemServices.GetEntity(node.Declarations[0])
		ws.Block.Add(
				CodeBuilder.CreateAssignment(
					node.LexicalInfo,
					CodeBuilder.CreateReference(loopVariable),
					current))
		ws.Block.Add(node.Block)			
		
		LoopVariableUpdater(self, _context, iterator, loopVariable).Visit(node)
		
		body.Add(ws)
		node.ParentNode.Replace(node, body)
		
	def NeedsUpdateableIteration(node as ForStatement):
		iteratorType = GetExpressionType(node.Iterator)
		if iteratorType.IsArray: return false
		return true
		
	class LoopVariableUpdater(DepthFirstVisitor):
		
		_parent as ProcessUnityScriptMethods
		_context as CompilerContext
		_iteratorVariable as IEntity
		_loopVariable as IEntity
		_found as bool
		
		def constructor(parent as ProcessUnityScriptMethods, context as CompilerContext, iteratorVariable as IEntity, loopVariable as IEntity):
			_parent = parent
			_context = context
			_iteratorVariable = iteratorVariable
			_loopVariable = loopVariable
			
		override def OnExpressionStatement(node as ExpressionStatement):
			_found = false
			Visit(node.Expression)
			if not _found: return
			
			parentNode = node.ParentNode
			
			codeBuilder = _context.CodeBuilder
			block = Block(node.LexicalInfo)
			block.Add(node)
			block.Add(
				codeBuilder.CreateMethodInvocation(
					_parent._UnityRuntimeServices_Update, 
					codeBuilder.CreateReference(_iteratorVariable),
					codeBuilder.CreateReference(_loopVariable)))

			parentNode.Replace(node, block)
			
		override def OnReferenceExpression(node as ReferenceExpression):
			if _found: return
			
			referent = node.Entity
			_found = referent is _loopVariable
