namespace UnityScript.Steps

import System
import Boo.Lang.Environments
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.TypeSystem.Services
import UnityScript.Macros
import UnityScript.Scripting

class EvaluationDomainProviderImplementor(AbstractCompilerComponent):
	
	def ImplementIEvaluationDomainProviderOn(node as ClassDefinition):
		domainField = ReferenceExpression(Context.GetUniqueName("domain"))
		evaluationDomainProviderImpl = [|
			class _($IEvaluationDomainProvider):
				
				private $domainField as $EvaluationDomain
				
				public def GetEvaluationDomain():
					return $domainField or ($domainField = $EvaluationDomain())
					
				public def GetImports():
					return $(ImportsArrayFor(node))
					
				public def GetAssemblyReferences():
					return $(AssemblyReferencesArray())
		|]
		
		my(CodeReifier).MergeInto(node, evaluationDomainProviderImpl)
		
	def StaticEvaluationDomainProviderFor(node as ClassDefinition) as IField:
		perNode node:
			return CreateStaticEvaluationDomainProviderReferenceOn(node)
			
	private def AssemblyReferencesArray() as Expression:
		perNode CompileUnit:
			return CodeBuilder.CreateReference(CreateAssemblyReferencesArray())
		
	private def ImportsArrayFor(node as ClassDefinition):
		result = [| (of $string:,) |]
		result.Items.AddRange([| $(i.Namespace) |] for i in node.EnclosingModule.Imports)
		return result		
		
	private def CreateStaticEvaluationDomainProviderReferenceOn(node as ClassDefinition):
		evaluationDomainProviderImpl = [|
			public class StaticEvaluationDomainProvider($SimpleEvaluationDomainProvider):
				
				public static final Instance = StaticEvaluationDomainProvider()
				
				def constructor():
					super($(ImportsArrayFor(node)))
					
				override def GetAssemblyReferences():
					return $(AssemblyReferencesArray())
		|]
		my(CodeReifier).ReifyInto(node, evaluationDomainProviderImpl)
		return evaluationDomainProviderImpl.Members["Instance"].Entity
		
	private def CreateAssemblyReferencesArray() as IField:		
		references = [| (System.Reflection.Assembly.GetExecutingAssembly(),) |]
				
		for assembly in ReferencedAssemblies():
			publicType = AnyPublicTypeOf(assembly)
			continue if publicType is null
			references.Items.Add([| typeof($publicType).Assembly |])
		
		arrayHolder = [|
			internal class EvalAssemblyReferences:
				public static final Value = $references
		|]
		my(CodeReifier).ReifyInto(CompileUnit.Modules[0], arrayHolder)
		return arrayHolder.Members["Value"].Entity
		
	private def AnyPublicTypeOf(assembly as System.Reflection.Assembly):
		for t in assembly.GetTypes():
			return t if t.IsPublic and not t.IsGenericType
	
	private def ReferencedAssemblies():
		collector = ReferencedAssemblyCollector()
		CompileUnit.Accept(collector)
		return collector.ReferencedAssemblies
		
class ReferencedAssemblyCollector(DepthFirstVisitor):
	
	[getter(ReferencedAssemblies)]
	_assemblies = Boo.Lang.Compiler.Util.Set of Assembly()
	
	override def OnReferenceExpression(node as ReferenceExpression):
		CheckTypeReference(node)
		
	override def LeaveMemberReferenceExpression(node as MemberReferenceExpression):
		CheckTypeReference(node)
		
	override def OnSimpleTypeReference(node as SimpleTypeReference):
		CheckTypeReference(node)
		
	def CheckTypeReference(node as Node):
		type = node.Entity as Boo.Lang.Compiler.TypeSystem.Reflection.ExternalType
		if type is null: return
		_assemblies.Add(type.ActualType.Assembly)

