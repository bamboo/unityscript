#!/bin/sh
mono bin/net-2.0/us.exe -out:bin/il.dll -verbose -t:library -r:bin/net-2.0/UnityScript.Tests.CSharp.dll -r:bin/net-2.0/UnityScript.Tests.dll -b:UnityScript.Tests.MonoBehaviour -m:Awake "$@"
monodis bin/il.dll
