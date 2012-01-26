namespace us

import System
import System.Reflection
import Boo.Lang.Compiler

def Main(argv as (string)):
	try:
		return runWithCommandLine(argv)
	except x as TargetInvocationException:
		print "Execution error: ", x.InnerException
	except x as ApplicationException:
		print "Error:", x.Message
	except x:
		print "Error:", x
	return 255
	
def runWithCommandLine(commandLine as (string)):
	options = parseCommandLineOptions(commandLine)
	if options.IsValid and not options.DoHelp:
		return compile(options)
	usage(options)
	return 255
	
def parseCommandLineOptions(commandLine as (string)):
	return CommandLineOptions(*commandLine)
	
def compile(options as CommandLineOptions):
	compiler = UnityScriptCompilerFactory.FromCommandLineOptions(options)
	results = compiler.Run()
	
	if len(results.Errors):
		print results.Errors.ToString(options.Verbose)
		return 255
		
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
	
def usage(options as CommandLineOptions):
	banner()
	options.PrintOptions()
	
def banner():
	print "${getAssemblyTitle()} - ${getAssemblyVersion()} ${getAssemblyCopyright()}"
	print

def getAssemblyTitle():
	return getAssemblyAttribute[of AssemblyTitleAttribute]().Title
	
def getAssemblyVersion():
	return Assembly.GetExecutingAssembly().GetName().Version
	
def getAssemblyCopyright():
	return getAssemblyAttribute[of AssemblyCopyrightAttribute]().Copyright
	
def getAssemblyAttribute[of T(System.Attribute)]() as T:
	return Attribute.GetCustomAttribute(Assembly.GetExecutingAssembly(), T)
	
