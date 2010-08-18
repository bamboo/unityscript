/*
F(float, float)
*/

#pragma strict
#pragma downcast

function F(a:float, b:float) { print("F(float, float)"); }
function F(a:int, b:int) {}
F(0.16, 0.19);
