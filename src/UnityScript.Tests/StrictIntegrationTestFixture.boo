
namespace UnityScript.Tests

import NUnit.Framework
	
partial class StrictIntegrationTestFixture(AbstractIntegrationTestFixture):
			
	override def CreateCompilerPipeline():
		pipeline = super()
		pipeline.InsertAfter(UnityScript.Steps.Parse, UnityScript.Steps.IntroducePragmas((UnityScript.Core.Pragmas.Strict,)))
		return pipeline