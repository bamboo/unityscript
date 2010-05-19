#pragma strict

function foo() {
	i = 42; // would usually fail in strict mode, unless '#pragma implicit' has been enabled through the command line
	return i;
}
