/*
strict-warns-about-downcast.js(14,15): BCW0028: WARNING: Implicit downcast from 'Foo' to 'Bar'.
strict-warns-about-downcast.js(17,10): BCW0028: WARNING: Implicit downcast from 'Foo' to 'Bar'.
*/
#pragma strict

class Foo {
}

class Bar extends Foo {
}

var foo:Foo = new Bar();
var bar:Bar = foo;
var foos:Foo[] = [];

for (var b: Bar in foos)
	print(b);
