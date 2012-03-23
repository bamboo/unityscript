namespace UnityScript.Steps

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Steps
import UnityScript.Parser

class Parse(AbstractCompilerStep):
	
	override def Run():
		for input in self.Parameters.Input:
			try:
				ParseInput(input)
			except x:
				Errors.Add(CompilerErrorFactory.InputError(input.Name, x))

	private def ParseInput(input as ICompilerInput):
		using reader = input.Open():
			UnityScriptParser.ParseReader(reader, input.Name, self.Context, self.CompileUnit)