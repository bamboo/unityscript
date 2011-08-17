/*
Bar
*/
#pragma strict
#pragma downcast

class Foo {
}

class Bar extends Foo {
}

function useBar(bar: Bar) {
	print(bar);
}

var array: Array = [new Bar()];
for (var b: Bar in array)
	useBar(b);