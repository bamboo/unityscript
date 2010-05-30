namespace UnityScript

import Boo.Lang.Compiler

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
		self.References.Add(GetType().Assembly)
