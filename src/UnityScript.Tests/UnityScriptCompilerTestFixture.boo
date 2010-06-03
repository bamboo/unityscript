namespace UnityScript.Tests

import UnityScript
import Boo.Lang.Compiler
import Boo.Lang.Compiler.IO
import Boo.Lang.Compiler.Steps
import NUnit.Framework

class BaseClass:

	[Boo.Lang.Extensions.Property(ComputedValue)]
	_value as object

[TestFixture]
class UnityScriptCompilerTestFixture:
	
	compiler as UnityScriptCompiler
	
	[SetUp]
	def SetUpCompiler():
		compiler = UnityScriptCompiler()
		compiler.Parameters.Pipeline = UnityScriptCompiler.Pipelines.CompileToMemory()
		compiler.Parameters.ScriptBaseType = BaseClass
		compiler.Parameters.ScriptMainMethod = "Awake"
		
	[Test]
	def DefaultCompilerParameters():
		assert compiler.Parameters.Ducky
		assert CompilerOutputType.Library == compiler.Parameters.OutputType
		
	[Test]
	def ScriptBaseTypeAndMainMethod():
		type = CompileScriptType("ComputedValue = 42;")
		assert BaseClass is type.BaseType
		
		b as duck = type()
		b.Awake()
		assert 42 == b.ComputedValue
		
	[Test]
	def ExeEntryPoint():
		compiler.Parameters.OutputType = CompilerOutputType.ConsoleApplication
		type = CompileScriptType("public static function Main(argv: String[]): void {}")
		Assert.AreSame(type.GetMethod("Main"), type.Assembly.EntryPoint)
		
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
		
	def CompileScriptType(script as string):
		result = CompileScript(script)
		return result.GeneratedAssembly.GetType("Script")
		
	def CompileScript(script as string, *defines as (string)):
		compiler.Parameters.Input.Clear()
		compiler.Parameters.Input.Add(StringInput("Script", script))
		
		compiler.Parameters.Defines.Clear()
		for define in defines:
			compiler.Parameters.Defines.Add(define, define)
		
		result = compiler.Run()
		Assert.AreEqual(0, len(result.Errors), result.Errors.ToString())
		return result
