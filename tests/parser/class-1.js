/*
class Person:

	private _name as string

	private _age as int

	def constructor(name as string, age as int):
		_name = name
		_age = age

	Name:
		get:
			return _name
		set:
			_name = value

	Age:
		get:
			return _age

	def ToString() as string:
		return ((_name + ', ') + _age)

	static def StaticFunction():
		pass

p as Person = Person('Eric Idle', 42)

print(p.ToString())
*/

class Person {
	private var _name:string;
	private var _age:int;
	
	function Person(name:string, age:int) {
		_name = name;
		_age = age;
	}
	
	function get Name() {
		return _name;
	}
	
	function set Name(value) {
		_name = value;
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
