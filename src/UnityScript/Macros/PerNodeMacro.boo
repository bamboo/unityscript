namespace UnityScript.Macros

import Boo.Lang.Compiler.Ast
import Boo.Lang.PatternMatching
		
macro perNode(node as ReferenceExpression):
	
	match perNode.Body:
		case Block(Statements: (ReturnStatement(Expression: value),)):
			key = ReferenceExpression(Name: Context.GetUniqueName(node.Name))
			yield [|
				static private final $key = object()
			|]
			yield [|
				block:
					cached = $node[$key]
					return cached if cached is not null
					value = $value
					$node[$key] = value
					return value
			|].Body

