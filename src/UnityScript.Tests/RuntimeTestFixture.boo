namespace UnityScript.Tests

import NUnit.Framework
import UnityScript.Lang

[TestFixture]
class RuntimeTestFixture:

	[Test]
	def TestGetUpdateableEnumerator():
		a = (1, 2, 3)
		e = UnityRuntimeServices.GetEnumerator(a)
		while e.MoveNext():
			item as int = e.Current
			item *= 2
			UnityRuntimeServices.Update(e, item)
		
		Assert.AreEqual("2 4 6", join(a))