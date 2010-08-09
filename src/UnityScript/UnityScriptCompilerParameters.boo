namespace UnityScript

import Boo.Lang.Environments
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Services
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.TypeSystem.Services
import UnityScript.TypeSystem

class UnityScriptCompilerParameters(CompilerParameters):
	
	[property(ScriptBaseType)]
	_baseType as System.Type
	
	[property(ScriptMainMethod)]
	_mainMethod as string
	
	[property(Imports)]
	_imports = []
	
	[property(Expando)]
	_expando = false
	
	[property(GlobalVariablesBecomeFields)]
	_globalVariablesBecomeFields = true

	def constructor():
		self.Ducky = true
		self.OutputType = CompilerOutputType.Library
		self.References.Add(typeof(UnityScript.Lang.Array).Assembly)
		self.References.Add(GetType().Assembly)
		self.Environment = DeferredEnvironment() {
			EntityFormatter: { UnityScriptEntityFormatter() },
			TypeSystemServices: { UnityScriptTypeSystem() },
			CallableResolutionService: { UnityCallableResolutionService() },
			DowncastPermissions: { UnityDowncastPermissions() },
			LanguageAmbiance: { UnityScriptAmbiance() }
		}
