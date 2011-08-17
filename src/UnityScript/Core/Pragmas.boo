namespace UnityScript.Core

import Boo.Lang.Compiler.Ast

static class Pragmas:
	
	public final Strict = "strict"
	
	public final Expando = "expando"
	
	public final Implicit = "implicit"
	
	public final Downcast = "downcast"
	
	final ValidPragmas = Strict, Expando, Implicit, Downcast
	
	final Enabled = object()
	
	final Disabled = object()
	
	All:
		get: return ValidPragmas[:]
	
	def IsValid(pragma as string):
		return pragma in ValidPragmas
		
	def IsEnabledOn(module as Module, pragma as string):
		return module[pragma] is Enabled
		
	def IsDisabledOn(module as Module, pragma as string):
		return module[pragma] is Disabled
		
	def TryToEnableOn(module as Module, pragma as string):
		if module.ContainsAnnotation(pragma):
			return false
		module.Annotate(pragma, Enabled) 
		return true
		
	def DisableOn(module as Module, pragma as string):
		module[pragma] = Disabled