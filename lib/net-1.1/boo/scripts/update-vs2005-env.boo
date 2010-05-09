import System.Xml
import System.IO
import System.Resources
import System.Windows.Forms
import Useful.IO from Boo.Lang.Useful

class XmlDocumentWrapper:

	_document as XmlDocument

	def constructor([required] document as XmlDocument):
		_document = document

	def constructor(fname as string):
		_document = XmlDocument()
		_document.Load(fname)

	NamespaceURI:
		get:
			xmlns = _document.DocumentElement.Attributes["xmlns"]
			if xmlns is null: return null
			return xmlns.Value

	BaseURI:
		get:
			return System.Uri(_document.BaseURI)

	AbsolutePath:
		get:
			return BaseURI.AbsolutePath

	def Save():
		_document.Save(AbsolutePath)
		
class Project(XmlDocumentWrapper):

	static def Load(fname as string):
		try:
			doc = XmlDocument()
			doc.Load(fname)
			if fname.EndsWith(".mdp"):
				return MDProject(doc)
			return VS2003Project(doc)
		except x:
			raise System.ApplicationException(fname, x)

	_sourceFiles as XmlElement
	
	def constructor(document as XmlDocument, [required] sourceFiles as XmlElement):
		super(document)
		_sourceFiles = sourceFiles
		
	def ResetSourceFiles():
		_sourceFiles.RemoveAll()

	def AddSourceFile(item as string):
		_sourceFiles.AppendChild(CreateSourceElement(item))

	protected abstract def CreateSourceElement(src as string) as XmlElement:
		pass

class MDProject(Project):
	def constructor(document as XmlDocument):
		super(document, document.SelectSingleNode("/Project/Contents"))
		
	override protected def CreateSourceElement(src as string):
		file = _document.CreateElement("File", NamespaceURI)
		file.SetAttribute("name", src)
		file.SetAttribute("buildaction", "Compile")
		file.SetAttribute("subtype", "Code")
		return file

class VS2003Project(Project):

	def constructor(document as XmlDocument):
		super(document, sourceFilesElement(document))
		
	private def sourceFilesElement(document as XmlDocument):
		return document.SelectSingleNode("/VisualStudioProject/CSHARP/Files/Include")

	override protected def CreateSourceElement(src as string):
		file = _document.CreateElement("File")
		file.SetAttribute("RelPath", src.Replace('/', '\\'))
		file.SetAttribute("SubType", "Code")
		file.SetAttribute("BuildAction", "Compile")
		return file

def updateProjectFile(fname as string):
	project = Project.Load(fname)
	project.ResetSourceFiles()

	baseURI = project.BaseURI
	for item as string in listFiles(Path.GetDirectoryName(baseURI.AbsolutePath)):
		if item =~ /\.svn/: continue
		if not item.EndsWith(".cs"): continue
		uri = baseURI.MakeRelative(System.Uri(item))
		project.AddSourceFile(uri)
	project.Save()

	print project.AbsolutePath


def updateStringResources(txtFile as string):
	fname = Path.ChangeExtension(txtFile, ".resx")
	File.Delete(fname)

	using resourceFile = ResXResourceWriter(fname):

		using file=File.OpenText(txtFile):
			for line in file:
				if line.StartsWith(";"): continue
				line = line.Trim()
				if len(line) == 0: continue
				index = line.IndexOf('=')
				key = line[:index]
				value = line[index+1:]

				resourceFile.AddResource(key, value)

	print fname

def rebase(fname as string):
	#return Path.Combine("c:/projects/boo/", fname)
	return fname

fnames = (
#"src/Boo.Lang/Boo.Lang.csproj",
"src/Boo.Lang.Parser/Boo.Lang.Parser.csproj",
"src/Boo.Lang.Compiler/Boo.Lang.Compiler.csproj",
"src/booc/booc.csproj",
"tests/BooCompiler.Tests/BooCompiler.Tests.csproj",
"tests/Boo.Lang.Parser.Tests/Boo.Lang.Parser.Tests.csproj",
"tests/Boo.Lang.Runtime.Tests/Boo.Lang.Runtime.Tests.csproj",
"src/Boo.Lang.Compiler/Boo.Lang.Compiler.mdp",
)
for fname in fnames:
	updateProjectFile(rebase(fname))

updateStringResources(rebase("src/Boo.Lang/Resources/strings.txt"))
