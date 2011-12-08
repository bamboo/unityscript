namespace UnityScript.Core

import Boo.Lang.Compiler.Ast

static class UnityScriptWarnings:

	def VirtualKeywordHasNoEffect(location as LexicalInfo):
		return CreateWarning("UCW0100", location, "WARNING: 'virtual' keyword has no effect and it has been deprecated. Functions are virtual by default.")
		
	def ScriptMainMethodIsImplicitlyDefined(location as LexicalInfo, functionName as string):
		return CreateWarning("UCW0002", location, "WARNING: Function '${functionName}()' is already implicitly defined to contain global script code. Global code will be merged at the end. Either rename the function, change its signature or remove any global code if that's not what you intended.")

	def BitwiseOperatorWithBooleanOperands(location as LexicalInfo, expectedOperator as string, actualOperator as string):
		return CreateWarning("UCW0003", location, "WARNING: Bitwise operation '$actualOperator' on boolean values won't shortcut. Did you mean '$expectedOperator'?")

	private def CreateWarning(code as string, location as LexicalInfo, message as string):
		return Boo.Lang.Compiler.CompilerWarning(location, message, code)
		
