/*
cannot-start-coroutine-from-static-function.js(5,11): UCW0004: WARNING: Coroutine 'go' cannot be automatically started from a static function.
*/
static function f() {
	go();
}

static function go() {
	yield;
}