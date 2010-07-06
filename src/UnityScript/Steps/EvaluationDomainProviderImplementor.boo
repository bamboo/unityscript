namespace UnityScript.Steps

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.TypeSystem.Reflection
import UnityScript.Scripting

class EvaluationDomainProviderImplementor(AbstractCompilerComponent):
	
	def ImplementIEvaluationDomainProviderOn(node as ClassDefinition):
		node.BaseTypes.Add(CodeBuilder.CreateTypeReference(IEvaluationDomainProvider))
		ImplementGetEvaluationDomain(node)
		ImplementGetImports(node)
		ImplementGetAssemblyReferences(node)
		
	private def ImplementGetImports(node as ClassDefinition):
		builder = AddVirtualMethod(node, "GetImports", StringArray())
		builder.Body.Add(ReturnStatement(CreateImportsArray(node)))
		
	private def CreateImportsArray(node as ClassDefinition):
		items = ExpressionCollection()
		for i in node.EnclosingModule.Imports:
			items.Add(CodeBuilder.CreateStringLiteral(i.Namespace))	
		return CodeBuilder.CreateArray(StringArray(), items)
		
	private def ImplementGetEvaluationDomain(node as ClassDefinition):
		evaluationDomainType = Map(EvaluationDomain)
		domainField = CodeBuilder.CreateField(Context.GetUniqueName("domain"), evaluationDomainType)
		node.Members.Add(domainField)
		
		builder = AddVirtualMethod(node, "GetEvaluationDomain", evaluationDomainType)
						
		// if _domain is null: _domain = EvaluationDomain()
		ifDomainField = IfStatement(TrueBlock: Block())
		ifDomainField.Condition = CodeBuilder.CreateBoundBinaryExpression(
			TypeSystemServices.BoolType,
			BinaryOperatorType.ReferenceEquality,
			CodeBuilder.CreateReference(domainField),
			CodeBuilder.CreateNullLiteral())
		ifDomainField.TrueBlock.Add(
			CodeBuilder.CreateFieldAssignment(
				domainField,
				CodeBuilder.CreateConstructorInvocation(ConstructorTakingNArgumentsFor(evaluationDomainType, 0))))
				
		builder.Body.Add(ifDomainField)
		
		// return _domain
		builder.Body.Add(ReturnStatement(CodeBuilder.CreateReference(domainField)))
		
	private def ImplementGetAssemblyReferences(node as ClassDefinition):
		builder = AddVirtualMethod(node, "GetAssemblyReferences", AssemblyArray())
		builder.Body.Add(ReturnStatement(CreateAssemblyReferencesArray(node)))
		
	private def CreateAssemblyReferencesArray(node as ClassDefinition):
		
		assemblyProperty = SystemTypeAssemblyProperty().GetGetMethod()
		
		references = ExpressionCollection()
		
		// generated assembly reference
		references.Add(
			CodeBuilder.CreateMethodInvocation(
				CodeBuilder.CreateTypeofExpression(node.Entity as IType), assemblyProperty))
				
		for reference in Parameters.References:
			assemblyRef = reference as IAssemblyReference
			continue if assemblyRef is null
			publicType = AnyPublicTypeOf(assemblyRef.Assembly)
			continue if publicType is null
			references.Add(
				CodeBuilder.CreateMethodInvocation(
					CodeBuilder.CreateTypeofExpression(publicType), assemblyProperty))
				
		return CodeBuilder.CreateArray(AssemblyArray(), references)
		
	private def AddVirtualMethod(node as ClassDefinition, name as string, returnType as IType):
		builder = BooMethodBuilder(CodeBuilder, name, returnType, TypeMemberModifiers.Public | TypeMemberModifiers.Virtual)
		node.Members.Add(builder.Method)
		return builder
		
	private def SystemTypeAssemblyProperty() as IProperty:
		return TypeSystemServices.Map(typeof(System.Type).GetProperty("Assembly"))
		
	private def AssemblyArray():
		return Map(typeof((System.Reflection.Assembly)))
		
	private def StringArray():
		return Map(typeof((string)))
		
	private def Map(type as System.Type):
		return TypeSystemServices.Map(type)
		
	private def AnyPublicTypeOf(assembly as System.Reflection.Assembly):
		for t in assembly.GetTypes():
			return t if t.IsPublic and not t.IsGenericType
		
		

		
