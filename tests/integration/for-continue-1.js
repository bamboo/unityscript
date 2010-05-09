/*
1
3
5
7
9
*/
var breakOut = 0; // to break out of the look if necessary
for (var i=0; i<10; ++i) {
	if (++breakOut > 10) break;
	if (0 == i % 2) continue;
	print(i);
}
