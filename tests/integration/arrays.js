/*
111
System.Int32[]
111
111
System.Int32[]
*/
var test : int[] = new int[5];
test[2] = 111;
print (test[2]);
print (test.GetType());

var test2 = new int[5];
test2[2] = 111;
print (test2[2]);

var test3 = [ 0, 0, 111 ];
test[2] = 111;
print (test3[2]);
print (test3.GetType());