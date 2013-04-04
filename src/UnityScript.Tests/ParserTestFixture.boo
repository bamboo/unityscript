namespace UnityScript.Tests

import UnityScript
import Boo.Lang.Compiler
import Boo.Lang.Compiler.IO
import NUnit.Framework

[TestFixture]
partial class ParserTestFixture(AbstractCompilerTestFixture):

	override protected def CreateCompilerPipeline():
		pipeline = CompilerPipeline()
		pipeline.Add(UnityScript.Steps.Parse())
		return pipeline
		
	[Test]
	def EmptyFile():
		result = CompileTestCase(StringInput("empty", ""))
		Assert.AreEqual(0, len(result.Errors), result.Errors.ToString(true))
		Assert.AreEqual(1, len(result.CompileUnit.Modules))
		
		module = result.CompileUnit.Modules[0]
		Assert.AreEqual("empty", module.Name)
		Assert.AreEqual("empty", module.LexicalInfo.FileName)
		
		
