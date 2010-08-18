namespace UnityScript.Parser

import System.Globalization
import Boo.Lang.Compiler.Ast

static class CodeFactory:

	def NewArrayInitializer(location as LexicalInfo, elementType as TypeReference, count as Expression):
		return [| Boo.Lang.Builtins.array[of $elementType](cast(int, $count)) |].WithLocation(location)
		
	def NewDoubleLiteralExpression(location as LexicalInfo, literal as string):
		if literal.EndsWith('d') or literal.EndsWith('D'):
			return DoubleLiteralExpression(location, ParseDouble(literal[:-1]))
			
		literal = literal[:-1] if literal.EndsWith('f') or literal.EndsWith('F')
		value = ParseDouble(literal)
		return DoubleLiteralExpression(location, value, IsSingle:  true)
		
	private def ParseDouble(text as string):
		return double.Parse(text, CultureInfo.InvariantCulture)
		
	[Extension]
	def WithLocation[of T(Node)](node as T, location as LexicalInfo):
		node.LexicalInfo = location
		return node
