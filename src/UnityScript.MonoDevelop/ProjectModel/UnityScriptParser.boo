namespace UnityScript.MonoDevelop.ProjectModel

import System.IO

import MonoDevelop.Projects.Dom
import MonoDevelop.Projects.Dom.Parser

import UnityScript.MonoDevelop

class UnityScriptParser(AbstractParser):
	
	public static final MimeType = "text/x-unityscript"
	
	def constructor():
		super("UnityScript", MimeType)
		
	override def CanParse(fileName as string):
		return IsUnityScriptFile(fileName)
		
	override def Parse(dom as ProjectDom, fileName as string, content as string):
		result = ParseUnityScript(fileName, content)
		
		document = ParsedDocument(fileName)
		document.CompilationUnit = CompilationUnit(fileName)
		
		result.CompileUnit.Accept(DomConversionVisitor(document.CompilationUnit))
		
		return document
		
def ParseUnityScript(fileName as string, content as string):
	compiler = UnityScript.UnityScriptCompiler()
	compiler.Parameters.ScriptMainMethod = "Awake"
	compiler.Parameters.ScriptBaseType = object
	compiler.Parameters.Pipeline = UnityScript.UnityScriptCompiler.Pipelines.Parse()
	compiler.Parameters.Input.Add(Boo.Lang.Compiler.IO.StringInput(fileName, content))
	return compiler.Run()
	