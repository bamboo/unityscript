namespace UnityScript.MonoDevelop.ProjectModel

import System.CodeDom.Compiler

class UnityScriptCodeGenerator(CodeGenerator):
	
	override def Supports(supports as GeneratorSupport):
		return false
		
	override def CreateEscapedIdentifier(value as string):
		return value
		
	override def CreateValidIdentifier(value as string):
		return value