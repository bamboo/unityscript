namespace UnityScript.Scripting
	
class SimpleEvaluationDomainProvider(IEvaluationDomainProvider):
"""
SimpleEvaluationDomainProvider is used whenever there's an eval invocation
inside a static method.
"""	
	private _domain = EvaluationDomain()
	private _imports as (string)
	
	def constructor():
		pass
		
	def constructor(*imports as (string)):
		_imports = imports
	
	def GetImports():
		return _imports
	
	def GetEvaluationDomain():
		return _domain
		
	virtual def GetAssemblyReferences():
		return array[of System.Reflection.Assembly](0)
	

