/*
1
after 1
2
after 2
0
after 0
*/
function spam()
{
	yield 1;
	transform.position.x += 1;
	print("after 1");
	yield 2;
	transform.position.x += 1;
	print("after 2");
	yield;
	print("after 0");
}

for (var e in spam())
{
	print(e);
}