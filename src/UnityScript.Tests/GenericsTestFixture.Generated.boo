
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class GenericsTestFixture(AbstractIntegrationTestFixture):

	
	[Test] def generic_list_instantiation_1():
		RunTestCase("tests/generics/generic-list-instantiation-1.js")
		
	
	[Test] def generic_method_1():
		RunTestCase("tests/generics/generic-method-1.js")
		
	
	[Test] def generic_method_arguments_in_generic_class():
		RunTestCase("tests/generics/generic-method-arguments-in-generic-class.js")
		
	
	[Test] def generic_method_arguments():
		RunTestCase("tests/generics/generic-method-arguments.js")
		
	
	[Test] def generic_method_overload_in_base_class():
		RunTestCase("tests/generics/generic-method-overload-in-base-class.js")
		