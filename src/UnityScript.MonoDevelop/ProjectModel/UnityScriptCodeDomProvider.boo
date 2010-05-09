namespace UnityScript.MonoDevelop.ProjectModel

import System
import System.CodeDom.Compiler

class UnityScriptCodeDomProvider(CodeDomProvider):
	
	override FileExtension:
		get: return "js"
		
	override def CreateCompiler():		
		raise NotImplementedException()
		
	override def CreateGenerator():		
		return UnityScriptCodeGenerator()
		
	override def GetConverter(type as Type) as System.ComponentModel.TypeConverter:
		raise NotImplementedException()
		
