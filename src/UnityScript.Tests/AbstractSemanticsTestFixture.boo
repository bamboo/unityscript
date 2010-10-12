namespace UnityScript.Tests

import NUnit.Framework

class AbstractSemanticsTestFixture(AbstractCompilerTestFixture):

	[TestFixtureSetUp]
	override def SetUpFixture():
		super()
		_compiler.Parameters.Imports.Add("UnityScript.Tests")
		
	override protected def CreateCompilerPipeline():
		return UnityScript.UnityScriptCompiler.Pipelines.Parse()
