/*
pragma-strict-4.js(13,15): BCE0022: Cannot convert 'Foo' to 'Bar'.
*/
#pragma strict

class Foo {
}

class Bar extends Foo {
}

var foo:Foo = new Bar();
var bar:Bar = foo;
