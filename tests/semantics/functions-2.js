/*
import UnityScript.Tests

partial class functions-2(UnityScript.Tests.MonoBehaviour):

	public value = 1

	private def spam(thirdValue):
		return ((value + 2) + thirdValue)

	private def eggs():
		print(spam(3))

	public virtual def Awake():
		eggs()	
*/

var value = 1;

private function spam(thirdValue) {
	return value + 2 + thirdValue;
}

private function eggs() {
	print(spam(3));
}

eggs();