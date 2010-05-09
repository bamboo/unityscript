namespace UnityScript.Tests

import UnityScript
import Boo.Lang.Compiler
import Boo.Lang.Compiler.IO
import Boo.Lang.Compiler.Steps
import NUnit.Framework

class BaseClass:

	[Boo.Lang.Extensions.Property(ComputedValue)]
	_value as object
	
	abstract def Foo():
		pass

[TestFixture]
class UnityScriptCompilerTestFixture:
	
	compiler as UnityScriptCompiler
	
	[SetUp]
	def SetUpCompiler():
		compiler = UnityScriptCompiler()

	[Test]
	def DefaultCompilerParameters():
		assert compiler.Parameters.Ducky
		assert CompilerOutputType.Library == compiler.Parameters.OutputType
		
	[Test]
	def ScriptBaseTypeAndMainMethod():
		result = CompileScript("ComputedValue = 42;")
		type = result.GeneratedAssembly.GetType("Script")
		assert BaseClass is type.BaseType
		
		b as BaseClass = type()
		b.Foo()
		assert 42 == b.ComputedValue
		
	[Test]
	def ExeEntryPoint():
		compiler.Parameters.OutputType = CompilerOutputType.ConsoleApplication
		result = CompileScript("public static function Main(argv: String[]): void {}")
		generatedAssembly = result.GeneratedAssembly
		Assert.AreSame(generatedAssembly.GetType("Script").GetMethod("Main"), generatedAssembly.EntryPoint)
		
	[Test]
	def ModulesAreAnnotatedWithRawArrayIndexing():
		result = CompileScript("class Foo {}")
		for module in result.CompileUnit.Modules:
			assert AstAnnotations.IsRawIndexing(module)
		
	[Test]
	def ConditionalCompilation():
		script = """
#if FOO
class Foo {}
#else
class Bar {}
#endif
"""
		result = CompileScript(script, "FOO")
		Assert.IsNotNull(result.GeneratedAssembly.GetType("Foo"))
		Assert.IsNull(result.GeneratedAssembly.GetType("Bar"))
		
		result = CompileScript(script)
		Assert.IsNull(result.GeneratedAssembly.GetType("Foo"))
		Assert.IsNotNull(result.GeneratedAssembly.GetType("Bar"))
		
	def CompileScript(script as string, *defines as (string)):
		compiler.Parameters.Pipeline = UnityScriptCompiler.Pipelines.CompileToMemory()
		compiler.Parameters.ScriptBaseType = BaseClass
		compiler.Parameters.ScriptMainMethod = "Foo"
		
		compiler.Parameters.Input.Clear()
		compiler.Parameters.Input.Add(StringInput("Script", script))
		
		compiler.Parameters.Defines.Clear()
		for define in defines:
			compiler.Parameters.Defines.Add(define, define)
		
		result = compiler.Run()
		Assert.AreEqual(0, len(result.Errors), result.Errors.ToString())
		return result
