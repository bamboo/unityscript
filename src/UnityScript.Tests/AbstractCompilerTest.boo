namespace UnityScript.Tests

import NUnit.Framework
import UnityScript
import Boo.Lang.Compiler

abstract class AbstractCompilerTest:
	
	_compiler as UnityScriptCompiler
	
	Parameters:
		get: return _compiler.Parameters
	
	[TestFixtureSetUp]
	virtual def SetUpFixture():		
		_compiler = CreateCompiler()
		
	virtual def CreateCompiler():
		compiler = UnityScriptCompiler()
		compiler.Parameters.Ducky = true
		compiler.Parameters.ScriptBaseType = MonoBehaviour
		compiler.Parameters.ScriptMainMethod = "Awake"
		compiler.Parameters.Pipeline = CreateCompilerPipeline()
		compiler.Parameters.References.Add(typeof(AbstractCompilerTestFixture).Assembly)
		compiler.Parameters.References.Add(typeof(Assert).Assembly)
		compiler.Parameters.References.Add(typeof(UnityScript.Tests.CSharp.FooBarEnum).Assembly)
		return compiler
		
	virtual def CompileTestCase([required] input as ICompilerInput):
		Parameters.Input.Clear()
		Parameters.Input.Add(input)
		return _compiler.Run()
		
	protected abstract def CreateCompilerPipeline() as CompilerPipeline:
		pass
		

