/*
error-for-internal-used-as-identifier.js(8,5): UCE0007: 'internal' keyword cannot be used as an identifier.
error-for-internal-used-as-identifier.js(11,13): UCE0007: 'internal' keyword cannot be used as an identifier.
error-for-internal-used-as-identifier.js(14,12): UCE0007: 'internal' keyword cannot be used as an identifier.
error-for-internal-used-as-identifier.js(18,13): UCE0007: 'internal' keyword cannot be used as an identifier.
error-for-internal-used-as-identifier.js(21,10): UCE0007: 'internal' keyword cannot be used as an identifier.
*/
var internal = false;

function f() {
	var internal = false;
}

function g(internal: float) {
}

class C {
	var internal = false;
}

for (var internal in []) {
}

