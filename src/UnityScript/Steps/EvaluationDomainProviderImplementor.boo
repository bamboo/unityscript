namespace UnityScript.Steps

import System
import Boo.Lang.Environments
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.TypeSystem.Services
import Boo.Lang.Compiler.TypeSystem.Reflection
import UnityScript.Scripting

class EvaluationDomainProviderImplementor(AbstractCompilerComponent):
	
	def ImplementIEvaluationDomainProviderOn(node as ClassDefinition):
		domainField = ReferenceExpression(Context.GetUniqueName("domain"))
		evaluationDomainProviderImpl = [|
			class _($IEvaluationDomainProvider):
				
				private $domainField as $EvaluationDomain
				
				def GetEvaluationDomain():
					return $domainField or ($domainField = $EvaluationDomain())
					
				def GetImports():
					return $(ImportsArrayFor(node))
					
				def GetAssemblyReferences():
					return $(AssemblyReferencesArrayFor(node))
		|]
		
		my(CodeReifier).MergeInto(node, evaluationDomainProviderImpl)
		
	def StaticEvaluationDomainProviderFor(node as ClassDefinition) as IField:
		providerField as IField = node[StaticEvaluationDomainProviderKey]
		if providerField is null:
			providerField = CreateStaticEvaluationDomainProviderReferenceOn(node)
			node[StaticEvaluationDomainProviderKey] = providerField
		return providerField
		
	private def CreateStaticEvaluationDomainProviderReferenceOn(node as ClassDefinition):
		evaluationDomainProviderImpl = [|
			internal class StaticEvaluationDomainProvider($SimpleEvaluationDomainProvider):
				
				public static final Instance = StaticEvaluationDomainProvider()
				
				def constructor():
					super($(ImportsArrayFor(node)))
					
				override def GetAssemblyReferences():
					return $(AssemblyReferencesArrayFor(node))
		|]
		my(CodeReifier).ReifyInto(node, evaluationDomainProviderImpl)
		return evaluationDomainProviderImpl.Members["Instance"].Entity
		
	private static final StaticEvaluationDomainProviderKey = object()

	private def ImportsArrayFor(node as ClassDefinition):
		result = [| (of $string:,) |]
		result.Items.Extend([| $(i.Namespace) |] for i in node.EnclosingModule.Imports)
		return result		
		
	private def AssemblyReferencesArrayFor(node as ClassDefinition):
		// TODO: only actually used assemblies should be part of this array
		// otherwise we risk bringing the kitchen sink
			
		result = [| (of $Assembly:,) |]
		result.Items.Add([| typeof($node).Assembly |])
				
		for reference in Parameters.References:
			assemblyRef = reference as IAssemblyReference
			continue if assemblyRef is null
			publicType = AnyPublicTypeOf(assemblyRef.Assembly)
			continue if publicType is null
			result.Items.Add([| typeof($publicType).Assembly |])
				
		return result
		
	private def AnyPublicTypeOf(assembly as System.Reflection.Assembly):
		for t in assembly.GetTypes():
			return t if t.IsPublic and not t.IsGenericType
		
		

		
