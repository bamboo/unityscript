
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class PragmaTestFixture(AbstractIntegrationTestFixture):

	[Test]
	def implicit_1():
		RunTestCase("tests/pragma/implicit-1.js")
		
	[Test]
	def implicit_plus_strict():
		RunTestCase("tests/pragma/implicit-plus-strict.js")
		