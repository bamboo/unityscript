namespace UnityScript

import Boo.Lang.Compiler

class UnityScriptCompiler:

	[getter(Parameters)]
	_parameters as UnityScriptCompilerParameters
	_compiler as BooCompiler

	def constructor():
		self(UnityScriptCompilerParameters())

	def constructor([required] parameters as UnityScriptCompilerParameters):
		_parameters = parameters
		_compiler = BooCompiler(_parameters)

	def Run():
		return _compiler.Run()
		
	def Run(compileUnit as Boo.Lang.Compiler.Ast.CompileUnit):
		return _compiler.Run(compileUnit)
		
	static class Pipelines:
	
		def RawParsing():
			return CompilerPipeline() { UnityScript.Steps.PreProcess(), UnityScript.Steps.Parse() }
		
		def Parse():
			return RawParsing() { UnityScript.Steps.ApplySemantics(), UnityScript.Steps.ApplyDefaultVisibility() }
			
		def Compile():
			return AdjustBooPipeline(Boo.Lang.Compiler.Pipelines.Compile())
		
		def CompileToMemory():
			return AdjustBooPipeline(Boo.Lang.Compiler.Pipelines.CompileToMemory())
			
		def CompileToFile():
			return AdjustBooPipeline(Boo.Lang.Compiler.Pipelines.CompileToFile())
			
		def CompileToBoo():
			return AdjustBooPipeline(Boo.Lang.Compiler.Pipelines.CompileToBoo())
			
		def AdjustBooPipeline(pipeline as CompilerPipeline):
			pipeline.Insert(0,
						UnityScript.Steps.PreProcess())
			
			pipeline.Replace(Boo.Lang.Compiler.Steps.Parsing,
						UnityScript.Steps.Parse())
			
			pipeline.Replace(Boo.Lang.Compiler.Steps.IntroduceGlobalNamespaces,
						UnityScript.Steps.IntroduceUnityGlobalNamespaces())
						
			pipeline.InsertAfter(Boo.Lang.Compiler.Steps.PreErrorChecking,
						UnityScript.Steps.ApplySemantics())
			
			pipeline.InsertAfter(UnityScript.Steps.ApplySemantics,
						UnityScript.Steps.ApplyDefaultVisibility())
			
			pipeline.InsertBefore(Boo.Lang.Compiler.Steps.ExpandDuckTypedExpressions,
						UnityScript.Steps.ProcessAssignmentToDuckMembers())
						
			pipeline.Replace(Boo.Lang.Compiler.Steps.ProcessMethodBodiesWithDuckTyping,
						UnityScript.Steps.ProcessUnityScriptMethods())
						
			pipeline.InsertAfter(UnityScript.Steps.ProcessUnityScriptMethods,
						UnityScript.Steps.AutoExplodeVarArgsInvocations())
						
			pipeline.InsertAfter(UnityScript.Steps.ProcessUnityScriptMethods,
						UnityScript.Steps.ProcessEvalInvocations())
						
			pipeline.ReplaceOptional(Boo.Lang.Compiler.Steps.ExpandDuckTypedExpressions,
						UnityScript.Steps.ExpandUnityDuckTypedExpressions())
						
			pipeline.InsertBefore(Boo.Lang.Compiler.Steps.EmitAssembly,
						UnityScript.Steps.Lint())
						
			pipeline.InsertBefore(Boo.Lang.Compiler.Steps.EmitAssembly,
						UnityScript.Steps.EnableRawArrayIndexing())
						
			pipeline.InsertAfter(Boo.Lang.Compiler.Steps.BindBaseTypes,
						UnityScript.Steps.CheckBaseTypes())
			
			return pipeline
			
[Extension]
def ReplaceOptional(pipeline as CompilerPipeline, optionalPipelineStepType as System.Type, step as ICompilerStep):
	index = pipeline.Find(optionalPipelineStepType)
	if index < 0: return
	pipeline.RemoveAt(index)
	pipeline.Insert(index-1, step)
	
