/*
foo
bar
*/
#pragma strict

import UnityScript.Tests;

var foo = InferredGetComponent(ComponentFoo);
foo.Foo();

var bar = InferredGetComponent(ComponentBar);
bar.Bar();