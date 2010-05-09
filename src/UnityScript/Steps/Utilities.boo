namespace UnityScript.Steps

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast

def IsRhsOfAssignment(node as Expression):
	be = node.ParentNode as BinaryExpression
	if be is null: return false
	if be.Operator != BinaryOperatorType.Assign: return false
	return be.Right is node
	
def IsPossibleStartCoroutineInvocation(node as MethodInvocationExpression):
	if node.ParentNode isa ExpressionStatement: return true
	if node.ParentNode isa YieldStatement: return true
	return IsRhsOfAssignment(node)
	
def SetScriptClass(context as CompilerContext, klass as ClassDefinition):
	context["ScriptClass"] = klass
	
def GetScriptClass(context as CompilerContext) as ClassDefinition:
	return context["ScriptClass"]
