/* 
obsolete.js(9,14): BCW0012: WARNING: 'UnityScript.Tests.CSharp.ObsoleteTest.ObsoleteStaticMethod()' is obsolete. My Warning Text!
obsolete.js(10,20): BCW0012: WARNING: 'UnityScript.Tests.CSharp.ObsoleteTest.ObsoleteStaticProperty' is obsolete. My Warning Text!
obsolete.js(13,6): BCW0012: WARNING: 'UnityScript.Tests.CSharp.ObsoleteTest.ObsoleteMethod()' is obsolete. My Warning Text!
obsolete.js(14,12): BCW0012: WARNING: 'UnityScript.Tests.CSharp.ObsoleteTest.ObsoleteProperty' is obsolete. My Warning Text!
*/
import UnityScript.Tests.CSharp;

ObsoleteTest.ObsoleteStaticMethod();
print(ObsoleteTest.ObsoleteStaticProperty);

var test = new ObsoleteTest();
test.ObsoleteMethod();
print(test.ObsoleteProperty);
