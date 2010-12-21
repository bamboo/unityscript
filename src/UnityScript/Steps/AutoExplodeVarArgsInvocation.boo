namespace UnityScript.Steps

import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.TypeSystem
import UnityScript.TypeSystem

class AutoExplodeVarArgsInvocations(AbstractVisitorCompilerStep):
	
	override def Run():
		Visit(CompileUnit)
		
	override def LeaveMethodInvocationExpression(node as MethodInvocationExpression):
		entity = node.Target.Entity as IEntityWithParameters
		if entity is null:
			return
			
		args = node.Arguments
		if not entity.AcceptVarArgs or not IsArrayArgumentExplicitlyProvided(entity.GetParameters(), args):
			return
			
		lastArg = args[-1]
		args.ReplaceAt(-1,
			UnaryExpression(
				Operator: UnaryOperatorType.Explode,
				Operand: lastArg,
				ExpressionType: GetExpressionType(lastArg)))
