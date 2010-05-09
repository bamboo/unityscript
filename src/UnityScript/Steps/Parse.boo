namespace UnityScript.Steps

import System
import System.IO
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
			if reader.Peek() == -1:
				return
			ParseReader(input.Name, reader)
	
	protected virtual def ParseReader(name as string, reader as TextReader):
		lexer = UnityScriptLexer(reader)
		lexer.setFilename(name)
		lexer.setTokenCreator(Boo.Lang.Parser.BooToken.BooTokenCreator())
		
		parser = UnityScriptParser(lexer, CompilerContext: Context)
		parser.setFilename(name)
		
		try:
			parser.start(self.CompileUnit)
		except x as antlr.TokenStreamRecognitionException:
			parser.reportError(x.recog)
