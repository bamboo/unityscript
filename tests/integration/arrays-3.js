/*
null
null
null
3
3
*/
// Array with 3 null elements
var test  = Array (3);
for (var t=0;t<test.length;t++)
{
	if (test[t] == null)
		print ("null");
}

print(test.length);
// For backwards compatibility also keep the C# interface
print(test.Count);