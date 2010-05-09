/*
0
bmw,volvo
bmw
volvo
ole
3.23
*/

import System.Globalization;

var array = new Array();
array.push(0);
array.push( Array("bmw", "volvo") );
array.push("ole");
array.push(3.23);

print (array[0]);
print (array[1]);
print (array[1][0]);
print (array[1][1]);
print (array[2]);
print (array[3]);