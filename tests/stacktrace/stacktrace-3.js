/*
stacktrace-3.js:7
*/
var stuff : String[];
stuff = null;

for(var s : String in stuff)
{
}


/// The stacktrace says the null reference exception happens in stuff = null;
/// But it should point to: for(var s : String in stuff)