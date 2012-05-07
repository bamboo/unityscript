namespace UnityScript.Tests

import UnityScript
import NUnit.Framework

[TestFixture]
class UnityScriptCompilerParametersTest:
	
	[Test]
	def PragmaDowncastCanBeDisabled():
		
		Assert.AreEqual(0, UnityScriptCompilerParameters(false).References.Count)
