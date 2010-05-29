namespace us

import System
import System.Reflection
import System.IO
import Boo.Lang.Compiler

def Main([required] argv as (string)) as int:
	try:
		return run(argv)
	except x:
		print "Error:", x
	return 255

def getAssemblyTitle():
	return cast(AssemblyTitleAttribute, getAssemblyAttribute(AssemblyTitleAttribute)).Title
	
def getAssemblyVersion():
	return Assembly.GetExecutingAssembly().GetName().Version
	
def getAssemblyCopyright():
	return cast(AssemblyCopyrightAttribute, getAssemblyAttribute(AssemblyCopyrightAttribute)).Copyright
	
def getAssemblyAttribute(type as System.Type):
	return Attribute.GetCustomAttribute(Assembly.GetExecutingAssembly(), type)

def compile(options as CommandLineOptions):
	
	compiler = UnityScriptCompilerFactory.FromCommandLineOptions(options)
	results = compiler.Run()
	if len(results.Errors):
		print results.Errors.ToString(options.Verbose)
		return 255
	else:
		if options.Execute:
			execute(results, options.MainMethod)
		else:
			print results.Warnings.ToString() if len(results.Warnings)
			print "Successfully compiled '${len(compiler.Parameters.Input)}' file(s) to '${results.GeneratedAssemblyFileName}'."
	return 0
	
def execute(result as CompilerContext, mainMethod as string):
	for type in result.GeneratedAssembly.GetTypes():
		method = type.GetMethod(mainMethod)
		if method is not null:
			method.Invoke(type(), (,))
		
def banner():
	print "${getAssemblyTitle()} - ${getAssemblyVersion()} ${getAssemblyCopyright()}"
	print

def run(argv as (string)):
	options = parseCommandLineOptions(argv)
	
	if options.IsValid and not options.DoHelp:
		try:
			return compile(options)
		except x as ApplicationException:
			print "ERROR:", x.Message
		except x:
			print "ERROR:", x
	else:
		usage(options)
		
	return 255
	
def parseCommandLineOptions(argv as (string)):
	if len(argv) == 1 and argv[0].StartsWith("@"):
		return CommandLineOptions(*parseResponseFile(argv[0][1:]))
	return CommandLineOptions(*argv)
	
def parseResponseFile(responseFile as string):
	args = []
	
	using reader = File.OpenText(responseFile):
		for line in reader:
			for arg in /\s+/.Split(line):
				continue if len(arg) == 0
				args.Add(unquote(arg))
				
	return array(string, args)
	
def unquote(s as string):
	if s.StartsWith('"'): return s[1:-1]
	return s

def usage(options as CommandLineOptions):
	banner()
	options.PrintOptions()
