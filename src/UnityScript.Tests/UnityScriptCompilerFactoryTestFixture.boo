namespace UnityScript.Tests

import NUnit.Framework
import us

[TestFixture]
class UnityScriptCompilerFactoryTestFixture:

	[Test]
	def Defines():
	
		options = CommandLineOptions(
						"-d:FOO", "--define:BAR",
						
						"-method:Awake", "-base:${typeof(MonoBehaviour).FullName}",
						"-r:${GetAssemblyLocation()}")
						
		compiler = UnityScriptCompilerFactory.FromCommandLineOptions(options)
		
		Assert.AreEqual(["FOO", "BAR"], [define for define in compiler.Parameters.Defines.Keys])

	