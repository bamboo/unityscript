
namespace UnityScript.Tests

import NUnit.Framework

partial class ProjectIntegrationTestFixture:

	
	[Test] def ducky_mixed_with_pragma_strict():
		RunTestCase("tests/projects/ducky-mixed-with-pragma-strict")
		
	
	[Test] def interfaces():
		RunTestCase("tests/projects/interfaces")
		