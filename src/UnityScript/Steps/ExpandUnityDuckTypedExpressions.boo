namespace UnityScript.Steps

import UnityScript.Core

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.Steps

class ExpandUnityDuckTypedExpressions(ExpandDuckTypedExpressions):
	
	private UnityRuntimeServices_Invoke as IMethod
	private UnityRuntimeServices_GetProperty as IMethod
	private _expando as bool
	
	override def Initialize(context as CompilerContext):
		super(context)
		UnityRuntimeServices_Invoke = ResolveUnityRuntimeMethod("Invoke")
		UnityRuntimeServices_GetProperty = ResolveUnityRuntimeMethod("GetProperty")
		
	override def OnModule(module as Module):
		_expando = UnityScriptParameters.Expando or Pragmas.IsEnabledOn(module, Pragmas.Expando)
		preserving Parameters.Strict:
			Parameters.Strict = Pragmas.IsEnabledOn(module, Pragmas.Strict)
			super(module)
			
	override def GetSetPropertyMethod():
		if not _expando: return super()
		return ResolveUnityRuntimeMethod("SetProperty")
		
	override def GetGetPropertyMethod():
		return UnityRuntimeServices_GetProperty

	override def ExpandQuackInvocation(node as MethodInvocationExpression):
		self.ExpandQuackInvocation(node, UnityRuntimeServices_Invoke)
		node.Arguments.Add(CodeBuilder.CreateTypeofExpression(UnityScriptTypeSystem.ScriptBaseType))
			
	def ResolveUnityRuntimeMethod(methodName as string):
		return NameResolutionService.ResolveMethod(UnityRuntimeServicesType, methodName)
			
	UnityScriptTypeSystem as UnityScript.TypeSystem.UnityScriptTypeSystem:
		get: return self.TypeSystemServices
			
	UnityScriptParameters as UnityScript.UnityScriptCompilerParameters:
		get: return self.Parameters
			
	UnityRuntimeServicesType:
		get: return self.TypeSystemServices.Map(typeof(UnityScript.Lang.UnityRuntimeServices))
	
	
		
