/*
function-type-name.js(18,4): BCE0019: 'Foo' is not a member of 'function(): void'. 
function-type-name.js(21,4): BCE0019: 'Foo' is not a member of 'function(int): void'. 
function-type-name.js(24,4): BCE0019: 'Foo' is not a member of 'function(function(): int): int'.
*/
#pragma strict

function Bar() {
}

function Baz(i: int) {
}

function Gazong(f: function():int): int {
}

var f1 = Bar;
f1.Foo();

var f2 = Baz;
f2.Foo();

var f3 = Gazong;
f3.Foo();