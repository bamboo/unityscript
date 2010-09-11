/*
System.Int32[]
[0, 2, 4]
System.Int32[]
[1, 3, 5]
*/

function printArray(a: int[]) {
	print("[" + String.Join(", ", [i.ToString() for (i in a)]) + "]");
}

var doubles = [i*2 for (i in range(0, 3))];
var odds = [i for (i in range(0, 6)) if (i % 2 != 0)];

print(doubles.GetType());
printArray(doubles);

print(odds.GetType());
printArray(odds);
