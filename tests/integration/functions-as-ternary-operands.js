/*
foo
bar
foo
bar
*/
function choose(value) {
	var f = value ? f1 : f2;
	f();
}

function invoke(value) {
	(value ? f1 : f2)();
}

function f1() { print('foo'); }
function f2() { print('bar'); }

choose(true);
choose(false);

invoke(true);
invoke(false);
