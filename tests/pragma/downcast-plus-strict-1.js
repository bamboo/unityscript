/*
Bar
*/
#pragma strict
#pragma downcast

class Foo {
}

class Bar extends Foo {
}

var foo:Foo = new Bar();
var bar:Bar = foo;
print(bar);