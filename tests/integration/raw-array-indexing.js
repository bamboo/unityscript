/*
caught!
*/
import System;

var array = new int[2];
try {
	print(array[-1]);
} catch (e: IndexOutOfRangeException) {
	print("caught!");
}
