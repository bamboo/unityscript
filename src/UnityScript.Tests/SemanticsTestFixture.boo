
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class SemanticsTestFixture(AbstractSemanticsTestFixture):

	
	[Test] def EmptyFileBegetsEmptyBehaviour():
		RunTestCase("tests/semantics/EmptyFileBegetsEmptyBehaviour.js")
		
	
	[Test] def Magic2Class():
		RunTestCase("tests/semantics/Magic2Class.js")
		
	
	[Test] def MagicClass():
		RunTestCase("tests/semantics/MagicClass.js")
		
	
	[Test] def class_3():
		RunTestCase("tests/semantics/class-3.js")
		
	
	[Test] def coroutine():
		RunTestCase("tests/semantics/coroutine.js")
		
	
	[Test] def fields_1():
		RunTestCase("tests/semantics/fields-1.js")
		
	
	[Test] def functions_2():
		RunTestCase("tests/semantics/functions-2.js")
		
	
	[Test] def magic_members():
		RunTestCase("tests/semantics/magic-members.js")
		
	
	[Test] def single_update_function():
		RunTestCase("tests/semantics/single-update-function.js")
		
	
	[Test] def variables():
		RunTestCase("tests/semantics/variables.js")
		