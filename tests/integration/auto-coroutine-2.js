/*
done
*/

// Negative tests to make sure the coroutine detection is not too overeager

class Greeter {
	function Hello(a: int, b: int) {
		print(a);
		yield;
	}
	
	static function StaticHello(a: int, b: int) {
		print (a);
		yield;
	}
}

// does nothing
var t = Greeter();
t.Hello(1, 2);

Greeter.StaticHello(1, 2);

print ("done");