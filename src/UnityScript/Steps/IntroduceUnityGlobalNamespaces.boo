namespace UnityScript.Steps

import Boo.Lang.Compiler.TypeSystem.Core
import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.Steps

class IntroduceUnityGlobalNamespaces(AbstractCompilerStep):
	override def Run():
		NameResolutionService.Reset()		
		NameResolutionService.GlobalNamespace = NamespaceDelegator(
										NameResolutionService.GlobalNamespace,
										SafeGetNamespace("Boo.Lang"),
										TypeSystemServices.BuiltinsType,
										SafeGetNamespace("UnityScript.Lang"),
										TypeSystemServices.Map(UnityScript.Lang.UnityBuiltins),
										TypeSystemServices.Map(UnityScript.Lang.Extensions))
		
	def SafeGetNamespace(name as string):
		ns = NameResolutionService.ResolveQualifiedName("Boo.Lang")
		return ns or NullNamespace.Default
