namespace UnityScript

import Boo.Lang.Environments
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Services
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.TypeSystem.Services

import UnityScript.TypeSystem

class UnityScriptCompilerParameters(CompilerParameters):
	
	public static final DefaultTabSize = 8
	
	property ScriptBaseType as System.Type
	
	property ScriptMainMethod as string
	
	property Imports = List of string()
	
	property Expando = false
	
	property GlobalVariablesBecomeFields = true
	
	property DisableEval as string
	
	property TabSize = DefaultTabSize
	
	def constructor(loadDefaultReferences as bool):
		super(Boo.Lang.Compiler.TypeSystem.Reflection.ReflectionTypeSystemProvider(), loadDefaultReferences)
		self.Checked = false
		self.OutputType = CompilerOutputType.Library
		self.Environment = DeferredEnvironment() {
			EntityFormatter: { UnityScriptEntityFormatter() },
			TypeSystemServices: { UnityScriptTypeSystem() },
			CallableResolutionService: { UnityCallableResolutionService() },
			DowncastPermissions: { UnityDowncastPermissions() },
			LanguageAmbiance: { UnityScriptAmbiance() }
		}
		if loadDefaultReferences:
			self.References.Add(typeof(UnityScript.Lang.Array).Assembly)
			self.References.Add(GetType().Assembly)
	
	def constructor():
		self(true)
		
	def AddToEnvironment(serviceType as System.Type, factory as ObjectFactory):
		(Environment as DeferredEnvironment).Add(serviceType, factory)
		
	override Ducky:
		get: return not Strict
		set: raise "Ducky is always equals not Strict. Set Strict instead."
