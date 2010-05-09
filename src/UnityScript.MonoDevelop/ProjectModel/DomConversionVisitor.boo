namespace UnityScript.MonoDevelop.ProjectModel

import Boo.Lang.Compiler.Ast
import MonoDevelop.Projects.Dom as MD
import Boo.Lang.PatternMatching

class DomConversionVisitor(DepthFirstVisitor):
	
	_result as MD.CompilationUnit
	_currentType as MD.DomType
	_namespace as string
	
	def constructor(result as MD.CompilationUnit):
		_result = result
		
	override def OnModule(node as Module):
		_namespace = null
		Visit(node.Namespace)
		Visit(node.Members)
		
	override def OnNamespaceDeclaration(node as NamespaceDeclaration):
		_namespace = node.Name
		region = BodyRegionOf(node.ParentNode)
		domUsing = MD.DomUsing(IsFromNamespace: true, Region: region)
		domUsing.Add(_namespace)
		_result.Add(domUsing)
		
	override def OnImport(node as Import):
		region = BodyRegionOf(node)
		domUsing = MD.DomUsing(Region: region)
		domUsing.Add(node.Namespace)
		_result.Add(domUsing)
		
	override def OnClassDefinition(node as ClassDefinition):
		OnTypeDefinition(node, MD.ClassType.Class)
		
	override def OnInterfaceDefinition(node as InterfaceDefinition):
		OnTypeDefinition(node, MD.ClassType.Interface)
		
	override def OnStructDefinition(node as StructDefinition):
		OnTypeDefinition(node, MD.ClassType.Struct)
		
	override def OnEnumDefinition(node as EnumDefinition):
		OnTypeDefinition(node, MD.ClassType.Enum)
		
	def OnTypeDefinition(node as TypeDefinition, classType as MD.ClassType):
		converted = MD.DomType(
						Name: node.Name,
						ClassType: classType,
						Location: LocationOf(node),
						BodyRegion: BodyRegionOf(node),
						DeclaringType: _currentType,
						Modifiers: ModifiersFrom(node))
		
		WithCurrentType converted:
			Visit(node.Members)
					
		AddType(converted)
		
	override def OnCallableDefinition(node as CallableDefinition):
		parameters = System.Collections.Generic.List[of MD.IParameter]()
		for p in node.Parameters: parameters.Add(ParameterFrom(null, p))
		
		converted = MD.DomType.CreateDelegate(_result, node.Name, LocationOf(node), ReturnTypeFrom(node.ReturnType), parameters)
		converted.Modifiers = ModifiersFrom(node)
		converted.DeclaringType = _currentType
		converted.BodyRegion = BodyRegionOf(node)
		
		for p in parameters: p.DeclaringMember = converted
		
		AddType(converted)
		
	override def OnField(node as Field):
		if _currentType is null: return
		
		_currentType.Add(MD.DomField(
							Name: node.Name,
							ReturnType: ParameterTypeFrom(node.Type),
							Location: LocationOf(node),
							BodyRegion: BodyRegionOf(node),
							DeclaringType: _currentType,
							Modifiers: ModifiersFrom(node)))
							
	override def OnProperty(node as Property):
		if _currentType is null: return
		
		converted = MD.DomProperty(
							Name: node.Name,
							ReturnType: ParameterTypeFrom(node.Type),
							Location: LocationOf(node),
							BodyRegion: BodyRegionOf(node),
							DeclaringType: _currentType,
							Modifiers: ModifiersFrom(node))
		if node.Getter is not null:
			converted.PropertyModifier |= MD.PropertyModifier.HasGet
			converted.GetRegion = BodyRegionOf(node.Getter)
		if node.Setter is not null:
			converted.PropertyModifier |= MD.PropertyModifier.HasSet
			converted.SetRegion = BodyRegionOf(node.Setter)
							
		_currentType.Add(converted)
							
	override def OnEnumMember(node as EnumMember):
		if _currentType is null: return
		
		_currentType.Add(MD.DomField(
							Name: node.Name,
							ReturnType: MD.DomReturnType(_currentType),
							Location: LocationOf(node),
							DeclaringType: _currentType,
							Modifiers: MD.Modifiers.Public | MD.Modifiers.Static | MD.Modifiers.Final))
							
	override def OnConstructor(node as Constructor):
		OnMethod(node, MD.MethodModifier.IsConstructor)
		
	override def OnDestructor(node as Destructor):
		OnMethod(node, MD.MethodModifier.IsFinalizer)
		
	override def OnMethod(node as Method):
		OnMethod(node, MD.MethodModifier.None)
		
	def OnMethod(node as Method, methodModifier as MD.MethodModifier):
		if _currentType is null: return
		
		converted = MD.DomMethod(
							Name: node.Name,
							Location: LocationOf(node),
							BodyRegion: BodyRegionOf(node),
							DeclaringType: _currentType,
							ReturnType: (MethodReturnTypeFrom(node) if IsRegularMethod(methodModifier) else null),
							Modifiers: ModifiersFrom(node),
							MethodModifier: methodModifier)
							
		for parameter in node.Parameters:
			converted.Add(ParameterFrom(converted, parameter))
		
		_currentType.Add(converted)
		
	def IsRegularMethod(modifier as MD.MethodModifier):
		match modifier:
			case MD.MethodModifier.IsConstructor | MD.MethodModifier.IsFinalizer:
				return false
			otherwise:
				return true
		
	def ModifiersFrom(node as TypeMember):
		modifiers = MD.Modifiers.None
		modifiers |= MD.Modifiers.Public if node.IsPublic
		modifiers |= MD.Modifiers.Private if node.IsPrivate
		modifiers |= MD.Modifiers.Protected if node.IsProtected
		modifiers |= MD.Modifiers.Internal if node.IsInternal
		modifiers |= MD.Modifiers.Static if node.IsStatic
		modifiers |= MD.Modifiers.Virtual if node.IsVirtual
		modifiers |= MD.Modifiers.Abstract if node.IsAbstract
		modifiers |= MD.Modifiers.Override if node.IsOverride
		modifiers |= MD.Modifiers.Final if node.IsFinal
		return modifiers
		
	def ParameterFrom(declaringMember as MD.IMember, parameter as ParameterDeclaration):
		return MD.DomParameter(
					DeclaringMember: declaringMember, 
					Name: parameter.Name,
					ReturnType: ParameterTypeFrom(parameter.Type),
					Location: LocationOf(parameter))
					
	virtual def MethodReturnTypeFrom(method as Method):
		if method.ReturnType is not null:
			return ReturnTypeFrom(method.ReturnType)
		
		match ReturnTypeDetector().Detect(method):
			case ReturnTypeDetector.Result.Yields:
				return MD.DomReturnType("System.Collections.IEnumerator")
			case ReturnTypeDetector.Result.Returns:
				return DefaultReturnType()
			otherwise:
				return MD.DomReturnType("void")
		
	class ReturnTypeDetector(DepthFirstVisitor):
		enum Result:
			Returns
			Yields
			None
			
		_result = Result.None
			
		def Detect(node as Method):
			VisitAllowingCancellation(node)
			return _result
			
		override def OnBlockExpression(node as BlockExpression):
			pass // skip over closures
		
		override def OnReturnStatement(node as ReturnStatement):
			if node.Expression is null: return
			_result = Result.Returns
			Cancel()
			
		override def OnYieldStatement(node as YieldStatement):
			_result = Result.Yields
			Cancel()
	
	virtual def ParameterTypeFrom(typeRef as TypeReference):
		if typeRef is null: return DefaultReturnType()
		return ReturnTypeFrom(typeRef)
		
	virtual def ReturnTypeFrom(typeRef as TypeReference) as MD.DomReturnType:
		match typeRef:
			case SimpleTypeReference(Name: name):
				return MD.DomReturnType(name)
			case ArrayTypeReference(ElementType: elementType):
				type = ReturnTypeFrom(elementType)
				type.ArrayDimensions = 1
				type.SetDimension(0, 1)
				return type
			otherwise:
				return MD.DomReturnType("void")
		
	def AddType(type as MD.DomType):
		if _currentType is not null:
			_currentType.Add(type)
		else:
			type.Namespace = _namespace
			_result.Add(type)
		
	def WithCurrentType(type as MD.DomType, block as callable()):
		saved = _currentType
		_currentType = type
		try:
			block()
		ensure:
			_currentType = saved
			
	def BodyRegionOf(node as Node):
		return MD.DomRegion(DomLocationFrom(node.LexicalInfo), DomLocationFrom(node.EndSourceLocation))
		
	def LocationOf(node as Node):
		location = node.LexicalInfo
		return DomLocationFrom(location)
		
	def DomLocationFrom(location as SourceLocation):
		return MD.DomLocation(location.Line, location.Column)
		
	def DefaultReturnType():
		return MD.DomReturnType("Object")