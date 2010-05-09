#!/bin/sh
mono bin/net-2.0/us.exe -i:UnityEngine -out:bin/Scripts.dll -verbose -t:library -r:../UnityEngine.dll -b:UnityEngine.MonoBehaviour -m:Awake "$@"
