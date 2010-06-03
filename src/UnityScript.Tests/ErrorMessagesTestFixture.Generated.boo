
namespace UnityScript.Tests

import NUnit.Framework
	
partial class ErrorMessagesTestFixture:

	[Test]
	def array_struct_warning():
		RunTestCase("tests/error-messages/array-struct-warning.js")
		
	[Test]
	def builtins():
		RunTestCase("tests/error-messages/builtins.js")
		
	[Test]
	def cannot_convert_error():
		RunTestCase("tests/error-messages/cannot-convert-error.js")
		
	[Test]
	def conditional_compilation_with_pragma_strict():
		RunTestCase("tests/error-messages/conditional-compilation-with-pragma-strict.js")
		
	[Test]
	def error_for_final_used_as_identifier():
		RunTestCase("tests/error-messages/error-for-final-used-as-identifier.js")
		
	[Test]
	def implicit_main_shouldnt_be_redefined():
		RunTestCase("tests/error-messages/implicit-main-shouldnt-be-redefined.js")
		
	[Test]
	def incompatible_initializer_1():
		RunTestCase("tests/error-messages/incompatible-initializer-1.js")
		
	[Test]
	def inner_text():
		RunTestCase("tests/error-messages/inner_text.js")
		
	[Test]
	def interface_errors():
		RunTestCase("tests/error-messages/interface-errors.js")
		
	[Test]
	def iterator_warning():
		RunTestCase("tests/error-messages/iterator-warning.js")
		
	[Test]
	def missing_brace():
		RunTestCase("tests/error-messages/missing-brace.js")
		
	[Test]
	def nolinenumber():
		RunTestCase("tests/error-messages/nolinenumber.js")
		
	[Test]
	def obsolete_2():
		RunTestCase("tests/error-messages/obsolete-2.js")
		
	[Test]
	def obsolete():
		RunTestCase("tests/error-messages/obsolete.js")
		
	[Test][Ignore("requires new parser infrastructure")]
	def overeager_semicolon():
		RunTestCase("tests/error-messages/overeager-semicolon.js")
		
	[Test][Ignore("requires new parser infrastructure")]
	def overeager_semicolon2():
		RunTestCase("tests/error-messages/overeager-semicolon2.js")
		
	[Test]
	def pragma_strict_2():
		RunTestCase("tests/error-messages/pragma-strict-2.js")
		
	[Test]
	def pragma_strict_3js():
		RunTestCase("tests/error-messages/pragma-strict-3js.js")
		
	[Test]
	def pragma_strict_4():
		RunTestCase("tests/error-messages/pragma-strict-4.js")
		
	[Test]
	def pragma_strict():
		RunTestCase("tests/error-messages/pragma-strict.js")
		
	[Test]
	def semicolon_2():
		RunTestCase("tests/error-messages/semicolon-2.js")
		
	[Test]
	def semicolon():
		RunTestCase("tests/error-messages/semicolon.js")
		
	[Test]
	def unused_variable():
		RunTestCase("tests/error-messages/unused-variable.js")
		
	[Test]
	def virtual_warning():
		RunTestCase("tests/error-messages/virtual-warning.js")
		
	[Test]
	def void_declaration():
		RunTestCase("tests/error-messages/void-declaration.js")
		
	[Test]
	def void_in_hashtable():
		RunTestCase("tests/error-messages/void-in-hashtable.js")
		
	[Test]
	def voidcomparison():
		RunTestCase("tests/error-messages/voidcomparison.js")
		