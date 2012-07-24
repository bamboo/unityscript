namespace us

import UnityScript
import Boo.Lang.Compiler
import Boo.Lang.Compiler.IO
import Boo.Lang.Compiler.Resources

import Boo.Lang.Compiler.TypeSystem.Services

import System.IO

import System.Diagnostics

class UnityScriptCompilerFactory:

	static def FromCommandLineOptions(options as CommandLineOptions):
		compiler = UnityScriptCompiler()
		
		assemblies = []
		for reference as string in options.References:
			asm = loadAssembly(reference)
			assemblies.Add(asm)
			compiler.Parameters.References.Add(asm)
			
		options.ForEachSourceFile() do (fname):
			compiler.Parameters.Input.Add(FileInput(fname))
			
		for resource in options.Resources:
			compiler.Parameters.Resources.Add(FileResource(resource))
			
		if len(options.Output) > 0:
			compiler.Parameters.OutputAssembly = options.Output
			
		for define in options.Defines:
			compiler.Parameters.Defines.Add(define, define)
			
		compiler.Parameters.OutputType = options.OutputType
		
		if options.Verbose:
			compiler.Parameters.TraceLevel = TraceLevel.Info
			
		if options.Execute:
			compiler.Parameters.GenerateInMemory = true
		
		if options.PrintCode:
			compiler.Parameters.Pipeline = UnityScriptCompiler.Pipelines.CompileToBoo()
		else:
			compiler.Parameters.Pipeline = UnityScriptCompiler.Pipelines.CompileToFile()
			
		if len(options.SuppressedWarnings):
			compiler.Parameters.Pipeline.Insert(
				0,
				UnityScript.Steps.SuppressWarnings(options.SuppressedWarnings))
				
		if len(options.Pragmas):
			compiler.Parameters.Pipeline.InsertAfter(
				UnityScript.Steps.Parse,
				UnityScript.Steps.IntroducePragmas(options.Pragmas))
	
		baseType = resolveType(assemblies, options.BaseClass)	  
		compiler.Parameters.ScriptBaseType = baseType
		compiler.Parameters.ScriptMainMethod = options.MainMethod
		compiler.Parameters.Debug = options.Debug
		compiler.Parameters.Expando = options.Expando
		compiler.Parameters.DisableEval = options.DisableEval
		compiler.Parameters.Imports.AddRange(options.Imports)
		
		if options.TypeInferenceRuleAttribute:
			compiler.Parameters.AddToEnvironment(
				TypeInferenceRuleProvider,
				{ CustomTypeInferenceRuleProvider(options.TypeInferenceRuleAttribute) })
		
		if options.DebugCompiler:
			compiler.Parameters.Pipeline.BeforeStep += do(sender, args as CompilerStepEventArgs):
				print "*" * 25
				print "=" * 5, args.Step, "=" * 5
				
			compiler.Parameters.Pipeline.AfterStep += do(sender, args as CompilerStepEventArgs):
				print args.Context.CompileUnit.ToCodeString()
				print "*" * 25
				
		return compiler
		
def resolveType(assemblies, typeName as string):
	for asm as System.Reflection.Assembly in assemblies:
		type = asm.GetType(typeName)
		return type if type is not null
		
	systemType = Type.GetType(typeName, false)
	return systemType if systemType is not null
	
	raise "'${typeName}' was not found in any of the referenced assemblies"
	
def loadAssembly(name as string):
	if File.Exists(name):
		return Assembly.LoadFrom(name)
	return Assembly.Load(name)
	