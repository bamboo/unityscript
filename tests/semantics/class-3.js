/*
import UnityScript.Tests

public class Person(Object):

	public _name as String

	private _age as int

	public def constructor(name as String, age as int):
		super()
		self._name = name
		self._age = age

	public Name as String:
		public virtual get:
			return self._name

	public Age as int:
		public virtual get:
			return self._age

	public override def ToString() as String:
		return Boo.Lang.Runtime.RuntimeServices.op_Addition(Boo.Lang.Runtime.RuntimeServices.op_Addition(self._name, ', '), self._age)

	public static def StaticFunction() as void:
		pass

partial public class class-3(UnityScript.Tests.MonoBehaviour):

	public p as Person

	public virtual def Awake() as void:
		Boo.Lang.Builtins.print(self.p.ToString())

	public def constructor():
		super()
		self.p = Person('Eric Idle', 42)
*/

class Person {
	var _name:String;
	private var _age:int;
	
	function Person(name:String, age:int) {
		_name = name;
		_age = age;
	}
	
	function get Name() {
		return _name;
	}
	
	function get Age() {
		return _age;
	}
	
	function ToString() : String {
		return _name + ", " + _age;
	}
	
	static function StaticFunction() {
	}
}

var p : Person = new Person("Eric Idle", 42);
print(p.ToString());
