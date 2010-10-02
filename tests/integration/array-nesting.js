/*
System.Int32[][]
1
2
3
4
System.String[][]
foo
bar
baz
*/
function dump(a) {
	print(a.GetType());
	for (var nested in a) 
		for (var i in nested) print(i);
}
	
var nestedInts = [[1, 2], [3, 4]];
dump(nestedInts);
dump([["foo", "bar"], ["baz"]]);
