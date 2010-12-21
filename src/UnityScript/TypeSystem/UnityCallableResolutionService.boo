namespace UnityScript.TypeSystem

import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.TypeSystem.Core

class UnityCallableResolutionService(CallableResolutionService):
	
	override def CheckVarArgsParameter(parameters as (IParameter), args as ExpressionCollection):
		if IsArrayArgumentExplicitlyProvided(parameters, args):
			return true
		return super(parameters, args)
		
	override def ShouldExpandArgs(method as IMethod, args as ExpressionCollection):
		parameters = method.GetParameters()
		if IsArrayArgumentExplicitlyProvided(parameters, args):
			return false
		return super(method, args)
		
def IsArrayArgumentExplicitlyProvided(parameters as (IParameter), args as ExpressionCollection):
	if len(parameters) != len(args):
		return false
		
	lastArgType = TypeSystemServices.GetExpressionType(args[-1])
	lastParamType = parameters[-1].Type
	return lastArgType == lastParamType or lastArgType == EmptyArrayType.Default
