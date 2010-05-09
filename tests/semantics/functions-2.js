/*
import UnityScript.Tests

partial class functions-2(UnityScript.Tests.MonoBehaviour):

	public value = 1

	def spam(thirdValue):
		return ((value + 2) + thirdValue)

	def eggs():
		print(spam(3))

	public def Awake():
		eggs()	
*/

var value = 1;

function spam(thirdValue) {
	return value + 2 + thirdValue;
}

function eggs() {
	print(spam(3));
}

eggs();