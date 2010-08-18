/*
done
*/

// Negative tests to make sure the coroutine detection is not too overeager

class Test
{
	function Hello (a : int, b : int)
	{
		print (a);
		yield;
	}
}

// does nothing
var t;
t = new Test();
t.Hello(1, 2);


var thisPtr : Object = this;

// does nothing
thisPtr.StaticHello(1, 2);

static function StaticHello (a : int, b : int)
{
	print (a);
	yield;
}

print ("done");