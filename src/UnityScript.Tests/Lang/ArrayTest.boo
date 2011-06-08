namespace UnityScript.Tests.Lang

import NUnit.Framework

[TestFixture]
class ArrayTest:
	
	[Test]
	def Slice():
		fruits = UnityScript.Lang.Array() { "Banana", "Orange", "Apple", "Mango" }
		Assert.AreEqual("Banana", fruits.slice(0, 1).ToString())
		Assert.AreEqual("Orange,Apple,Mango", fruits.slice(1).ToString())
		Assert.AreEqual("Apple,Mango", fruits.slice(-2).ToString())
		Assert.AreEqual("Banana,Orange,Apple,Mango", fruits.ToString())
		



	
	
