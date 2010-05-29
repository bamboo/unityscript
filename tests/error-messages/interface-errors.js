/*
interface-errors.js(8,19): UCE0006: 'Foo' is not a class. 'extends' can only be used with classes. Did you mean 'implements'?
interface-errors.js(11,22): UCE0005: 'Bar' is not an interface. 'implements' can only be used with interfaces. Did you mean 'extends'?
*/
interface Foo {
}

class Bar extends Foo {
}

class Baz implements Bar {
}
