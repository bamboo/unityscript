namespace UnityScript.Steps

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.Steps

class ExpandUnityDuckTypedExpressions(ExpandDuckTypedExpressions):
	
	private UnityRuntimeServices_Invoke as IMethod
	private _expando as bool
	
	override def Initialize(context as CompilerContext):
		super(context)
		UnityRuntimeServices_Invoke = ResolveUnityRuntimeMethod("Invoke")
		
	override def EnterModule(module as Module):
		_expando = UnityScriptParameters.Expando or module.ContainsAnnotation("expando")
		return super(module)
			
	override def GetSetPropertyMethod():
		if not _expando: return super()
		return ResolveUnityRuntimeMethod("SetProperty")
		
	override def GetGetPropertyMethod():
		if not _expando: return super()
		return ResolveUnityRuntimeMethod("GetProperty")

	override def ExpandQuackInvocation(node as MethodInvocationExpression):
		if not IsPossibleStartCoroutineInvocation(node):
			super(node)
			return
			
		self.ExpandQuackInvocation(node, UnityRuntimeServices_Invoke)
		node.Arguments.Add(CodeBuilder.CreateTypeofExpression(UnityScriptTypeSystem.ScriptBaseType))
			
	def ResolveUnityRuntimeMethod(methodName as string):
		return NameResolutionService.ResolveMethod(UnityRuntimeServicesType, methodName)
			
	UnityScriptTypeSystem as UnityScript.Steps.UnityScriptTypeSystem:
		get: return self.TypeSystemServices
			
	UnityScriptParameters as UnityScript.UnityScriptCompilerParameters:
		get: return _context.Parameters
			
	UnityRuntimeServicesType:
		get: return self.TypeSystemServices.Map(typeof(UnityScript.Lang.UnityRuntimeServices))
	
	
		
