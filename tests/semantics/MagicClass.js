/*
import UnityScript.Tests

public class AnotherMagicClass(UnityScript.Tests.MonoBehaviour):

	public def constructor():
		super()

partial public class MagicClass(AnotherMagicClass):

	public virtual def foo() as void:
		pass

	public virtual def bar() as void:
		pass

	public def constructor(value as Object):
		super()

	public virtual def Awake() as void:
		pass
*/
class AnotherMagicClass extends MonoBehaviour {
}

class MagicClass extends AnotherMagicClass {
	function foo() {
	}
}

function bar() {
}

function MagicClass(value) {
}