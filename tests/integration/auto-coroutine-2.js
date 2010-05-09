/*
done
*/

// Negative tests to make sure the coroutine detection is not too overeager

class Greeter
{
	function Hello (a : int, b : int)
	{
		print (a);
		yield;
	}
}

// does nothing
var t = Greeter();
t.Hello(1, 2);

// does nothing
StaticHello(1, 2);

static function StaticHello (a : int, b : int)
{
	print (a);
	yield;
}

print ("done");