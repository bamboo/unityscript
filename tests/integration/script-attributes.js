/*
yes
*/

import UnityScript.Tests;


@script AttributeWithMask (AttributeMaskEnum.Foo | AttributeMaskEnum.Bar)

var attr : AttributeWithMask = GetType().GetCustomAttributes(AttributeWithMask, false)[0];
if (attr.mask == (AttributeMaskEnum.Foo | AttributeMaskEnum.Bar))
	print ("yes");