namespace UnityScript.Steps

import UnityScript.Core

import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.Steps

class ApplySemantics(AbstractVisitorCompilerStep):
	
	override def Run():
		Visit(CompileUnit)
	
	class DeclareGlobalVariables(DepthFirstTransformer):
		
		_class as ClassDefinition
		
		def constructor(cd as ClassDefinition):
			_class = cd
			
		override def EnterBlock(node as Block):
			if node.ParentNode isa Method: return true
			return false
		
		override def OnDeclarationStatement(node as DeclarationStatement):
			
			return if node.ContainsAnnotation('PrivateScope')
		
			field = [|
				public $(node.Declaration.Name) as $(node.Declaration.Type) = $(node.Initializer)
			|]			
			field.LexicalInfo = node.LexicalInfo
			_class.Members.Add(field)
			
			RemoveCurrentNode()
			
	UnityScriptParameters as UnityScript.UnityScriptCompilerParameters:
		get: return _context.Parameters
	
	override def OnModule(module as Module):
		
		SetUpDefaultImports(module)

		script = FindOrCreateScriptClass(module)
		SetUpScriptClass(script)
		MoveMembers(module, script)
		SetUpMainMethod(module, script)
		MoveAttributes(module, script)
		module.Members.Add(script)
		SetScriptClass(Context, script)
		
	def SetUpMainMethod(module as Module, script as TypeDefinition):
		
		TransformGlobalVariablesIntoFields(module, script)
		
		main = FindExistingMainMethodOn(script)
		if main is null:
			main = CreateMainMethod(module)
			script.Members.Add(main)
		else:
			Warnings.Add(UnityScriptWarnings.ScriptMainMethodIsImplicitlyDefined(main.LexicalInfo, main.Name))
			
		main.Body.Statements.Extend(module.Globals.Statements)
		module.Globals.Statements.Clear()
		
	def TransformGlobalVariablesIntoFields(module as Module, script as TypeDefinition):
		if not UnityScriptParameters.GlobalVariablesBecomeFields:
			return
		module.Globals.Accept(DeclareGlobalVariables(script))
		
	def FindExistingMainMethodOn(typeDef as TypeDefinition):
		for member in typeDef.Members:
			method = member as Method
			found = method is not null \
				and method.Name == ScriptMainMethod \
				and len(method.Parameters) == 0
			return method if found
		
	def SetUpScriptClass(global as ClassDefinition):
		global.Modifiers |= TypeMemberModifiers.Partial		
		SetMembersPublicByDefault(global)
		
	def SetUpDefaultImports(module as Module):
		for ns as string in self.UnityScriptParameters.Imports:
			module.Imports.Add(
				Import(LexicalInfo: module.LexicalInfo, Namespace: ns))
					
	def MoveAttributes(fromType as TypeDefinition, toType as TypeDefinition):
		toType.Attributes.Extend(fromType.Attributes)
		fromType.Attributes.Clear()
		
	def MoveMembers(fromType as TypeDefinition, toType as TypeDefinition):
		moved = []
		for member in fromType.Members:
			if not member isa TypeDefinition:
				movedMember = MovedMember(toType, member)
				toType.Members.Add(movedMember)
				Visit(movedMember)
				moved.Add(member)
			else:
				Visit(member)
		
		for member in moved:
			fromType.Members.Remove(member)
			
	def MovedMember(toType as TypeDefinition, member as TypeMember):
		if not toType.ContainsAnnotation("UserDefined"): return member
		if not IsConstructorMethod(toType, member): return member
		return ConstructorFromMethod(member)
		
	def IsConstructorMethod(toType as TypeDefinition, member as TypeMember):
		if member.NodeType != NodeType.Method: return false
		return toType.Name == member.Name
		
	def ConstructorFromMethod(method as Method):
		return Constructor(
			Parameters: method.Parameters,
			Body: method.Body, 
			Attributes: method.Attributes,
			Modifiers: method.Modifiers,
			LexicalInfo: method.LexicalInfo,
			EndSourceLocation: method.EndSourceLocation)
		
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

	def FindOrCreateScriptClass(module as Module):
		for existing as ClassDefinition in module.Members.Select(NodeType.ClassDefinition):
			if existing.Name == module.Name:
				module.Members.Remove(existing)
				if existing.IsPartial: AddScriptBaseType(existing)
				existing.Annotate("UserDefined")
				return existing
						
		klass = ClassDefinition(module.LexicalInfo, Name: module.Name, EndSourceLocation: module.EndSourceLocation)
		AddScriptBaseType(klass)
		return klass
		
	def AddScriptBaseType(klass as ClassDefinition):
		klass.BaseTypes.Add(CodeBuilder.CreateTypeReference(UnityScriptParameters.ScriptBaseType))
		
	def SetMembersPublicByDefault(node as ClassDefinition):
		for member in node.Members: Visit(member)
		
	def SetPublicByDefault(node as TypeMember):
		node.Modifiers |= TypeMemberModifiers.Public unless node.IsVisibilitySet
		
	ScriptMainMethod:
		get: return self.UnityScriptParameters.ScriptMainMethod
	
	def CreateMainMethod(module as Module):
		method = Method(module.LexicalInfo, Name: ScriptMainMethod)
		method.Modifiers = TypeMemberModifiers.Public | TypeMemberModifiers.Virtual
		
		stmts = module.Globals.Statements
		if len(stmts) > 0: method.LexicalInfo = Copy(stmts[0].LexicalInfo)
		method.EndSourceLocation = module.EndSourceLocation
		
		return method
		
def Copy(li as LexicalInfo):
	return LexicalInfo(li.FileName, li.Line, li.Column)

