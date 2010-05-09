/*
Yes
Yes
Yes
Yes
*/
var c : char = "a"[0];
// Allow char vs string comparison
if (c == "a")
	print ("Yes");
	
for (var c:char in "a")
{
	if ("a" == c)
		print ("Yes");
}

var str : String = "Hello";
if (str[2] == "l")
	print ("Yes");
if (str[2] != "l")
	print ("No");
	
str = "booggie";
if (str[3] == "g")
	print ("Yes");
if (str[3] != "g")
	print ("NO");

