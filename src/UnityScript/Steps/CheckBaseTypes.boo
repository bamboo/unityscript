namespace UnityScript.Steps

import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.TypeSystem

import UnityScript.Core

class CheckBaseTypes(AbstractVisitorCompilerStep):

	override def Run():
		Visit(CompileUnit)
		
	override def LeaveClassDefinition(node as ClassDefinition):
		for baseType in node.BaseTypes:
			CheckBaseTypeAnnotation(baseType)
			
	def CheckBaseTypeAnnotation(baseType as TypeReference):
		if BaseTypeAnnotations.HasExtends(baseType):
			CheckIsClass(baseType)
		elif BaseTypeAnnotations.HasImplements(baseType):
			CheckIsInterface(baseType)
			
	def CheckIsClass(baseType as TypeReference):
		type = TypeEntityFor(baseType)
		if type.IsClass:
			return
		Errors.Add(UnityScriptCompilerErrors.ClassExpected(baseType.LexicalInfo, type.DisplayName()))
			
	def CheckIsInterface(baseType as TypeReference):
		type = TypeEntityFor(baseType)
		if type.IsInterface:
			return
		Errors.Add(UnityScriptCompilerErrors.InterfaceExpected(baseType.LexicalInfo, type.DisplayName()))
			
	def TypeEntityFor(baseType as TypeReference) as IType:
		return GetEntity(baseType)
		
	override def OnBlock(node as Block):
		pass // ignore