namespace UnityScript.MonoDevelop.Completion

import UnityScript

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.IO
import Boo.Lang.Compiler.TypeSystem

class UnityScriptTypeResolver:

       _compiler = UnityScriptCompiler()

       def constructor():
               pipeline = UnityScriptCompiler.Pipelines.AdjustBooPipeline(Boo.Lang.Compiler.Pipelines.Compile())
               pipeline.InsertAfter(UnityScript.Steps.Parse, ResolveMonoBehaviourType())
               pipeline.BreakOnErrors = false

               _compiler.Parameters.ScriptMainMethod = "Awake"
               _compiler.Parameters.Pipeline = pipeline
               imports = _compiler.Parameters.Imports
               imports.Add("UnityEngine")
               imports.Add("System.Collections")

       Input:
               get: return Parameters.Input

       References:
               get: return Parameters.References

       Parameters:
               private get: return _compiler.Parameters

       def AddReference(reference as string):
               References.Add(Parameters.LoadAssembly(reference, true))

       def Run():
               result = _compiler.Run()
               for error in result.Errors:
                       print error
               return result.CompileUnit