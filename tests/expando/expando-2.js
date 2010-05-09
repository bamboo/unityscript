/*
Item.set_FirstName
Item.get_FirstName
John Cleese
*/
class Item {
	
	private var _fname;
	
	function get FirstName() {
		print("Item.get_FirstName");
		return _fname;
	}
	
	function set FirstName(value) {
		print("Item.set_FirstName");
		_fname = value;
	}
}
var obj = new Item();
obj.FirstName = "John"; // statically bound
obj.LastName = "Cleese"; // dynamically bound
print(obj.FirstName + " " + obj.LastName);
