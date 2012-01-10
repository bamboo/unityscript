namespace UnityScript.Steps

import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.Steps

import PatternMatching
import UnityScript.Core.UnityScriptWarnings

class Lint(AbstractFastVisitorCompilerStep):
	
	override def OnBinaryExpression(node as BinaryExpression):
		super(node)
		match node.Operator:
			case BinaryOperatorType.BitwiseAnd | BinaryOperatorType.BitwiseOr:
				if IsBoolean(node.Left) and IsBoolean(node.Right):
					expected, actual = (("&&", "&") if node.Operator == BinaryOperatorType.BitwiseAnd else ("||", "|"))
					Warnings.Add(BitwiseOperatorWithBooleanOperands(node.LexicalInfo, expected, actual))
			otherwise:
				pass
					
	def IsBoolean(e as Expression):
		return e.ExpressionType is TypeSystemServices.BoolType