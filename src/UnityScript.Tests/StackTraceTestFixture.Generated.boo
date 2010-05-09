
namespace UnityScript.Tests

import NUnit.Framework	

partial class StackTraceTestFixture:

	[Test]
	def stacktrace_1():
		RunTestCase("tests/stacktrace/stacktrace-1.js")
		
	[Test]
	def stacktrace_2():
		RunTestCase("tests/stacktrace/stacktrace-2.js")
		
	[Test]
	def stacktrace_3():
		RunTestCase("tests/stacktrace/stacktrace-3.js")
		
	[Test]
	def stacktrace_4():
		RunTestCase("tests/stacktrace/stacktrace-4.js")
		
	[Test]
	def stacktrace_5():
		RunTestCase("tests/stacktrace/stacktrace-5.js")
		
	[Test]
	def stacktrace_6():
		RunTestCase("tests/stacktrace/stacktrace-6.js")
		