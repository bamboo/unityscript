namespace UnityScript.Tests

import Boo.Lang.Compiler
import Boo.Lang.Compiler.IO

import UnityScript

import NUnit.Framework

[TestFixture]
class MultiFileTestFixture:

	[Test]
	def NoWarningsOrErrorForEmptyClassInheritingEmptyScript():
		
		script1 = """
		class Message extends System.Object {
		}"""
		
		script2 = """
		class ServerMessage extends Message {
		}"""
				
		result = CompileScripts(StringInput("Message.js", script1), StringInput("ServerMessage.js", script2))
		Assert.AreEqual(0, len(result.Warnings), result.Warnings.ToString())
		Assert.AreEqual(0, len(result.Errors), result.Errors.ToString())
		
def CompileScripts(*scripts as (ICompilerInput)):
	compiler = UnityScriptCompiler()
	compiler.Parameters.Pipeline = UnityScriptCompiler.Pipelines.CompileToMemory()
	compiler.Parameters.ScriptBaseType = object
	compiler.Parameters.ScriptMainMethod = "Main"
	for input in scripts:
		compiler.Parameters.Input.Add(input)
	return compiler.Run()
