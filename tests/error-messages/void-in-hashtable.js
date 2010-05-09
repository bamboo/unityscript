/*
void-in-hashtable.js(8,40): BCE0126: It is not possible to evaluate an expression of type 'void'.
*/
function voidfunction(){}

function Start()
{
    var ht = {"callback" : voidfunction()};
    print(ht);
}
