namespace UnityScript.Parser

import Boo.Lang.Compiler.Ast

static class CodeFactory:

	def NewArrayInitializer(location as LexicalInfo, elementType as TypeReference, count as Expression):
		return [| Boo.Lang.Builtins.array[of $elementType]($count) |].WithLocation(location)
		
	[Extension]
	def WithLocation[of T(Node)](node as T, location as LexicalInfo):
		node.LexicalInfo = location
		return node
