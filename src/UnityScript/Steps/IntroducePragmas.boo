namespace UnityScript.Steps

import Boo.Lang.Compiler.Steps

class IntroducePragmas(AbstractCompilerStep):

	_pragmas as List of string
	
	def constructor(pragmas as List of string):
		_pragmas = pragmas
		
	override def Run():
		for module in CompileUnit.Modules:
			for pragma in _pragmas:
				module.Annotate(pragma) unless module.ContainsAnnotation(pragma)
	
