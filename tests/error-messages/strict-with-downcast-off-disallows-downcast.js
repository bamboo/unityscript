/*
strict-with-downcast-off-disallows-downcast.js(14,15): BCE0022: Cannot convert 'Foo' to 'Bar'.
*/
#pragma strict
#pragma downcast off

class Foo {
}

class Bar extends Foo {
}

var foo:Foo = new Bar();
var bar:Bar = foo;
