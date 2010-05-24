
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class PragmaTestFixture(AbstractIntegrationTestFixture):

	[Test]
	def downcast_plus_strict_1():
		RunTestCase("tests/pragma/downcast-plus-strict-1.js")
		
	[Test]
	def downcast_plus_strict_for_arrays():
		RunTestCase("tests/pragma/downcast-plus-strict-for-arrays.js")
		
	[Test]
	def implicit_1():
		RunTestCase("tests/pragma/implicit-1.js")
		
	[Test]
	def implicit_plus_strict():
		RunTestCase("tests/pragma/implicit-plus-strict.js")
		