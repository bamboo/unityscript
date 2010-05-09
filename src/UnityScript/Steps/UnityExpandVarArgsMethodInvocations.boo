namespace UnityScript.Steps

import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.TypeSystem

class UnityExpandVarArgsMethodInvocations(ExpandVarArgsMethodInvocations):

	override def ExpandInvocation(node as MethodInvocationExpression, parameters as (IParameter)):
		args = node.Arguments
		if len(args) == len(parameters) and GetExpressionType(args[-1]) == parameters[-1].Type:
			return
		super(node, parameters)
