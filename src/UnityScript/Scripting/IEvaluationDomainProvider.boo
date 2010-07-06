namespace UnityScript.Scripting
	
interface IEvaluationDomainProvider:
"""
Every script in UnityScript defines a new EvaluationDomain.
"""
	def GetImports() as (string)
	def GetAssemblyReferences() as (System.Reflection.Assembly)
	def GetEvaluationDomain() as EvaluationDomain
	
class EvaluationDomain:
"""
A EvaluationScript cache.
"""
	_cache = {}
	
	[lock]
	def GetCachedScript(key as EvaluationScriptCacheKey) as System.Type:
		return _cache[key]
	
	[lock]
	def CacheScript(key as EvaluationScriptCacheKey, type as System.Type):
		_cache[key] = type
		
class EvaluationScriptCacheKey:
	
	_contextType as System.Type
	_code as string
	
	def constructor(contextType as System.Type, code as string):
		_contextType = contextType
		_code = code
		
	override def Equals(o):
		other = o as EvaluationScriptCacheKey
		if other is null: return false
		return other._contextType is _contextType and other._code == _code
		
	override def GetHashCode():
		return _contextType.GetHashCode() ^ _code.GetHashCode()