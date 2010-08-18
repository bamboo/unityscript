namespace UnityScript.Tests

import System
import System.Reflection

import NUnit.Framework
import UnityScript
import Boo.Lang.Compiler.IO

[TestFixture]
class EvalCompilationTest(AbstractCompilerTest):
	
	override def CreateCompilerPipeline():
		return UnityScriptCompiler.Pipelines.CompileToFile()
	
	[Test]
	def OnlyAssembliesWithReferencedTypesEndUpBeingReferenced():
		
		expected = ("mscorlib", "UnityScript", "UnityScript.Tests")
		code = """
		eval("print(\"hello\")");
		"""
		AssertAssemblyReferencesForEval expected, code
		
	[Test]
	def OnlyAssembliesWithReferencedTypesEndUpBeingReferencedIncludingGenerics():
		
		expected = ("Boo.Lang", "mscorlib", "UnityScript", "UnityScript.Tests")
		code = """
		var foo = new Boo.Lang.List.<String>();
		eval("print(\"hello\")");
		"""
		AssertAssemblyReferencesForEval expected, code
		
	def AssertAssemblyReferencesForEval(expected as (string), code as string):
		
		result = CompileTestCase(StringInput("t$(++_testId).js", code))
		assert len(result.Errors) == 0, result.Errors.ToString()
		
		actual = array(assemblyName.Name for assemblyName in Assembly.LoadFrom(Parameters.OutputAssembly).GetReferencedAssemblies())
		Array.Sort(actual)
		Assert.AreEqual(expected, actual)
		
	_testId = 0
		
