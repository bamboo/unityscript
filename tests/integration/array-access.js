/*
1
2
Hello
*/

var array = new int[5];
var array2 = new Array(0, 0, 0, 0);
var array3 = new String[5];

var thisObject;
thisObject = this;

thisObject.array[2] = 1;
print(thisObject.array[2]);


thisObject.array2[2] = 2;
print(thisObject.array2[2]);

thisObject.array3[2] = "Hello";
print(thisObject.array3[2]);