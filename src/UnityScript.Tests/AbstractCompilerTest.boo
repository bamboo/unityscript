namespace UnityScript.Tests

import System.IO
import NUnit.Framework
import UnityScript
import Boo.Lang.Compiler

abstract class AbstractCompilerTest:
	
	_compiler as UnityScriptCompiler
	
	Parameters:
		get: return _compiler.Parameters
		
	OutputAssemblyPath:
		get: return Path.Combine(Path.Combine(Path.GetTempPath(), "UnityScript"), GetType().Name)
	
	[TestFixtureSetUp]
	virtual def SetUpFixture():		
		if Directory.Exists(OutputAssemblyPath): Directory.Delete(OutputAssemblyPath, true)
		Directory.CreateDirectory(OutputAssemblyPath)
		_compiler = CreateCompiler()
		
	virtual def CreateCompiler():
		compiler = UnityScriptCompiler()
		compiler.Parameters.ScriptBaseType = MonoBehaviour
		compiler.Parameters.ScriptMainMethod = "Awake"
		compiler.Parameters.Pipeline = CreateCompilerPipeline()
		compiler.Parameters.References.Add(typeof(AbstractCompilerTestFixture).Assembly)
		compiler.Parameters.References.Add(typeof(UnityScript.Tests.CSharp.FooBarEnum).Assembly)
		return compiler
		
	virtual def CompileTestCase(*inputs as (ICompilerInput)):
		SetCompilationOptions()
		for input in inputs: Parameters.Input.Add(input)
		Parameters.OutputAssembly = Path.Combine(OutputAssemblyPath, GetType().Name + "-" + Path.GetFileNameWithoutExtension(Parameters.Input[0].Name) + ".exe")
		return _compiler.Run()
		
	virtual def SetCompilationOptions():
		Parameters.Input.Clear()
		Parameters.Strict = false
		
	protected abstract def CreateCompilerPipeline() as CompilerPipeline:
		pass
		

