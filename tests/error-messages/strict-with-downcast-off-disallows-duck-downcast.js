/*
strict-with-downcast-off-disallows-duck-downcast.js(10,5): BCE0022: Cannot convert 'Object' to 'String'.
*/

#pragma strict
#pragma downcast off

var duck;
var s : String;
s = duck;
print(s);
