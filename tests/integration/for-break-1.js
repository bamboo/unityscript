/*
0
	0
1
	0
	1
2
*/
for (var i=0; i<3; ++i) {
	for (var j=0; j<3; ++j) {
		if (j == i) break;
		print("\t" + j);
	}
	print(i);
}
