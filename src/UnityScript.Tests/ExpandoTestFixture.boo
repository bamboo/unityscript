
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class ExpandoTestFixture(AbstractIntegrationTestFixture):
	
	override def CreateCompiler():
		compiler = super()
		compiler.Parameters.Expando = true
		return compiler

	[Test]
	def expando_1():
		RunTestCase("tests/expando/expando-1.js")
		
	[Test]
	def expando_2():
		RunTestCase("tests/expando/expando-2.js")
		
	[Test]
	def expando_gc_3():
		RunTestCase("tests/expando/expando-gc-3.js")
		