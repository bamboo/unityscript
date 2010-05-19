namespace us

import System.IO
import Boo.Lang.Compiler
import Boo.Lang.Useful.CommandLine

class CommandLineOptions(AbstractCommandLine):
	
	[getter(References)]
	_references = []
	
	[getter(Resources)]
	_resources = []
	
	[getter(OutputType)]
	_outputTarget = CompilerOutputType.Library
	
	[getter(Imports)]
	_imports = []
	
	[getter(SourceFiles)]
	_sourceFiles = []
	
	[getter(SourceDirs)]
	_srcDirs = []
	
	[getter(SuppressedWarnings)]
	_suppressedWarnings = []
	
	[getter(Defines)]
	_defines = []
	
	[getter(Pragmas)]
	_pragmas = List of string()
	
	def constructor(*argv as (string)):
		Parse(argv)
		
	def GetAllSourceFiles():
		
		for srcFile as string in _sourceFiles:
			yield srcFile
			
		for srcDir in _srcDirs:
			for fname in Directory.GetFiles(srcDir, "*.js"):
				yield fname

		
	IsValid:
		get:
			return (len(self.BaseClass) > 0
					and len(self.MainMethod) > 0
					and	(len(self.SourceFiles) > 0
						or len(self.SourceDirs) > 0))
		
	[Option("Specifies the output {file} name", ShortForm: "o", LongForm: "out")]
	public Output  = ""

	[Option("Base {class} for the script module", ShortForm: "b", LongForm: "base")]
	public BaseClass = ""
	
	[Option("Module's main method {name}", ShortForm: 'm', LongForm: "method")]
	public MainMethod = ""
	
	[Option("Print the resulting code (in boo). Do not generate an assembly.", ShortForm: 'p', LongForm: "print")]
	public PrintCode = false
	
	[Option("Execute resulting main method.", ShortForm: 'x', LongForm: 'execute')]
	public Execute = false

	[Option("Enable duck typing.", LongForm: "ducky")]
	public Ducky = false
	
	[Option("Enable expando mode.", LongForm: "expando")]
	public Expando = false

	[Option("Enable writing debug symbols.", LongForm: "debug")]
	public Debug = false
	
	[Option("Displays internal compiler information", LongForm: "debug-compiler")]
	public DebugCompiler = false
	
	[Option("Enable verbose mode.", LongForm: "verbose")]
	public Verbose = false
	
	[Option("Enables a comma separated {set} of #pragma directives on every module", LongForm: "pragmas", MaxOccurs: int.MaxValue)]
	def AddPragmas(pragmas as string):
		_pragmas.ExtendUnique(pragma.Trim() for pragma in pragmas.Split(char(',')))

	[Option("References the specified {assembly}", ShortForm: 'r', LongForm: "reference", MaxOccurs: int.MaxValue)]
	def AddReference(reference as string):
		_references.AddUnique(reference)
		
	[Option("Includes all *.js files from {srcdir}", LongForm: "srcdir", MaxOccurs: int.MaxValue)]
	def AddSourceDir(srcDir as string):
		_srcDirs.AddUnique(Path.GetFullPath(srcDir))
		
	[Option("Embed a managed resource {file}", LongForm: "resource", MaxOccurs: int.MaxValue)]
	def AddResource(resource as string):
		_resources.AddUnique(resource)
		
	[Option("Suppress the warning {code}", LongForm: "nowarn", MaxOccurs: int.MaxValue)]
	def SuppressWarning(code as string):
		_suppressedWarnings.Add(code)
		
	[Option("Specifies the target ({kind} is one of: exe, winexe, library)", ShortForm: 't', LongForm: "target")]
	def SetTarget(kind as string):
		if kind == "library":
			_outputTarget = CompilerOutputType.Library
		elif kind == "exe":
			_outputTarget = CompilerOutputType.ConsoleApplication
		elif kind == "winexe":
			_outputTarget = CompilerOutputType.WindowsApplication
		else:
			InvalidOption(" Valid options for -target: are exe, winexe, library or module")
		
	[Option("Adds a 'import {namespace}' to the script module", ShortForm: 'i', LongForm: "import", MaxOccurs: int.MaxValue)]
	def AddImport(ns as string):
		_imports.Add(ns)
		
	[Option("Defines a symbol", ShortForm: 'd', LongForm: "define", MaxOccurs: int.MaxValue)]
	def AddDefine(symbol as string):
		_defines.Add(symbol)
	
	[Option("display this help and exit", LongForm: "help")]
	public DoHelp = false
		
	[Argument]
	def AddSourceFile([required] sourceFile as string):
		self.SourceFiles.Add(sourceFile)
		
	private def InvalidOption(msg as string):
		raise msg
