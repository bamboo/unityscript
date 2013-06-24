/*
cannot-convert-enum-to-float.js(5,27): BCE0022: Cannot convert 'E' to 'float'.
*/
enum E { E0 };
var implicitly: float = E.E0;
var explicitly = E.E0 cast float;
