/*
strict-warns-about-array-downcast.js(10,23): BCW0028: WARNING: Implicit downcast from 'Object[]' to 'String[]'.
*/
#pragma strict

function foo(): Object[] {
	return new String[1];
}

var ss: String[] = foo();
