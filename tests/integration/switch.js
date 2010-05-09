/*
Not a bad choice!
Not a bad choice!
pass through
It has its moments
It has its moments double
It has its moments
I'm sure it was great
I'm sure it was great
*/

RunTyped("Titanic");
RunUntyped("Titanic");

RunTyped("Scream");
RunUntyped("Scream");

RunTyped("dummy");
RunUntyped("dummy");

function RunTyped (movie : String)
{
	switch (movie) {
		case "Titanic": 
		print("Not a bad choice!");
		break;
		case "Water World": 
		print("No comment");
		break;
		case "Scream": 
		print("pass through");
		case "Scream 2": 
		print("It has its moments");
		break;
		default : print("I'm sure it was great");
	}
}

function RunUntyped (favoritemovie)
{
	switch (favoritemovie) {
		case "Titanic": 
		print("Not a bad choice!");
		break;
		case "Water World": 
		print("No comment");
		break;
		case "Scream": 
		print("It has its moments double");
		case "Scream 2": 
		print("It has its moments");
		break;
		default : print("I'm sure it was great");
	}
}
