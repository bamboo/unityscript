namespace UnityScript.Parser

import System.Globalization
import Boo.Lang.Compiler.Ast

static class CodeFactory:
	
	def NewArrayComprehension(location as LexicalInfo, projection as Expression, variable as Declaration, expression as Expression, filter as Expression):
		ge = GeneratorExpression(location, Expression: projection, Iterator: expression)
		ge.Declarations.Add(variable)
		if filter is not null:
			ge.Filter = StatementModifier(filter.LexicalInfo, Type: StatementModifierType.If, Condition: filter) 
		return [| Boo.Lang.Builtins.array($ge) |].WithLocation(location)

	def NewArrayInitializer(location as LexicalInfo, elementType as TypeReference, dimensions as List of Expression):
		if len(dimensions) == 1:
			size = dimensions[0]
			return [| Boo.Lang.Builtins.array[of $elementType](cast(int, $size)) |].WithLocation(location)
		initializer = [| Boo.Lang.Builtins.matrix[of $elementType]() |].WithLocation(location)
		initializer.Arguments.AddRange(dimensions)
		return initializer
		
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
