namespace UnityScript.Scripting

import System
import UnityScript
import Boo.Lang.Compiler
import Boo.Lang.Compiler.IO

class CompilationErrorsException(Exception):
	
	[getter(Errors)]
	_errors as CompilerErrorCollection
	
	def constructor(errors as CompilerErrorCollection):
		super(errors.ToString(true))
		_errors = errors
	
interface IEvaluationDomainProvider:
"""
Every script in UnityScript defines a new EvaluationDomain.
"""
	def GetImports() as (string)
	def GetEvaluationDomain() as EvaluationDomain
	
class SimpleEvaluationDomainProvider(IEvaluationDomainProvider):
"""
SimpleEvaluationDomainProvider is used whenever there's an eval invocation
inside a static method.
"""	
	private _domain = EvaluationDomain()
	private _imports as (string)
	
	def GetImports():
		return _imports
	
	def GetEvaluationDomain() as EvaluationDomain:
		return _domain
	
class EvaluationDomain:
"""
Groups together a set of related EvaluationScripts instances.
"""
	_cache = {}
	
	[lock]
	def GetCachedScript(key as EvaluationScriptCacheKey) as System.Type:
		return _cache[key]
	
	[lock]
	def CacheScript(key as EvaluationScriptCacheKey, type as System.Type):
		_cache[key] = type
		
class EvaluationScriptCacheKey:
	
	_contextType as System.Type
	_code as string
	
	def constructor(contextType as Type, code as string):
		_contextType = contextType
		_code = code
		
	override def Equals(o):
		other = o as EvaluationScriptCacheKey
		if other is null: return false
		return other._contextType is _contextType and other._code == _code
		
	override def GetHashCode():
		return _contextType.GetHashCode() ^ _code.GetHashCode()
		
class EvaluationScript:
	
	virtual def Run() as object:
		pass

class Evaluator:
	
	private static final TaintedAnnotation = object()
	
	static def Eval(context as EvaluationContext, code as string) as object:
		return Evaluator(context, code).Run()
		
	static def Taint(cu as Boo.Lang.Compiler.Ast.CompileUnit):
		cu[TaintedAnnotation] = TaintedAnnotation
		
	static def IsTainted(cu as Boo.Lang.Compiler.Ast.CompileUnit):
		return cu.ContainsAnnotation(TaintedAnnotation)
		
	_context as EvaluationContext
	_code as string
	_cacheKey as EvaluationScriptCacheKey
	_compilationResult as CompilerContext
	
	def constructor([required] context as EvaluationContext, [required] code as string):
		_context = context
		_code = code
		_cacheKey = EvaluationScriptCacheKey(context.GetType(), code)
		
	def Run():
		scriptType = CompileScript()
		script = ActivateScript(scriptType)
		return script.Run()
		
	def ActivateScript(scriptType as Type):
		script as EvaluationScript = scriptType(_context)
		_context.AddScript(script)
		return script
		
	private def CompileScript():
		
		type = GetCachedScript()
		if type is not null: return type
		
		type = DoCompile()
		CacheScript(type)
		return type
		
	private def GetCachedScript():
		return GetEvaluationDomain().GetCachedScript(_cacheKey)
		
	private def CacheScript(type as Type):
		if IsTainted(_compilationResult.CompileUnit): return
		GetEvaluationDomain().CacheScript(_cacheKey, type)
		
	private def GetEvaluationDomain():
		domain = _context.ScriptContainer.GetEvaluationDomain()
		assert domain is not null
		return domain
		
	private def DoCompile():
		
		compiler = UnityScriptCompiler()
		compiler.Parameters.Pipeline = AdjustPipeline(_context, UnityScriptCompiler.Pipelines.CompileToMemory())
		compiler.Parameters.ScriptBaseType = EvaluationScript
		compiler.Parameters.GlobalVariablesBecomeFields = false
		compiler.Parameters.ScriptMainMethod = "Run"
		compiler.Parameters.Input.Add(StringInput("script", _code + ";"))
		compiler.Parameters.Debug = false
		compiler.Parameters.GenerateInMemory = true
		
		contextAssembly = _context.GetType().Assembly
		compiler.Parameters.References.Add(contextAssembly)
		for name in contextAssembly.GetReferencedAssemblies():
			compiler.Parameters.References.Add(System.Reflection.Assembly.Load(name))
		
		_compilationResult = compiler.Run()
		if len(_compilationResult.Errors):
			raise CompilationErrorsException(_compilationResult.Errors)
		
		#print _compilationResult.CompileUnit.ToCodeString()
		return _compilationResult.GeneratedAssembly.GetType("script")
		
	static def AdjustPipeline(context as EvaluationContext, pipeline as CompilerPipeline):
		pipeline.InsertAfter(
			UnityScript.Steps.IntroduceUnityGlobalNamespaces,
			UnityScript.Scripting.Pipeline.IntroduceScriptingNamespace(context))
		pipeline.InsertAfter(
			UnityScript.Scripting.Pipeline.IntroduceScriptingNamespace,
			UnityScript.Scripting.Pipeline.IntroduceImports(context))
		pipeline.InsertAfter(
			UnityScript.Steps.ApplySemantics,
			UnityScript.Scripting.Pipeline.IntroduceEvaluationContext(context))
		pipeline.Replace(
			UnityScript.Steps.ProcessUnityScriptMethods,
			UnityScript.Scripting.Pipeline.ProcessScriptingMethods(context))
		pipeline.InsertAfter(
			UnityScript.Scripting.Pipeline.ProcessScriptingMethods,
			UnityScript.Scripting.Pipeline.IntroduceReturnValue())
		return pipeline
