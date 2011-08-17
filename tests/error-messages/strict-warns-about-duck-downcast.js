/*
strict-warns-about-duck-downcast.js(9,5): BCW0028: WARNING: Implicit downcast from 'Object' to 'String'.
*/

#pragma strict

var duck;
var s : String;
s = duck;
print(s);
