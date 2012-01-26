/*
overflow!
*/
#pragma checked

try {
	var mv: int = int.MaxValue;
	var i = mv + 1;
	print(i);
} catch (e: System.OverflowException) {
	print("overflow!");
}
