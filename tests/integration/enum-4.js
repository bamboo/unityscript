/*
yes
yes
*/
import UnityScript.Tests.CSharp;

enum FormatFlags {
   ToUpperCase = 1,
   ToLowerCase = 2,
   TrimLeft    = 4,
   TrimRight   = 8,
   UriEncode   = 16
}

var foo = FormatFlags.ToUpperCase;
var bar : FormatFlags = FormatFlags.ToUpperCase;

if (foo == bar)
	print ("yes");

if ((FormatFlags.ToUpperCase | FormatFlags.ToLowerCase) & FormatFlags.ToUpperCase)
	print ("yes");
