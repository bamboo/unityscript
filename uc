#!/bin/sh
mono bin/us.exe -i:UnityEngine -out:bin/Scripts.dll -verbose -t:library -r:../UnityEngine.dll -b:UnityEngine.MonoBehaviour -m:Awake "$@"
