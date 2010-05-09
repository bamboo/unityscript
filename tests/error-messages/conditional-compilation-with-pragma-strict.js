/*
conditional-compilation-with-pragma-strict.js(11,5): BCE0019: 'Foo' is not a member of 'UnityScript.Tests.Component'.
*/
#pragma strict

#if FOO
print("FOO is defined")
#endif

var com = GetComponent(UnityScript.Tests.ComponentFoo);
com.Foo();