namespace UnityScript.TypeSystem

import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.TypeSystem.Services
import Boo.Lang.PatternMatching

class UnityScriptEntityFormatter(EntityFormatter):
	
	override def FormatType(type as IType) as string:
		match type:
			case IArrayType(ElementType, Rank):
				return "$(FormatType(ElementType))[$(',' * (Rank - 1))]"
			case ICallableType():
				return FormatCallableType(type)
			otherwise:
				return super(type)
				
	override def FormatGenericArguments(genericArgs as string*):
		return ".<$(join(genericArgs, ', '))>"
				
	def FormatCallableType(type as ICallableType):
		signature = type.GetSignature()
		parameters = join(FormatType(p.Type) for p in signature.Parameters, ", ")
		returnType = FormatType(signature.ReturnType)
		return "function($parameters): $returnType"
