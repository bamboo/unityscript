namespace UnityScript.TypeSystem

import Boo.Lang.Compiler.Services

class UnityScriptAmbiance(LanguageAmbiance):

	override def DefaultGeneratorTypeFor(typeName as string):
		return "IEnumerator"
		
	override SelfKeyword:
		get: return "this"
		
	override IsaKeyword:
		get: return "instanceof"
		
	override IsKeyword:
		get: return "==="
		
	override ExceptKeyword:
		get: return "catch"
		
	override EnsureKeyword:
		get: return "finally"
		
	override RaiseKeyword:
		get: return "throw"

	override CallableKeyword:
		get: return "function"

