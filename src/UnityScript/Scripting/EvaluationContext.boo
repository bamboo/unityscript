namespace UnityScript.Scripting

import System

class EvaluationContext:
	
	[getter(ScriptContainer)]
	private _container as IEvaluationDomainProvider
	
	private _activeScripts = []
	"""
	Scripts evaluated in the current context. The members defined in one script
	are available to the next ones.
	"""
	
	def constructor(container as IEvaluationDomainProvider):
		_container = container or SimpleEvaluationDomainProvider()
		
	IsStaticContext:
		get: return SimpleEvaluationDomainProvider is _container.GetType()
				
	[lock]
	def AddScript(script):
		_activeScripts.Add(script)
		
	[lock]
	def GetActiveScript(scriptId as int):
		return _activeScripts[scriptId]
		
	[lock]
	def GetActiveScriptId(script):
		return _activeScripts.IndexOf(script)
		
	[lock]
	def GetActiveScripts():
		return _activeScripts.ToArray()

