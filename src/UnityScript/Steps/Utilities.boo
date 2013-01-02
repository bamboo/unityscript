namespace UnityScript.Steps

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.TypeSystem
import PatternMatching

def IsRhsOfAssignment(node as Expression):
	match node.ParentNode:
		case BinaryExpression(Operator: BinaryOperatorType.Assign, Right: rhs) and rhs is node:
			return true
		otherwise:
			return false
	
def IsPossibleStartCoroutineInvocationForm(node as MethodInvocationExpression):
	match node:
		case Node(ParentNode: ExpressionStatement() | YieldStatement()) or IsRhsOfAssignment(node):
			return true
		/*
		case Node(ParentNode: DeclarationStatement(Initializer: initializer)) and node is initializer:
			return true
		*/
		otherwise:
			return false
	
def SetScriptClass(context as CompilerContext, klass as ClassDefinition):
	context["ScriptClass"] = klass
	
def GetScriptClass(context as CompilerContext) as ClassDefinition:
	return context["ScriptClass"]
	
def ConstructorTakingNArgumentsFor(type as IType, arguments as int):
	for ctor in type.GetConstructors():
		return ctor if len(ctor.GetParameters()) == arguments
	raise "no constructor in $type taking $arguments arguments"
		

