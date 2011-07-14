/*
import UnityScript.Tests

partial public class functions-2(UnityScript.Tests.MonoBehaviour):

	public value as int

	private def spam(thirdValue as Object) as System.Object:
		return Boo.Lang.Runtime.RuntimeServices.InvokeBinaryOperator('op_Addition', (self.value + 2), thirdValue)

	private def eggs() as void:
		Boo.Lang.Builtins.print(self.spam(3))

	public virtual def Awake() as void:
		self.eggs()

	public def constructor():
		super()
		self.value = 1
*/

var value = 1;

private function spam(thirdValue) {
	return value + 2 + thirdValue;
}

private function eggs() {
	print(spam(3));
}

eggs();