namespace UnityScript.Tests

import System
import System.IO
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast 
import Boo.Lang.Compiler.Steps

class PEVerify(AbstractCompilerStep):
	
	override def Run():
		if len(Errors) > 0:
			return
			
		command, args = PlatformDependentPEVerifyCommandAndArguments()
		try:
			p = StartProcess(Path.GetDirectoryName(Parameters.OutputAssembly), command, args)
			p.WaitForExit()
			if (0 != p.ExitCode):
				Errors.Add(CompilerError(LexicalInfo.Empty, p.StandardOutput.ReadToEnd()))
		except e:
			Warnings.Add(CompilerWarning("Could not start " + command))
			Context.TraceWarning("Could not start " + command +" : " + e.Message)
			
	private def PlatformDependentPEVerifyCommandAndArguments():
		platform = Environment.OSVersion.Platform
		if platform == System.PlatformID.Unix or platform == 128: // mono's PlatformID.Unix workaround on 1.1
			return "pedump", "--verify all \"" + Context.GeneratedAssemblyFileName + "\""
		return "peverify.exe", "\"" + Context.GeneratedAssemblyFileName + "\""
			
def StartProcess(workingDir as string, command as string, arguments as string):
	p = System.Diagnostics.Process()
	p.StartInfo.CreateNoWindow = true
	p.StartInfo.UseShellExecute = false
	p.StartInfo.RedirectStandardOutput = true
	p.StartInfo.WorkingDirectory = workingDir
	p.StartInfo.Arguments = arguments
	p.StartInfo.FileName = command
	p.StartInfo.EnvironmentVariables["MONO_PATH"] = workingDir // pedump won't find the dependent assemblies otherwise
	p.Start()
	return p

