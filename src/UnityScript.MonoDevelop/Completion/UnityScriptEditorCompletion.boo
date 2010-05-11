namespace UnityScript.MonoDevelop.Completion

import UnityScript.MonoDevelop
import UnityScript.MonoDevelop.ProjectModel

import MonoDevelop.Projects.Dom.Parser 
import MonoDevelop.Ide.Gui.Content
import MonoDevelop.Ide.CodeCompletion

import Boo.Lang.PatternMatching

class UnityScriptEditorCompletion(CompletionTextEditorExtension):
	
	_dom as ProjectDom
	
	override def Initialize():
		super()
		_dom = ProjectDomService.GetProjectDom(Document.Project) or ProjectDomService.GetFileDom(Document.FileName)
		InstallUnityScriptSyntaxModeIfNeeded()
		
	def InstallUnityScriptSyntaxModeIfNeeded():
		view = Document.GetContent[of MonoDevelop.SourceEditor.SourceEditorView]()
		return if view is null
		
		mimeType = UnityScriptParser.MimeType
		return if view.Document.SyntaxMode.MimeType == mimeType
		
		mode = Mono.TextEditor.Highlighting.SyntaxModeService.GetSyntaxMode(mimeType)
		if mode is not null:
			view.Document.SyntaxMode = mode
		else:
			MonoDevelop.Core.LoggingService.LogWarning(GetType() + " could not get SyntaxMode for mimetype '" + mimeType + "'.")
	
	override def ExtendsEditor(doc as MonoDevelop.Ide.Gui.Document, editor as IEditableTextBuffer):
		return IsUnityScriptFile(doc.Name)
		
	override def HandleCodeCompletion(context as CodeCompletionContext, completionChar as char):
#		print "HandleCodeCompletion(${context.ToString()}, ${completionChar.ToString()})"
		
		match completionChar.ToString():
			case ' ':
				lineText = GetLineText(context.TriggerLine)
				if not lineText.StartsWith("import "):
					return null
					
				return ImportCompletionDataFor('')
				
			case '.':
				lineText = GetLineText(context.TriggerLine)
				if not lineText.StartsWith("import "):
					return null
				
				nameSpace = lineText[len("import "):context.TriggerLineOffset-2].Trim()
				return ImportCompletionDataFor(nameSpace)
				
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
		
	