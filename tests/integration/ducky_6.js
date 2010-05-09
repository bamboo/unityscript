/*
4
*/
import UnityScript.Tests;

GetComponent(ComponentFoo).fooVector3.x += 2;
GetComponent(ComponentFoo)._fooVector3.x += 2;
print(GetComponent(ComponentFoo).fooVector3.x);