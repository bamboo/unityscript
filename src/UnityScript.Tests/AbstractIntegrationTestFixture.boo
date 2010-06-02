namespace UnityScript.Tests

import System
import System.IO
import Boo.Lang.Compiler
import NUnit.Framework
import UnityScript
import System.Globalization
import System.Threading

class AbstractIntegrationTestFixture(AbstractCompilerTestFixture):
	
	override DisplayErrorStackTrace:
		get: return true
	
	OutputAssemblyPath:
		get: return Path.Combine(
						Path.Combine(Path.GetTempPath(), "UnityScript"),
						GetType().Name)

	[TestFixtureSetUp]
	override def SetUpFixture():
		super()	
		if Directory.Exists(OutputAssemblyPath): Directory.Delete(OutputAssemblyPath, true)
		Directory.CreateDirectory(OutputAssemblyPath)
		CopyReferencedAssemblies()
		
	override def CompileTestCase(fname as string):
		_compiler.Parameters.OutputAssembly = Path.Combine(OutputAssemblyPath, GetType().Name.Replace("TestFixture", "") + "-" + Path.GetFileNameWithoutExtension(fname) + ".exe")
		return super(fname)
		
	def CopyReferencedAssemblies():
		CopyParentAssembly(UnityScriptCompiler)
		CopyParentAssembly(UnityScript.Lang.Array)
		CopyParentAssembly(Boo.Lang.List)
		CopyParentAssembly(Boo.Lang.Compiler.BooCompiler)
		CopyParentAssembly(GetType())
		CopyParentAssembly(UnityScript.Tests.CSharp.FooBarEnum)
		CopyParentAssembly(Assert)
		
	def CopyParentAssembly(type as System.Type):
		CopyFile(type.Module.FullyQualifiedName)
		
	def CopyFile(fname as string):
		targetFile = Path.Combine(OutputAssemblyPath, Path.GetFileName(fname))
		if IsNewerFile(fname, targetFile): File.Copy(fname, targetFile, true)
		
	def IsNewerFile(fname1 as string, fname2 as string):
		if not File.Exists(fname2): return true
		return File.GetLastWriteTime(fname1) > File.GetLastWriteTime(fname2)
		
	override def CreateCompiler():
		compiler = super()
		compiler.Parameters.GenerateInMemory = false
		return compiler
	
	override protected def CreateCompilerPipeline():
		pipeline = UnityScriptCompiler.Pipelines.CompileToFile()
		if VerifyGeneratedAssemblies:
			pipeline.Add(PEVerify())
		return pipeline
		
	protected VerifyGeneratedAssemblies:
		get: return GetEnvironmentFlag("peverify", true)
		
	protected def GetEnvironmentFlag(name as string, defaultValue as bool):
		value = Environment.GetEnvironmentVariable(name)
		if null == value: return defaultValue
		return bool.Parse(value)
		
	override protected def GetActualOutput(result as CompilerContext):
		assert 0 == len(result.Errors), result.Errors.ToString()
		type = GetMainType(result)
				
		savedCulture = Thread.CurrentThread.CurrentCulture
		saved = Console.Out
		
		Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture
		Console.SetOut(console=StringWriter())
		try:
			ExecuteScript(type)
		ensure:
			Console.SetOut(saved)
			Thread.CurrentThread.CurrentCulture = savedCulture
		return console.ToString()
		
	virtual protected def ExecuteScript(scriptType as System.Type):
		script as duck = scriptType()
		script.Awake()
		
	def GetMainType(result as CompilerContext):		
		return System.Reflection.Assembly.LoadFrom(result.GeneratedAssemblyFileName).GetType(result.CompileUnit.Modules[0].Name)
		
	
		
