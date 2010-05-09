/*
0
1
2
3
*/
import System.Collections;

function main() {
	// Converting from array list and typed builtin arrays
	var list = new ArrayList();
	list.Add (0);
	
	var test = new Array(list);
	print (test[0]);
	
	test = new Array ([1, 2, 3]);
	print (test[0]);
	print (test[1]);
	print (test[2]);
}

main();