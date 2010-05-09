/*
5
1
*/
import UnityScript.Tests;

eval ("GetComponent(ComponentFoo)").fooFloat = 5;
print (GetComponent(ComponentFoo).fooFloat);

eval ("GetComponent(ComponentFoo).fooFloat = 1;");
eval ("print (GetComponent(ComponentFoo).fooFloat);");