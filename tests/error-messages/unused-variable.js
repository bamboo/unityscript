/*
unused-variable.js(11,7): BCW0003: WARNING: Unused local variable 'unused'.
unused-variable.js(15,7): BCW0003: WARNING: Unused local variable 'unused'.
unused-variable.js(19,7): BCW0003: WARNING: Unused local variable 'unused'.
*/
// Unused member variables should not give any warnings.
// This warning also shows up when the variable is used in a function.
var target : String;

function f() {
  var unused;
}

function g() {
  var unused: Object;
}

function h() {
  var unused = 42;
}
