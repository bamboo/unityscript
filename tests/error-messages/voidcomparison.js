/*
voidcomparison.js(10,14): BCE0126: It is not possible to evaluate an expression of type 'void'.
*/
function something():void
{
 print("something");
}

print("good");
if (something() == true)
    print("bad");

