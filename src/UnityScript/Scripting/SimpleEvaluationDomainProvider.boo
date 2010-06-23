namespace UnityScript.Scripting
	
class SimpleEvaluationDomainProvider(IEvaluationDomainProvider):
"""
SimpleEvaluationDomainProvider is used whenever there's an eval invocation
inside a static method.
"""	
	private _domain = EvaluationDomain()
	private _imports as (string)
	
	def GetImports():
		return _imports
	
	def GetEvaluationDomain():
		return _domain
	

