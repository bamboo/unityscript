namespace UnityScript.Steps

import Boo.Lang.Compiler.Steps
import UnityScript.TypeSystem

class InitializeUnityScriptTypeSystem(InitializeTypeSystemServices):
	
	override def CreateEntityFormatter():
		return UnityScriptEntityFormatter()
	
	override def CreateTypeSystemServices():
		return UnityScriptTypeSystem(Context)
		
	override def CreateCallableResolutionService():
		return UnityCallableResolutionService(Context)
		
	override def CreateDowncastPermissions():
		return UnityDowncastPermissions()

