/*
Received coroutine
Enter Run
Received coroutine
Enter Do
*/

RunCoroutine();

function RunCoroutine ()
{
	print("Enter Run");
	
	yield Do();
}

function Do ()
{
	print("Enter Do");
	yield;
}