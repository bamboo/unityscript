namespace UnityScript.MonoDevelop.Completion

import System
import System.Collections.Generic

import UnityScript
import UnityScript.MonoDevelop
import UnityScript.MonoDevelop.ProjectModel

import MonoDevelop.Core
import MonoDevelop.Projects
import MonoDevelop.Projects.Dom.Parser 
import MonoDevelop.Ide.Gui
import MonoDevelop.Ide.Gui.Content
import MonoDevelop.Ide.CodeCompletion

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.IO
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.PatternMatching

class UnityScriptEditorCompletion(CompletionTextEditorExtension):
	
	_dom as ProjectDom
	_resolver as UnityScriptTypeResolver
	_project as DotNetProject
	
	override def Initialize():
		super()
		_dom = ProjectDomService.GetProjectDom(Document.Project) or ProjectDomService.GetFileDom(Document.FileName)
		InstallUnityScriptSyntaxModeIfNeeded()
		_resolver = UnityScriptTypeResolver()
		_project = Document.Project as DotNetProject
		InitializeProjectReferences()
		
	def InitializeProjectReferences():
		if _project is null:
			return
				
		for reference in _project.References:
			if ReferenceType.Project != reference.ReferenceType:
				_resolver.AddReference(reference.Reference)
		
	def InstallUnityScriptSyntaxModeIfNeeded():
		view = Document.GetContent[of MonoDevelop.SourceEditor.SourceEditorView]()
		return if view is null
		
		mimeType = UnityScriptParser.MimeType
		return if view.Document.SyntaxMode.MimeType == mimeType
		
		mode = Mono.TextEditor.Highlighting.SyntaxModeService.GetSyntaxMode(mimeType)
		if mode is not null:
			view.Document.SyntaxMode = mode
		else:
			LoggingService.LogWarning(GetType() + " could not get SyntaxMode for mimetype '" + mimeType + "'.")
	
	override def ExtendsEditor(doc as MonoDevelop.Ide.Gui.Document, editor as IEditableTextBuffer):
		return IsUnityScriptFile(doc.Name)
		
	override def HandleCodeCompletion(context as CodeCompletionContext, completionChar as char):
#		print "HandleCodeCompletion(${context.ToString()}, ${completionChar.ToString()})"
		
		match completionChar.ToString():
			case ' ':
				lineText = GetLineText(context.TriggerLine).TrimStart()
				if not lineText.StartsWith("import "):
					return null
					
				return ImportCompletionDataFor('')
				
			case '.':
				lineText = GetLineText(context.TriggerLine)
				lineLength = lineText.Length
				lineText = lineText.TrimStart()
				trimmedLength = lineLength - lineText.Length
				if lineText.StartsWith("import "):
					nameSpace = lineText[len("import "):context.TriggerLineOffset-(2+trimmedLength)].Trim()
					return ImportCompletionDataFor(nameSpace)
					
				result = null as CompletionDataList
				text = string.Format ("{0}{1} {2}", Document.TextEditor.GetText (0, context.TriggerOffset),
				                                    CompletionFinder.CompletionToken,
				                                    Document.TextEditor.GetText (context.TriggerOffset, Document.TextEditor.TextLength))
				# print text
				_resolver.Input.Clear()
				_resolver.Input.Add(StringInput("completion text", text))
				
				result = CompletionDataList()
				resultHash = Dictionary[of string,string]()
					
				_resolver.ResolveAnd() do (type as IType):
					# print type
					domType = _dom.GetType(type.FullName)
					if (null != domType):
						for member in domType.Members:
							resultHash[SanitizeMemberName(type,member.Name)] = member.StockIcon
					else:
						for member in type.GetMembers():
							# print member
							resultHash[SanitizeMemberName(type,member.Name)] = GetIconForMember(member)
					
					for pair in resultHash:
						valid = not string.IsNullOrEmpty(pair.Key)
						for prefix as string in ["get_","set_","add_","remove_"]:
							if (pair.Key.StartsWith(prefix, StringComparison.Ordinal) and \
							    resultHash.ContainsKey(pair.Key[prefix.Length:])):
								valid = false
						if (valid):
							result.Add(pair.Key, pair.Value)
       
				return result
				
			otherwise:
				return null
				
	def ImportCompletionDataFor(nameSpace as string):
#		print "ImportCompletionDataFor(${nameSpace})"
		
		result = CompletionDataList()
		for member in _dom.GetNamespaceContents(nameSpace, true, true):
			result.Add(member.Name, member.StockIcon)
		return result
				
	def GetLineText(line as int):
		return Document.TextEditor.GetLineText(line)
		
	
	def GetIconForMember(member as IEntity):
		match member.EntityType:
			case EntityType.BuiltinFunction:
				return Stock.Method
			case EntityType.Constructor:
				return Stock.Method
			case EntityType.Method:
				return Stock.Method
			case EntityType.Local:
				return Stock.Field
			case EntityType.Field:
				return Stock.Field
			case EntityType.Property:
				return Stock.Property
			case EntityType.Event:
				return Stock.Event
			otherwise:
				return Stock.Literal
				
	def SanitizeMemberName(type as IType,memberName as string) as string:
		name = memberName
		if (0 <= (lastDot = name.LastIndexOf('.'))):
			name = name[lastDot+1:]
		if ("constructor" == name or "ctor" == name):
			name = type.Name
		if (name.StartsWith("internal_", StringComparison.OrdinalIgnoreCase) or name.StartsWith("op_", StringComparison.Ordinal)):
			name = string.Empty
		return name
		
