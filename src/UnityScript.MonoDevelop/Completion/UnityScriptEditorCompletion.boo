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
					
				_resolver.ResolveAnd() do (type as IType):
					resultHash = Dictionary[of string,string]()
					for member in type.GetMembers():
						# print member
						resultHash[SanitizeMemberName(type,member)] = GetIconForMember(member)
					for pair in resultHash:
						unless string.IsNullOrEmpty(pair.Key) or (4 < pair.Key.Length and /^[gs]et_/.Matches(pair.Key) and resultHash.ContainsKey(pair.Key[4:])):
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
		
	
	# <summary>
	# Gets the proper stock icon for an IEntity
	# </summary>
	# <param name="member">The member whose icon is wanted</param>
	# <returns>A stock icon string</returns>
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
				
	# <summary>
	# Sanitizes the member names we get from the compiler pipeline
	# </summary>
	# <param name="type">The type to which the member belongs</param>
	# <param name="member">The member whose name should be sanitized</param>
	# <returns>The sanitized name (empty for invalid)</returns>
	def SanitizeMemberName(type as IType,member as IEntity) as string:
		name = member.Name
		if (0 <= (lastDot = name.LastIndexOf('.'))):
			name = name[lastDot:]
		if ("constructor" == name):
			name = type.Name
		if (name.StartsWith("internal_", StringComparison.OrdinalIgnoreCase)):
			name = string.Empty
		return name
		
