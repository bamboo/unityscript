/*
1st
1st
1st
2nd
2nd
2nd
nah
*/
function printVersePos(value) {
	switch (value) {
		case "a":
		case "b":
		case "c":
			print("1st");
			break;
			
		case "1":
		case "2":
		case "3":
			print("2nd");
			break;
			
		default:
			print("nah");
			break;
	}
}

for (var i in ["a", "b", "c", "1", "2", "3", "do"])
	printVersePos(i);



