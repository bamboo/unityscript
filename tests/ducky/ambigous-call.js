/*
Play String Hello
Play Stuff
Play String Stuff Hello
*/
enum Stuff { A, B, C }

var a;
var b;

a = "Hello";
Play(a);

b = Stuff.A;
Play(b);

Play(a, b);



function Play (stuff: Stuff)
{
	print ("Play Stuff");
}

function Play (str: String)
{
	print ("Play String " + str);
}

function Play (str: String, stuff : Stuff)
{
	print ("Play String Stuff " + str);
}