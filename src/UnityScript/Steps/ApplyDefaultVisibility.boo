namespace UnityScript.Steps

import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.Steps

class ApplyDefaultVisibility(AbstractVisitorCompilerStep):
	
	override def Run():
		Visit(CompileUnit)
		
	override def LeaveEnumDefinition(node as EnumDefinition):
		SetPublicByDefault(node)
		
	override def LeaveInterfaceDefinition(node as InterfaceDefinition):
		SetPublicByDefault(node)
		
	override def LeaveClassDefinition(node as ClassDefinition):
		SetPublicByDefault(node)
		
	override def OnField(node as Field):
		SetPublicByDefault(node)
		
	override def OnConstructor(node as Constructor):
		SetPublicByDefault(node)
		
	override def OnMethod(node as Method):
		if node.IsPrivate: return
		
		SetPublicByDefault(node)
		if node.IsFinal: return
		if node.IsStatic: return
		node.Modifiers |= TypeMemberModifiers.Virtual
		
	def SetPublicByDefault(node as TypeMember):
		node.Modifiers |= TypeMemberModifiers.Public unless node.IsVisibilitySet