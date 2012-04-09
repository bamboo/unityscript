namespace UnityScript.Parser

import System.IO
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import PatternMatching

partial class UnityScriptParser:
	
	static def ParseReader(reader as TextReader, fileName as string, context as CompilerContext, targetCompileUnit as CompileUnit):
		lexer = UnityScriptLexerFor(reader, fileName, TabSizeFromContext(context))
		if lexer is null:
			targetCompileUnit.Modules.Add(Module(LexicalInfo(fileName, 1, 1)))
			return
			
		parser = UnityScriptParser(lexer, CompilerContext: context)
		parser.setFilename(fileName)
		
		try:
			parser.start(targetCompileUnit)
		except x as antlr.TokenStreamRecognitionException:
			parser.reportError(x.recog)
			
	static def ParseExpression(expression as string, fileName as string, context as CompilerContext):
		return ParseExpression(StringReader(expression), fileName, context)
			
	static def ParseExpression(expression as TextReader, fileName as string, context as CompilerContext):
	"""
	if the expression reader is empty returns null.
	
	Otherwise tries to parse an expression reporting errors in the compiler context passed as argument.
	"""
		lexer = UnityScriptLexerFor(expression, fileName, TabSizeFromContext(context))
		if lexer is null:
			return null
			
		parser = UnityScriptParser(lexer, CompilerContext: context)
		parser.setFilename(fileName)
		
		try:
			return parser.expression()
		except x as antlr.TokenStreamRecognitionException:
			parser.reportError(x.recog)
			
	static def UnityScriptLexerFor(reader as TextReader, fileName as string, tabSize as int):
		if reader.Peek() == -1:
			return null
			
		lexer = UnityScriptLexer(reader)
		lexer.setFilename(fileName)
		lexer.setTokenCreator(Boo.Lang.Parser.BooToken.BooTokenCreator())
		lexer.setTabSize(tabSize)
		return lexer
		
	static def TabSizeFromContext(context as CompilerContext):
		match context:
			case CompilerContext(Parameters: UnityScriptCompilerParameters(TabSize: t)):
				return t
			otherwise:
				return UnityScriptCompilerParameters.DefaultTabSize
		