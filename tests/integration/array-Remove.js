/*
0
1
3
---
1
3
*/
var array = Array();
array.Add(0);
array.Add(1);
array.Add(2);
array.Add(3);
array.RemoveAt(2);

print (array[0]);
print (array[1]);
print (array[2]);
print ("---");

array.Remove(0);
print (array[0]);
print (array[1]);