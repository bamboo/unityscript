/*
yes
*/

import UnityScript.Tests;

@script AttributeWithMask (AttributeMaskEnum.Foo | AttributeMaskEnum.Bar)

var attr = GetType().GetCustomAttributes(AttributeWithMask, false)[0] as AttributeWithMask;
if (attr.mask == (AttributeMaskEnum.Foo | AttributeMaskEnum.Bar))
	print ("yes");