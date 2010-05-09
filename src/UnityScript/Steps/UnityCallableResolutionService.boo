namespace UnityScript.Steps

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.TypeSystem

class UnityCallableResolutionService(CallableResolutionService):
	
	def constructor(context as CompilerContext):
		super(context)

	override def CheckVarArgsParameter(parameters as (IParameter), args as ExpressionCollection):
		return super(parameters, args)
		
	override def ShouldExpandArgs(method as IMethod, args as ExpressionCollection):
		parameters = method.GetParameters()
		if len(parameters) == len(args) and parameters[-1].Type == ArgumentType(args[-1]):
			return false
		return super(method, args)
