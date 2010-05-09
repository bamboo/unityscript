/*
yes
*/

import UnityScript.Tests;

@AttributeWithMask(AttributeMaskEnum.Foo | AttributeMaskEnum.Bar)
function bar() {
}

var attr : AttributeWithMask = GetType().GetMethod ("bar").GetCustomAttributes(AttributeWithMask, false)[0];
if (attr.mask == (AttributeMaskEnum.Foo | AttributeMaskEnum.Bar))
	print ("yes");