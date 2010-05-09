/*
Hello World
*/
import UnityScript.Tests;

var cs_trans : UnityScript.Tests.CSharp.TransformCS;
cs_trans = new UnityScript.Tests.CSharp.TransformCS();
cs_trans.stringArray[0] = "Hello World";
print(cs_trans.stringArray[0]);
