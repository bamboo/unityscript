/*
True
True
True
True
Pair(foo, bar)
*/
class Pair extends System.ValueType {
	var First: Object;
	var Second: Object;
	
	function Pair(fst, snd) {
		First = fst;
		Second = snd;
	}
	
	override function ToString() {
		return "Pair(" + First + ", " + Second + ")";
	}
}

var type = Pair;
print(type.IsValueType);
print(type.IsSealed);
for (var field in ["First", "Second"])
	print(type.GetField(field).IsPublic);
print(new Pair("foo", "bar"));
