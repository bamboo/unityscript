namespace UnityScript.Core

import Boo.Lang.Compiler.Ast

static class UnityScriptWarnings:

	def VirtualKeywordHasNoEffect(location as LexicalInfo):
		return CreateWarning("UCW0100", location, "WARNING: 'virtual' keyword has no effect and it has been deprecated. Functions are virtual by default.")

	private def CreateWarning(code as string, location as LexicalInfo, message as string):
		return Boo.Lang.Compiler.CompilerWarning(location, message, code)
		
