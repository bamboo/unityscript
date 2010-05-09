namespace UnityScript.Tests

import Boo.Lang.Compiler
import NUnit.Framework

class AbstractSemanticsTestFixture(AbstractCompilerTestFixture):

	[TestFixtureSetUp]
	override def SetUpFixture():
		super()
		_compiler.Parameters.Imports.Add("UnityScript.Tests")
		
	override protected def CreateCompilerPipeline():
		pipeline = CompilerPipeline()
		pipeline.Add(UnityScript.Steps.Parse())
		pipeline.Add(Boo.Lang.Compiler.Steps.InitializeTypeSystemServices())
		pipeline.Add(Boo.Lang.Compiler.Steps.PreErrorChecking())
		pipeline.Add(UnityScript.Steps.ApplySemantics())
		return pipeline
