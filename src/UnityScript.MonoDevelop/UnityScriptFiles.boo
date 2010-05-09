namespace UnityScript.MonoDevelop

def IsUnityScriptFile(fileName as string):
	return System.IO.Path.GetExtension(fileName).ToLower() in (".us", ".js")

