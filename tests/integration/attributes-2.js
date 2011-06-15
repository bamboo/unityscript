/*
yes
*/

import UnityScript.Tests;

@AttributeWithMask(AttributeMaskEnum.Foo | AttributeMaskEnum.Bar)
function bar() {
}

var attr = GetType().GetMethod ("bar").GetCustomAttributes(AttributeWithMask, false)[0] as AttributeWithMask;
if (attr.mask == (AttributeMaskEnum.Foo | AttributeMaskEnum.Bar))
	print ("yes");