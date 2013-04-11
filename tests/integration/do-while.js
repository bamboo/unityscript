/*
0
1
10
11
100
100, 0
100, 1
***
101
101, 0
101, 1
***
*/
var i = 0;
do {
	print(i);
} while (++i < 2);

i = 10;
do {
	print(i);
	if (++i >= 12) break;
} while (true);

i = 100;
do {
	print(i);
	var j = 0;
	do {
		print(i + ", " + j);
		if (++j >= 2) break;
	} while (true);
	print("***");
} while (++i < 102);


