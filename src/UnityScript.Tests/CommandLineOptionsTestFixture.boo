namespace UnityScript.Tests

import NUnit.Framework

[TestFixture]
class CommandLineOptionsTestFixture:

	[Test]
	def Defines():
		options = us.CommandLineOptions("-d:FOO", "--define:BAR")
		assert options.Defines == ["FOO", "BAR"]