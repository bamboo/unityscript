namespace UnityScript.Core

import Boo.Lang.Compiler.Ast

static class UnityScriptCompilerErrors:

	def SemicolonExpected(location as LexicalInfo):
		return CreateError("UCE0001", location, "';' expected. Insert a semicolon at the end.")
		
	def UnknownPragma(location as LexicalInfo, pragma as string):
		return CreateError("UCE0002", location, "Unknown pragma '${pragma}'.")
		
	def InvalidPropertySetter(location as LexicalInfo):
		return CreateError("UCE0003", location, "Property setter must have a single argument named 'value'.")
		
	def InvalidPropertyGetter(location as LexicalInfo):
		return CreateError("UCE0004", location, "Property getter cannot declare any arguments.")
		
	def InterfaceExpected(location as LexicalInfo, typeName as string):
		return CreateError("UCE0005", location, "'$typeName' is not an interface. 'implements' can only be used with interfaces. Did you mean 'extends'?")
	
	def ClassExpected(location as LexicalInfo, typeName as string):
		return CreateError("UCE0006", location, "'$typeName' is not a class. 'extends' can only be used with classes. Did you mean 'implements'?")
		
	def KeywordCannotBeUsedAsAnIdentifier(location as LexicalInfo, keyword as string):
		return CreateError("UCE0007", location, "'$keyword' keyword cannot be used as an identifier.")
		
	def EvalHasBeenDisabled(location as LexicalInfo, reason as string):
		return CreateError("UCE0008", location, reason)
		
	def SetterCanNotDeclareReturnType(location as LexicalInfo):
		return CreateError("UCE0009", location, "Property setter can not declare return type.")
		
	private def CreateError(code as string, location as LexicalInfo, message as string):
		return Boo.Lang.Compiler.CompilerError(code, location, message, null)
		
