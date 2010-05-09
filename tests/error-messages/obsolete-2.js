/* 
obsolete-2.js(9,14): BCE0144: 'UnityScript.Tests.CSharp.ObsoleteTest.ObsoleteErrorStaticMethod()' is obsolete. My Warning Text!
obsolete-2.js(10,20): BCE0144: 'UnityScript.Tests.CSharp.ObsoleteTest.ObsoleteErrorStaticProperty' is obsolete. My Warning Text!
obsolete-2.js(13,6): BCE0144: 'UnityScript.Tests.CSharp.ObsoleteTest.ObsoleteErrorMethod()' is obsolete. My Warning Text!
obsolete-2.js(14,12): BCE0144: 'UnityScript.Tests.CSharp.ObsoleteTest.ObsoleteErrorProperty' is obsolete. My Warning Text!
*/
import UnityScript.Tests.CSharp;

ObsoleteTest.ObsoleteErrorStaticMethod();
print(ObsoleteTest.ObsoleteErrorStaticProperty);

var test = new ObsoleteTest();
test.ObsoleteErrorMethod();
print(test.ObsoleteErrorProperty);
