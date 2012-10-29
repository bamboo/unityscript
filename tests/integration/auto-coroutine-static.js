/*
Received coroutine
1
*/
StaticHello(1, 2);

static function StaticHello(a: int, b: int) {
	print(a);
	yield;
}
