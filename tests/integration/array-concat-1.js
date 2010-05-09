/*
a
b
c
0
1
2
3
3
6
*/
var alpha_array = new Array("a","b","c");
var numeric_array = new Array(0,1,2);
var alphaNumeric_array = alpha_array.concat(numeric_array); 

print ( alphaNumeric_array[0] );
print ( alphaNumeric_array[1] );
print ( alphaNumeric_array[2] );
print ( alphaNumeric_array[3] );
print ( alphaNumeric_array[4] );
print ( alphaNumeric_array[5] );
print ( alpha_array.length );
print ( numeric_array.length );
print ( alphaNumeric_array.length );
