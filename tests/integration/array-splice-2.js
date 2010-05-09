/*
roses
hello
World
orchids
4
*/
var array = new Array("roses", "tulips", "lilies", "orchids");

array.splice(1,2, "hello", "World" );
print ( array[0] );
print ( array[1] );
print ( array[2] );
print ( array[3] );
print ( array.length );