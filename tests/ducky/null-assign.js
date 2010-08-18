/*
Hello
*/

// Either this should not give a compile error and work
// exactly like normal ducktyped mode.
// Or it should give a compile error assigning null to a duck typed object.

var globalScript = null;
globalScript = this;

globalScript.Do();

function Do ()
{
	print("Hello");
}