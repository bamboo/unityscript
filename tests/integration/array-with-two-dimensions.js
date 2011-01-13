/*
System.Int32[,]
2
3
*/
var a:int[,] = new int[2, 3];
print(a.GetType());
for (var i=0; i<a.Rank; ++i)
	print(a.GetLength(i));
