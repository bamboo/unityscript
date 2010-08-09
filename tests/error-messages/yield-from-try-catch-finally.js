/*
yield-from-try-catch-finally.js(7,15): BCE0099: yield cannot be used inside a try, catch or finally block.
yield-from-try-catch-finally.js(8,21): BCE0099: yield cannot be used inside a try, catch or finally block.
yield-from-try-catch-finally.js(9,19): BCE0099: yield cannot be used inside a try, catch or finally block.
*/
function foo() {
	try { yield 42; }
	catch (e) { yield 42; }
	finally { yield 42; }
}

foo();
