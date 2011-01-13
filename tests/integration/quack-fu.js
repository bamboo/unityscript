/*
Eric Idle
*/
class Expando implements Boo.Lang.IQuackFu {

	private var _attrs = {};
	
	function QuackGet(name: String, parameters: Object[]) {
		return _attrs[name];
	}
	
	function QuackSet(name: String, parameters: Object[], value) {
		_attrs[name] = value;
		return value;
	}
	
	function QuackInvoke(name: String, args: Object[]) {
		throw new System.NotImplementedException();
	}
}

var e = new Expando();
e.firstName = "Eric";
e.lastName = "Idle";
print(e.firstName + " " + e.lastName);
