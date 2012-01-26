
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class PragmaTestFixture(AbstractIntegrationTestFixture):

	
	[Test] def downcast_plus_strict_1():
		RunTestCase("tests/pragma/downcast-plus-strict-1.js")
		
	
	[Test] def downcast_plus_strict_for_arrays():
		RunTestCase("tests/pragma/downcast-plus-strict-for-arrays.js")
		
	
	[Test] def downcast_plus_strict_for_each_in_arrays():
		RunTestCase("tests/pragma/downcast-plus-strict-for-each-in-arrays.js")
		
	
	[Test] def implicit_1():
		RunTestCase("tests/pragma/implicit-1.js")
		
	
	[Test] def implicit_plus_strict():
		RunTestCase("tests/pragma/implicit-plus-strict.js")
		
	
	[Test] def pragma_checked_1():
		RunTestCase("tests/pragma/pragma-checked-1.js")
		
	
	[Test] def pragma_expando_1():
		RunTestCase("tests/pragma/pragma-expando-1.js")
		
	
	[Test] def pragma_expando_2():
		RunTestCase("tests/pragma/pragma-expando-2.js")
		