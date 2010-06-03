namespace UnityScript.Tests

import System
import System.IO
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.IO
import NUnit.Framework
import UnityScript

[TestFixture]
partial class ErrorMessagesTestFixture(AbstractCompilerTestFixture):
	
	override protected def CreateCompilerPipeline():
		return UnityScriptCompiler.Pipelines.Compile()
		
	override protected def CheckTestCaseCompilationResult(result as CompilerContext):
		pass
		
	override protected def GetActualOutput(result as CompilerContext):
		buffer = StringWriter()
		WriteCompilerMessages(buffer, result.Errors)
		WriteCompilerMessages(buffer, result.Warnings)
		return buffer.ToString()
		
	def WriteCompilerMessages(buffer as TextWriter, items):
		for error as duck in items:
			li as LexicalInfo = error.LexicalInfo
			msg = "${Path.GetFileName(li.FileName)}(${li.Line},${li.Column}): ${error.Code}: ${error.Message}"
			buffer.WriteLine(msg)		
	
		
