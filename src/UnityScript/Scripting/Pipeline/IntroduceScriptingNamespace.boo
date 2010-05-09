namespace UnityScript.Scripting.Pipeline

import System
import System.Collections.Generic
import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.TypeSystem
import UnityScript.Scripting

class IntroduceScriptingNamespace(AbstractCompilerStep):
"""
Makes the compiler take the EvaluationContext namespace into
consideration.
"""
	
	_evaluationContext as EvaluationContext
	
	def constructor(evaluationContext as EvaluationContext):
		_evaluationContext = evaluationContext
		
	override def Run():
		NameResolutionService.GlobalNamespace = EvaluationContextNamespace(
													self.TypeSystemServices,
													NameResolutionService.GlobalNamespace,
													_evaluationContext)
			
class EvaluationContextEntity(ITypedEntity):
	
	[getter(Delegate)]
	_delegate as IMember

	def constructor(delegate as IMember):
		_delegate = delegate
	
	Name as string:
		get: return _delegate.Name
	
	FullName as string:
		get: return _delegate.FullName
	
	EntityType as EntityType:
		get: return _delegate.EntityType
	
	Type as IType:
		get: return _delegate.Type
		
class ActiveScriptEntity(EvaluationContextEntity):
	
	[getter(Script)]
	_scriptId as int
	
	def constructor(scriptId as int, delegate as IMember):
		super(delegate)
		_scriptId = scriptId
	
class EvaluationContextNamespace(INamespace):
	
	_tss as TypeSystemServices
	_parent as INamespace
	_context as EvaluationContext
	_contextNamespace as INamespace
	_scriptContainerNamespace as INamespace
	_entityMapping = {}
	_activeScripts as (object)
	
	def constructor([required] tss as TypeSystemServices, [required] parent as INamespace, [required] context as EvaluationContext):
		_tss = tss
		_parent = parent
		_context = context
		_contextNamespace = tss.Map(_context.GetType())
		_scriptContainerNamespace = tss.Map(_context.GetType().DeclaringType)
		_activeScripts = _context.GetActiveScripts()
		
	Name:
		get: return "EvaluationContext"
		
	FullName:
		get: return Name
		
	EntityType:
		get: return EntityType.Namespace
	
	ParentNamespace as INamespace:
		get: return _parent
	
	def Resolve(targetList as ICollection of IEntity, name as string, filter as EntityType) as bool:
		if Resolve(_contextNamespace, targetList, name, filter): return true
		if Resolve(_scriptContainerNamespace, targetList, name, filter): return true
		
		for script in _activeScripts:
			mapActiveScript as EntityMapper = { entity as IEntity | ActiveScriptEntity(_context.GetActiveScriptId(script), entity) }
			scriptType = _tss.Map(script.GetType())
			if Resolve(scriptType, targetList, name, filter, mapActiveScript): return true
				
		return false
				
		
	def Resolve(ns as INamespace, targetList as ICollection of IEntity, name as string, filter as EntityType) as bool:
		return Resolve(ns, targetList, name, filter, { entity as IEntity | EvaluationContextEntity(entity) })
		
	def Resolve(ns as INamespace, targetList as ICollection of IEntity, name as string, filter as EntityType, mapper as EntityMapper) as bool:
		found = List[of IEntity]()
		if not ns.Resolve(found, name, filter): return false
		for entity in found:
			targetList.Add(MapEntity(entity, mapper))
		return true
		
	callable EntityMapper(entity as IEntity) as EvaluationContextEntity
		
	def MapEntity(entity as IEntity, mapper as EntityMapper):
		found = _entityMapping[entity]
		if found is not null: return found
		_entityMapping[entity] = found = mapper(entity)
		return found
	
	def GetMembers() as IEntity*:
		pass
		

