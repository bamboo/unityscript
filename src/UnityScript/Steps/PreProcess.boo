namespace UnityScript.Steps

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.IO
import Boo.Lang.Useful.IO

class PreProcess(AbstractCompilerStep):

	override def Run():
		
		processed = List[of ICompilerInput]()
		
		for input in Parameters.Input:
			processed.Add(RunPreProcessorOn(input))
			
		Parameters.Input.Clear()
		Parameters.Input.Extend(processed)
		
	private def RunPreProcessorOn(input as ICompilerInput):
		processor = PreProcessor(Parameters.Defines.Keys, PreserveLines: true)
		using reader = input.Open():
			output = System.IO.StringWriter()
			processor.Process(reader, output)
			return StringInput(input.Name, output.ToString())