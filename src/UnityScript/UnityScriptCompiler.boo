namespace UnityScript

import Boo.Lang.Compiler

class UnityScriptCompiler:

	[getter(Parameters)]
	_parameters = UnityScriptCompilerParameters()
	_compiler = BooCompiler(_parameters)

	def Run():
		return _compiler.Run()
		
	def Run(compileUnit as Boo.Lang.Compiler.Ast.CompileUnit):
		return _compiler.Run(compileUnit)
		
	class Pipelines:
	
		static def RawParsing():
			pipeline = CompilerPipeline()
			pipeline.Add(UnityScript.Steps.PreProcess())
			pipeline.Add(UnityScript.Steps.Parse())
			return pipeline
		
		static def Parse():
			pipeline = RawParsing()
			pipeline.Add(UnityScript.Steps.ApplySemantics())
			return pipeline
			
		static def Compile():
			return AdjustBooPipeline(Boo.Lang.Compiler.Pipelines.Compile())
		
		static def CompileToMemory():
			return AdjustBooPipeline(Boo.Lang.Compiler.Pipelines.CompileToMemory())
			
		static def CompileToFile():
			return AdjustBooPipeline(Boo.Lang.Compiler.Pipelines.CompileToFile())
			
		static def CompileToBoo():
			return AdjustBooPipeline(Boo.Lang.Compiler.Pipelines.CompileToBoo())
			
		static def AdjustBooPipeline(pipeline as CompilerPipeline):
			pipeline.Insert(0, UnityScript.Steps.PreProcess())
			
			pipeline.Replace(Boo.Lang.Parser.BooParsingStep, UnityScript.Steps.Parse())
			
			pipeline.Replace(Boo.Lang.Compiler.Steps.InitializeTypeSystemServices,
						UnityScript.Steps.InitializeUnityScriptTypeSystem())
						
			pipeline.Replace(Boo.Lang.Compiler.Steps.IntroduceGlobalNamespaces,
						UnityScript.Steps.IntroduceUnityGlobalNamespaces())
						
			pipeline.InsertAfter(Boo.Lang.Compiler.Steps.PreErrorChecking,
								UnityScript.Steps.ApplySemantics())
								
			pipeline.InsertBefore(Boo.Lang.Compiler.Steps.ExpandDuckTypedExpressions,
						UnityScript.Steps.ProcessAssignmentToDuckMembers())
						
			pipeline.Replace(Boo.Lang.Compiler.Steps.ProcessMethodBodiesWithDuckTyping,
						UnityScript.Steps.ProcessUnityScriptMethods())
						
			pipeline.InsertAfter(UnityScript.Steps.ProcessUnityScriptMethods,
						UnityScript.Steps.ProcessEvalInvocations())
						
			pipeline.ReplaceOptional(Boo.Lang.Compiler.Steps.ExpandDuckTypedExpressions,
						UnityScript.Steps.ExpandUnityDuckTypedExpressions())
						
			pipeline.ReplaceOptional(Boo.Lang.Compiler.Steps.ExpandVarArgsMethodInvocations,
						UnityScript.Steps.UnityExpandVarArgsMethodInvocations())
						
			pipeline.InsertBefore(Boo.Lang.Compiler.Steps.EmitAssembly,
						UnityScript.Steps.EnableRawArrayIndexing())
						
			pipeline.InsertAfter(Boo.Lang.Compiler.Steps.BindBaseTypes,
						UnityScript.Steps.CheckBaseTypes())
			
			return pipeline
			
[Extension] def ReplaceOptional(pipeline as CompilerPipeline, optionalPipelineStepType as System.Type, step as ICompilerStep):
	index = pipeline.Find(optionalPipelineStepType)
	if index < 0: return
	pipeline.RemoveAt(index)
	pipeline.Insert(index-1, step)
	
