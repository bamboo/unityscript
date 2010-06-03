/*
import UnityScript.Tests

class Person:

	public _name as string

	private _age as int

	public def constructor(name as string, age as int):
		_name = name
		_age = age

	Name:
		public virtual get:
			return _name

	Age:
		public virtual get:
			return _age

	public virtual def ToString() as string:
		return ((_name + ', ') + _age)

	public static def StaticFunction():
		pass

partial class class-3(UnityScript.Tests.MonoBehaviour):

	public p as Person = Person('Eric Idle', 42)

	public virtual def Awake():
		print(p.ToString())
*/

class Person {
	var _name:string;
	private var _age:int;
	
	function Person(name:string, age:int) {
		_name = name;
		_age = age;
	}
	
	function get Name() {
		return _name;
	}
	
	function get Age() {
		return _age;
	}
	
	function ToString() : string {
		return _name + ", " + _age;
	}
	
	static function StaticFunction() {
	}
}

var p : Person = new Person("Eric Idle", 42);
print(p.ToString());
