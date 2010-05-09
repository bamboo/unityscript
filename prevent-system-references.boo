import System
import System.IO
import Mono.Cecil

def typeReferences(asmPath as string):
	asm = AssemblyFactory.GetAssembly(asmPath)
	for m as ModuleDefinition in asm.Modules:
		for typeRef as TypeReference in m.TypeReferences:
			yield typeRef
			
def header(title):
	print "*" * 10, title, "*" * 10
		
asmPath = Project.Properties["build.dir"]
#asmPath = "c:/projects/unityscript/bin/net-1.1/"
assemblies = ("UnityScript.dll", "UnityScript.Lang.dll", "Boo.Lang.dll")
for asm in assemblies:
	header asm
	for t in typeReferences(Path.Combine(asmPath, asm)):
		raise "${asm}: Unexpected System assembly reference '${t}'" if t.Scope.ToString().StartsWith("System,")
