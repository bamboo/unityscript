namespace UnityScript.MonoDevelop.ProjectModel

import MonoDevelop.Core
import MonoDevelop.Projects

import System.IO

import Boo.Lang.PatternMatching

class UnityScriptCompiler:
	
	_config as DotNetProjectConfiguration
	_selector as ConfigurationSelector
	_projectItems as ProjectItemCollection
	_compilationParameters as UnityScriptCompilationParameters
	_projectParameters as UnityScriptProjectParameters
	
	def constructor(
		config as DotNetProjectConfiguration,
		selector as ConfigurationSelector,
		projectItems as ProjectItemCollection,
		progressMonitor as IProgressMonitor):
		
		_config = config
		_selector = selector
		_projectItems = projectItems
		_compilationParameters = config.CompilationParameters or UnityScriptCompilationParameters()
		_projectParameters = config.ProjectParameters or UnityScriptProjectParameters()
		
	def Run() as BuildResult:
		responseFileName = Path.GetTempFileName()
		try:
			WriteOptionsToResponseFile(responseFileName)
			compiler = MapPath("bin/net-2.0/us.exe")
			compilerOutput = ExecuteProcess(compiler, "@${responseFileName}")
			return ParseBuildResult(compilerOutput)
		ensure:
			FileService.DeleteFile(responseFileName)
			
	private def WriteOptionsToResponseFile(responseFileName as string):
		commandLine = StringWriter()
		
		commandLine.WriteLine("-base:System.Object")
		commandLine.WriteLine("-method:Awake")
		commandLine.WriteLine("-debug+")
		commandLine.WriteLine("-t:exe")
		commandLine.WriteLine("-out:${_config.CompiledOutputName}")
		
		projectFiles = item as ProjectFile for item in _projectItems if item isa ProjectFile 
		for file in projectFiles:
			continue if file.Subtype == Subtype.Directory
			
			match file.BuildAction:
				case "Compile":
					commandLine.WriteLine("\"${file.Name}\"")
				otherwise:
					print "Unrecognized build action:", file.BuildAction
		
		commandLineString = commandLine.ToString()
		print commandLineString
		File.WriteAllText(responseFileName, commandLineString)
		
	private def MapPath(path as string):
		return Path.Combine(Path.GetDirectoryName(GetType().Assembly.Location), path)
		
	private def ExecuteProcess(executable as string, commandLine as string):
		startInfo = System.Diagnostics.ProcessStartInfo(executable, commandLine,
						UseShellExecute: false,
						RedirectStandardOutput: true,
						RedirectStandardError: true)
		
		using process = Runtime.SystemAssemblyService.CurrentRuntime.ExecuteAssembly(startInfo, _config.TargetFramework):
			process.WaitForExit()
			return process.StandardOutput.ReadToEnd() + System.Environment.NewLine + process.StandardError.ReadToEnd()
			
	private def ParseBuildResult(stdout as string):
		
		result = BuildResult()
		
		for line in StringReader(stdout):
			match line:
				case /(?<fileName>.+)\((?<lineNumber>\d+),(?<column>\d+)\):\s+(?<code>.+?):\s+(?<message>.+)/:
					result.Append(BuildError(
								FileName: fileName[0].Value,
								Line: int.Parse(lineNumber[0].Value),
								Column: int.Parse(column[0].Value),
								IsWarning: code[0].Value.StartsWith("BCW"),
								ErrorNumber: code[0].Value,
								ErrorText: message[0].Value))
					
				case /(?<code>.+):\s+(?<message>.+)/:
					result.Append(
						BuildError(
								ErrorNumber: code[0].Value,
								ErrorText: message[0].Value))
					
				otherwise:			
					unrecognized = len(line) > 0 \
						and not line.StartsWith("Successfully compiled '")
								
					if unrecognized: print "Unrecognized compiler output:", line
		
		return result
