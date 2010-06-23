namespace UnityScript.Steps

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Steps

class SuppressWarnings(AbstractCompilerStep):

	_suppressed as List of string
	
	def constructor(suppressed as List of string):
		_suppressed = suppressed
		
	override def Run():
		Warnings.Adding += Warnings_Adding
		
	def Warnings_Adding(sender, args as CompilerWarningEventArgs):
		args.Cancel() if args.Warning.Code in _suppressed
	
