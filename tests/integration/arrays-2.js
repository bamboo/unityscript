/*
0
1
2
3
4
5
*/
// array with elements 0, 1, 2
var test  = Array (0, 1, 2);
// automatic resizing on assignment
// @TODO: We should make sure it will give a runtime exception when reading an out of bounds index
test[3] = 3;
test[5] = 5;	
test[4] = 4;	

for (var t in test)
	print(t);