/*
Bar[]
*/
#pragma strict
#pragma downcast

class Foo {
}

class Bar extends Foo {
}

function useBars(bars:Bar[]) {
	print(bars);
}

var foos:Foo[] = new Bar[0];
var bars:Bar[] = foos;
useBars(foos);