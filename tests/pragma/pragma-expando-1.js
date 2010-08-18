/*
MissingMemberException
*/
var o = new Object();
try {
	o.SomeProperty = 42;
	print("should NOT get here without #pragma expando");
} catch (x : System.MissingMemberException) {
	print("MissingMemberException");
}
