/*
0, 1
0, 2
1, 0
1, 2
*/
var breakOut = 0; // to break out of the look if necessary
for (var i=0; i<2; ++i) {
	for (var j=0; j<3; ++j) {
		if (++breakOut > 10) break;
		if (j == i) continue;
		print("" + i + ", " + j);
	}
}
