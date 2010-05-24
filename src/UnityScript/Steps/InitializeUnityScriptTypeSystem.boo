namespace UnityScript.Steps

import Boo.Lang.Compiler.Steps

class InitializeUnityScriptTypeSystem(InitializeTypeSystemServices):
	
	override def CreateTypeSystemServices():
		return UnityScriptTypeSystem(Context)
		
	override def CreateCallableResolutionService():
		return UnityCallableResolutionService(Context)
		
	override def CreateDowncastPermissions():
		return UnityDowncastPermissions()
