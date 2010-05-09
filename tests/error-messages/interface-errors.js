/*
interface-errors.js(8,19): UCE0006: 'Foo' is not a class.
interface-errors.js(11,22): UCE0005: 'Bar' is not an interface.
*/
interface Foo {
}

class Bar extends Foo {
}

class Baz implements Bar {
}
