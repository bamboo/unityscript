/*
error-for-final-used-as-identifier.js(8,5): UCE0007: 'final' keyword cannot be used as an identifier.
error-for-final-used-as-identifier.js(11,13): UCE0007: 'final' keyword cannot be used as an identifier.
error-for-final-used-as-identifier.js(14,12): UCE0007: 'final' keyword cannot be used as an identifier.
error-for-final-used-as-identifier.js(18,13): UCE0007: 'final' keyword cannot be used as an identifier.
error-for-final-used-as-identifier.js(21,10): UCE0007: 'final' keyword cannot be used as an identifier.
*/
var final = false;

function f() {
	var final = false;
}

function g(final: float) {
}

class C {
	var final = false;
}

for (var final in []) {
}

