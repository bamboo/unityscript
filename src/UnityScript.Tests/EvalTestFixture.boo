
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class EvalTestFixture(AbstractIntegrationTestFixture):

	[Test]
	def assembly_caching_1():
		RunTestCase("tests/eval/assembly-caching-1.js")
		
	[Test]
	def assembly_caching_2():
		RunTestCase("tests/eval/assembly-caching-2.js")
		
	[Test]
	def class_1():
		RunTestCase("tests/eval/class-1.js")
		
	[Test]
	def class_2():
		RunTestCase("tests/eval/class-2.js")
		
	[Test]
	def class_3():
		RunTestCase("tests/eval/class-3.js")
		
	[Test]
	def class_is_visible_1():
		RunTestCase("tests/eval/class-is-visible-1.js")
		
	[Test]
	def eval_in_static_function_1():
		RunTestCase("tests/eval/eval-in-static-function-1.js")
		
	[Test]
	def eval_in_static_function_2():
		RunTestCase("tests/eval/eval-in-static-function-2.js")
		
	[Test]
	def eval_in_static_function_3():
		RunTestCase("tests/eval/eval-in-static-function-3.js")
		
	[Test]
	def functions_1():
		RunTestCase("tests/eval/functions-1.js")
		
	[Test]
	def functions_2():
		RunTestCase("tests/eval/functions-2.js")
		
	[Test]
	def return_value_2():
		RunTestCase("tests/eval/return-value-2.js")
		
	[Test]
	def return_value_3():
		RunTestCase("tests/eval/return-value-3.js")
		
	[Test]
	def return_value():
		RunTestCase("tests/eval/return-value.js")
		
	[Test]
	def simple_1():
		RunTestCase("tests/eval/simple-1.js")
		
	[Test]
	def variable_initializer_doesnt_move():
		RunTestCase("tests/eval/variable-initializer-doesnt-move.js")
		
	[Test]
	def variables_1():
		RunTestCase("tests/eval/variables-1.js")
		
	[Test]
	def variables_2():
		RunTestCase("tests/eval/variables-2.js")
		
	[Test]
	def variables_3():
		RunTestCase("tests/eval/variables-3.js")
		
	[Test]
	def variables_4():
		RunTestCase("tests/eval/variables-4.js")
		
	[Test]
	def variables_5():
		RunTestCase("tests/eval/variables-5.js")
		