
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class GenericsTestFixture(AbstractIntegrationTestFixture):

	[Test]
	def generic_list_instantiation_1():
		RunTestCase("tests/generics/generic-list-instantiation-1.js")
		
	[Test]
	def generic_method_1():
		RunTestCase("tests/generics/generic-method-1.js")
		