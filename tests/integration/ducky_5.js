/*
2
*/
import UnityScript.Tests;

GetComponent(ComponentFoo).fooFloat += 2;
foo = GetComponent(ComponentFoo);
foo.fooFloat *= 2;
foo = GetComponent(ComponentFoo);
foo._fooFloat -= 2;
print(GetComponent(ComponentFoo).fooFloat);