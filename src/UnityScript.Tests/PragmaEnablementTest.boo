namespace UnityScript.Tests

import NUnit.Framework
import us

[TestFixture]
class PragmaEnablementTest:
	
	[Test]
	def PragmaDowncastCanBeDisabled():
		
		m1 = """
		var i:int = 42 cast Object;
		"""
		
		m2 = """
		#pragma downcast on
		var i:int = 42 cast Object;
		"""
		
		m3 = """
		#pragma downcast off
		var i:int = 42 cast Object;
		"""
		
		result = CompileModulesWithPragmas("strict,downcast", m1, m2, m3)
		Assert.AreEqual("m3.js(3,16): BCE0022: Cannot convert 'Object' to 'int'.", result.Errors.ToString().Trim())
		
def CompileModulesWithPragmas(pragmas as string, *modules as (string)):
	options = CommandLineOptions("-pragmas:$pragmas", "-method:Awake", "-base:${typeof(MonoBehaviour).FullName}", "-r:${GetAssemblyLocation()}")
					
	compiler = UnityScriptCompilerFactory.FromCommandLineOptions(options)
	for i as int, m in enumerate(modules):
		input = Boo.Lang.Compiler.IO.StringInput("m$(i+1).js", TrimLines(m))
		compiler.Parameters.Input.Add(input)
	
	return compiler.Run()
		
		
def TrimLines(source as string):
	return join(line.Trim() for line in /\n/.Split(source), "\n")
			
		
	
	
