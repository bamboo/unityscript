/*
Item(42)
*/
class Item {
	public var value;
	
	public function Item(value) {
		this.value = value;
	}
	
	public function ToString() : String {
		return "Item(" + value + ")";
	}
}

var item : Item;
eval("item = Item(42);");
print(item);
