/*
1
2
3
outside the loop
default
*/
function foo(value) {
	switch (value) {
		case 1: 
		var i = 0;
		while (true) {
			if (i > 2) break;
			++i;
			print(i);
		}		
		print("outside the loop");
		break;
		
		default :
		print("default");
	}
}

foo(1);
foo(2);