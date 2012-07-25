options
{
language = "Boo";
namespace = "UnityScript.Parser";
}

{
import System.Text
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import System.Globalization

import UnityScript
import UnityScript.Core
}

class UnityScriptParser extends Parser;
options
{
	k = 2;
	exportVocab = UnityScript; 
	defaultErrorHandler = true;
    classHeaderPrefix = "partial";
}
tokens
{
	AS="as";
	BREAK="break";
	CAST="cast";
	CATCH="catch";
	CLASS="class";
	CONTINUE="continue";
	DO="do";
	ELSE="else";
	EACH="each";
	ENUM="enum";
	EXTENDS="extends";
	FALSE="false";
	FINAL="final";
	FINALLY="finally";
	FOR="for";
	FUNCTION="function";
	GET="get";
	IF="if";
	IMPORT="import";
	IMPLEMENTS="implements";
	IN="in";
	INTERFACE="interface";
	INSTANCEOF="instanceof";
	NEW="new";
	NOT="not";
	NULL="null";
	RETURN="return";
	PUBLIC="public";
	PROTECTED="protected";
	INTERNAL="internal";
	OVERRIDE="override";
	PARTIAL="partial";
	PRIVATE="private";
	SET="set";
	STATIC="static";
	SUPER="super";
	THIS="this";
	THROW="throw";
	TRUE="true";
	TRY="try";
	TYPEOF="typeof";
	VAR="var";
	VIRTUAL="virtual";
	WHILE="while";
	YIELD="yield";	
	
	SWITCH="switch";
	CASE="case";
	DEFAULT="default";
	
	/* virtual tokens */
	INPLACE_DIVISION="/=";
	INPLACE_ADD="+=";
	INPLACE_SUBTRACT="-=";
	INPLACE_MULTIPLY="*=";
	SL_COMMENT="//";
	
	PRAGMA_ON="pragma on";
	PRAGMA_OFF="pragma off";
	
	/* lexer token definitions */
	ID="an identifier";
	DOUBLE_QUOTED_STRING="a string";
	LBRACE="{";
	RBRACE="}";
	LPAREN="(";
	RPAREN=")";	
	DOT=".";
	COLON=":";
	COMMA=",";
	LBRACK="[";
	RBRACK="]";
	BITWISE_OR="|";
	INPLACE_BITWISE_OR="|=";
	BITWISE_AND="&";
	BITWISE_XOR="^";
	INPLACE_BITWISE_AND="&=";
	LOGICAL_OR="||";
	LOGICAL_AND="&&";
	EOS=";";
	ASSIGN="=";
	INCREMENT="++";
	DECREMENT="--";
	ADD="+";
	SUBTRACT="-";
	MODULUS="%";
	MULTIPLY="*";
	EQUALITY="==";
	INEQUALITY="!=";
	QUESTION_MARK="?";
	BITWISE_NOT="~";
	REFERENCE_EQUALITY="===";
	REFERENCE_INEQUALITY="!==";
	LESS_THAN="<";
	LESS_THAN_OR_EQUAL="<=";
	SHIFT_LEFT="<<";
	INPLACE_SHIFT_LEFT="<<=";
	GREATER_THAN=">";
	GREATER_THAN_OR_EQUAL=">=";
	SHIFT_RIGHT=">>";
	INPLACE_SHIFT_RIGHT=">>=";
	AT="@";
	SCRIPT_ATTRIBUTE_MARKER="@script";
	ASSEMBLY_ATTRIBUTE_MARKER="@assembly";
}
{
	[property(CompilerContext)]
	_context as CompilerContext
	
	_attributes = AttributeCollection()
	
	_last as antlr.IToken
	
	_loopStack = []
	
	def MacroName(baseName as string):
		return "UnityScript.Macros.${baseName[:1].ToUpper()}${baseName[1:]}"
	
	def EnterLoop([required] stmt):
		_loopStack.Push(stmt)
		
	def LeaveLoop([required] stmt):
		top = _loopStack.Pop()
		assert stmt is top
		
	def SetUpLoopLabel(node as Node):
		label = _context.GetUniqueName("for")
		node["UpdateLabel"] = label
		return label
		
	def GetCurrentLoopLabel() as string:
		return null if 0 == len(_loopStack)
		top as Node = _loopStack[-1]
		label = top["UpdateLabel"]
		if label is not null:
			top.Annotate("LabelInUse") if not top.ContainsAnnotation("LabelInUse")
		return label
		
	def IsLabelInUse(node as Node):
		return node.ContainsAnnotation("LabelInUse")
	
	def FlushAttributes(node as INodeWithAttributes):
		node.Attributes.AddRange(_attributes)
		_attributes.Clear()
		
	def GlobalVariablesBecomeFields():
		return UnityScriptParameters.GlobalVariablesBecomeFields
		
	UnityScriptParameters as UnityScriptCompilerParameters:
		get: return _context.Parameters
	
	static def SetEndSourceLocation(node as Node, token as antlr.IToken):
		node.EndSourceLocation = ToSourceLocation(token)
	
	static def ToSourceLocation(token as antlr.IToken):
		text = token.getText()
		tokenLength = (0 if text is null else len(text)-1)
		return SourceLocation(token.getLine(), token.getColumn()+tokenLength)
			
	static def ToLexicalInfo(token as antlr.IToken):
		return LexicalInfo(token.getFilename(), token.getLine(), token.getColumn())
	
	static def ParseIntegerLiteralExpression(token as antlr.IToken,
							s as string,
							isLong as bool):
		HEX_PREFIX = "0x"
		if (s.StartsWith(HEX_PREFIX)):
			value = long.Parse(
				s.Substring(HEX_PREFIX.Length), NumberStyles.AllowHexSpecifier, CultureInfo.InvariantCulture)
		else:
			value = long.Parse(s, CultureInfo.InvariantCulture)
		return IntegerLiteralExpression(ToLexicalInfo(token), value, isLong)
	
	override public def reportError(x as antlr.RecognitionException):
		data = LexicalInfo(x.getFilename(), x.getLine(), x.getColumn())
		nvae = x as antlr.NoViableAltException
		if nvae is not null:
			ReportError(CompilerErrorFactory.UnexpectedToken(data, x, nvae.token.getText()))
		else:
			ReportError(CompilerErrorFactory.GenericParserError(data, x))
			
	override public def consume():
		_last = LT(1)
		super()
			
	protected def ReportError(error as CompilerError):
		_context.Errors.Add(error)
		
	protected def VirtualKeywordHasNoEffect(token as antlr.IToken):
		_context.Warnings.Add(UnityScriptWarnings.VirtualKeywordHasNoEffect(ToLexicalInfo(token)))
		
	protected def UnexpectedToken(token as antlr.IToken):
		ReportError(CompilerErrorFactory.UnexpectedToken(ToLexicalInfo(token), null, token.getText()))
		
	protected def KeywordCannotBeUsedAsAnIdentifier(token as antlr.IToken):
		ReportError(UnityScriptCompilerErrors.KeywordCannotBeUsedAsAnIdentifier(ToLexicalInfo(token), token.getText()))
		
	protected def SemicolonExpected():
		if _last is not null:
			li = LexicalInfo(
					_last.getFilename(),
					_last.getLine(),
					_last.getColumn()+len(_last.getText()))
		else:
			li = ToLexicalInfo(LT(1))
		ReportError(UnityScriptCompilerErrors.SemicolonExpected(li))		
	
	static def CreateModuleName(fname as string):
		return System.IO.Path.GetFileNameWithoutExtension(fname)
		
	static def IsConstructorName(name as string, type as TypeDefinition):
		return type.NodeType != NodeType.Module and name == type.Name
		
	def AddFunctionTo(type as TypeDefinition, nameToken as IToken, getter as IToken, setter as IToken):
		
		name = nameToken.getText()
		location = ToLexicalInfo(nameToken)
			
		function as Method = (Constructor(location) if IsConstructorName(name, type) else Method(location, Name: name))
		if getter is not null or setter is not null:
			p = type.Members[name] as Property
			if p is null:
				p = Property(location, Name: name)
				type.Members.Add(p)
			if getter is not null:
				assert p.Getter is null
				p.Getter = function
			else:
				assert p.Setter is null
				p.Setter = function
			FlushAttributes(p)
		else:
			type.Members.Add(function)
			FlushAttributes(function)
		return function
	
	def ValidateFunctionDeclaration(function as Method, getter as IToken, setter as IToken):
		// TODO: move this error checking to a compiler step
		// as well as properly checking the type of the accessors
		// against the type of the property
		if setter is not null:
			if function.Parameters.Count != 1 or function.Parameters[0].Name != "value":
				ReportError(UnityScriptCompilerErrors.InvalidPropertySetter(function.LexicalInfo))
			function.Parameters.Clear()
			return
		if getter is not null:
			if function.Parameters.Count > 0:
				ReportError(UnityScriptCompilerErrors.InvalidPropertySetter(function.LexicalInfo))
}

start[CompileUnit cu]
{
	module = Module(LexicalInfo(getFilename(), 1, 1))
	module.Name = CreateModuleName(getFilename())
	cu.Modules.Add(module)
	globals = module.Globals
}:
	(
		import_directive[module]
		| pragma_directive[module]
		| (AT ID ID)=> script_or_assembly_attribute[module]
	)*
	(
		(AT ID ID)=> script_or_assembly_attribute[module]
		|
		(
			attributes
			module_member[module]
		)
		| module_member[module]
		| statement[globals]
	)*
	eof:EOF
	{
		SetEndSourceLocation(module, eof)
	}
;

attribute_parameter[Ast.Attribute attr]
{
}:
	(ID ASSIGN)=>(
		name=reference_expression ASSIGN value=expression
		{
			attr.NamedArguments.Add(ExpressionPair(name, value))
		}
	) |
	(
		value=expression
		{
			attr.Arguments.Add(value)
		}
	)
;

attributes
{
	_attributes.Clear()
}:
	(attribute)+
;

attribute
{
}:
	AT attr=attribute_constructor	
	{
		_attributes.Add(attr)
	}
;

attribute_constructor returns [Boo.Lang.Compiler.Ast.Attribute attr]
{
}:
	name=qname
	{
		attr = Ast.Attribute(ToLexicalInfo(name), name.getText())
	}
	(
		LPAREN
		(
			attribute_parameter[attr]
			(options { greedy=true; }:
				COMMA
				attribute_parameter[attr]
			)*
		)?
		RPAREN
	)?
;

module_member[Module module]
{
	globals = module.Globals
}:

	{GlobalVariablesBecomeFields()}? (module_member_modifiers VAR) => module_field[module]
	| (declaration_statement[globals] eos)
	|
	(
		mod=module_member_modifiers
		(
			mm=class_declaration[module]
			| mm=interface_declaration[module]
			| mm=enum_declaration[module]
			| mm=function_member[module]
		)
		{ mm.Modifiers |= mod if mm is not null }
	)
;

script_or_assembly_attribute[Module m]
{
}:
	AT attributeKindToken:ID attr=attribute_constructor
	{
		attributeKind = attributeKindToken.getText()
		if attributeKind == "assembly":
			m.AssemblyAttributes.Add(attr)
		elif attributeKind == "script":
			m.Attributes.Add(attr)
		else:
			UnexpectedToken(attributeKindToken)
	}
;

module_field[Module m]
{
}:
	mod=module_member_modifiers
	f=field_member[m]
	{ f.Modifiers |= mod }
;

qname returns [Token id]
{
}:
	start:ID
	{
		id = start		
		
		buffer = StringBuilder()
		buffer.Append(start.getText())
	}
	(
		DOT other:ID
		{
			buffer.Append(".")
			buffer.Append(other.getText())
		}
	)*
	{
		id.setText(buffer.ToString())
	}
;

pragma_directive[Module container]
{
}:
	(on:PRAGMA_ON { id=on } | off:PRAGMA_OFF { id=off })
	{
		pragma = id.getText()
		if Pragmas.IsValid(pragma):
			if on is not null:
				Pragmas.TryToEnableOn(container, pragma)
			else:
				Pragmas.DisableOn(container, pragma)
		else:
			ReportError(UnityScriptCompilerErrors.UnknownPragma(ToLexicalInfo(id), pragma))
	}
;

import_directive[Module container]
{
}: 
	imp:IMPORT ns=qname	eos
	{
		container.Imports.Add(
			Import(ToLexicalInfo(imp), ReferenceExpression(ToLexicalInfo(ns), ns.getText())))
	}
;

eos returns [antlr.IToken firstEOS]:
	(
		(options { greedy = true; }:
			t:EOS { if firstEOS is null: firstEOS = t }
		)+
		| { SemicolonExpected() }
	)
;

module_member_modifiers returns [TypeMemberModifiers m]
{
	m = TypeMemberModifiers.None
}:
	(		
		FINAL { m |= TypeMemberModifiers.Final }
		| PUBLIC { m |= TypeMemberModifiers.Public }
		| PRIVATE { m |= TypeMemberModifiers.Private }
		| PROTECTED { m |= TypeMemberModifiers.Protected }
		| INTERNAL { m |= TypeMemberModifiers.Internal }
		| STATIC { m |= TypeMemberModifiers.Static }
		| v:VIRTUAL { VirtualKeywordHasNoEffect(v) }
	)*
;

member_modifiers returns [TypeMemberModifiers m]
{
	m = TypeMemberModifiers.None
}:
	(		
		FINAL { m |= TypeMemberModifiers.Final }
		| OVERRIDE { m |= TypeMemberModifiers.Override }
		| PUBLIC { m |= TypeMemberModifiers.Public }
		| PRIVATE { m |= TypeMemberModifiers.Private }
		| PROTECTED { m |= TypeMemberModifiers.Protected }
		| INTERNAL { m |= TypeMemberModifiers.Internal }
		| STATIC { m |= TypeMemberModifiers.Static }
		| NEW { m |= TypeMemberModifiers.New }
		| v:VIRTUAL { VirtualKeywordHasNoEffect(v) }
	)*
;

class_declaration[TypeDefinition parent] returns [TypeMember member]
{
}:
	(p:PARTIAL)? CLASS name:ID (EXTENDS baseType=type_reference)?
	{
		member = cd = ClassDefinition(ToLexicalInfo(name), Name: name.getText())
		baseTypes = cd.BaseTypes
		
		if baseType is not null:
			baseTypes.Add(baseType)
			
		cd.Modifiers |= TypeMemberModifiers.Partial if p is not null
		FlushAttributes(cd)
		parent.Members.Add(cd)
	}
	(IMPLEMENTS type_reference_list[baseTypes])?
	
	{
		for typeRef in baseTypes:
			if typeRef is baseType:
				BaseTypeAnnotations.AnnotateExtends(typeRef)
			else:
				BaseTypeAnnotations.AnnotateImplements(typeRef)
	}
	
	LBRACE
	(
		{ mod = TypeMemberModifiers.None }
		(attributes)?
		(mod=member_modifiers)?
		(
			m=function_member[cd]
			| m=field_member[cd]
			| m=enum_declaration[cd]
			| m=class_declaration[cd]
			| m=interface_declaration[cd]
		)
		{ m.Modifiers |= mod if m is not null }
	)*
	rbrace:RBRACE { SetEndSourceLocation(cd, rbrace) }
	(EOS)*
;

interface_declaration[TypeDefinition parent] returns [TypeMember member]
{
}:
	INTERFACE name:ID
	{
		member = td = InterfaceDefinition(ToLexicalInfo(name), Name: name.getText())
		baseTypes = td.BaseTypes
		FlushAttributes(td)
		parent.Members.Add(td)
	}
	(EXTENDS type_reference_list[baseTypes])?
	LBRACE
	(
		(attributes)?
		interface_member[td]
	)*
	rbrace:RBRACE { SetEndSourceLocation(td, rbrace) }
	(EOS)*
;

interface_member[TypeDefinition parent]
{
}:
	FUNCTION (getter:GET | setter:SET)? memberName=identifier 
	{
		function = AddFunctionTo(parent, memberName, getter, setter) 
	}
	LPAREN (parameter_declaration_list[function])? RPAREN
	{ ValidateFunctionDeclaration(function, getter, setter) }
	(
		COLON tr=type_reference	{ function.ReturnType = tr; }
	)?
	(EOS)*
;

enum_declaration [TypeDefinition container] returns [TypeMember member]
{
}:
	ENUM name:ID
	{
		member = ed = EnumDefinition(ToLexicalInfo(name), Name: name.getText())
		FlushAttributes(member);
		container.Members.Add(ed)
	}
	LBRACE
	(
		enum_member[ed]
		(
			COMMA
			enum_member[ed]
		)*
		(COMMA)?
	)?
	rbrace:RBRACE { SetEndSourceLocation(ed, rbrace) }
	(EOS)*
;
	
enum_member [EnumDefinition container]
{			
}: 
	(attributes)?
	name=identifier (ASSIGN initializer=integer_literal)?
	{
		em = EnumMember(ToLexicalInfo(name), Name: name.getText(), Initializer: initializer)
		FlushAttributes(em)
		container.Members.Add(em)
	}	
;

identifier returns [antlr.IToken token]
{
}:
	name:ID { token = name; }
	| f:FINAL { token = f; KeywordCannotBeUsedAsAnIdentifier(token); }
	| i:INTERNAL { token = i; KeywordCannotBeUsedAsAnIdentifier(token); }
	| e:EACH { token = e; }
;

field_member[TypeDefinition cd] returns [TypeMember member]
{
}:
	VAR name=identifier (COLON tr=type_reference)? (ASSIGN initializer=expression)? finalToken=eos
	{
		member = Field(ToLexicalInfo(name),
				Name: name.getText(),
				Type: tr,
				Initializer: initializer)
		if finalToken is not null: SetEndSourceLocation(member, finalToken)
		FlushAttributes(member)
		cd.Members.Add(member)
	}
;

function_member[TypeDefinition cd] returns [TypeMember member]
{
}:
	FUNCTION (getter:GET | setter:SET)? memberName=identifier 
	{ member = function = AddFunctionTo(cd, memberName, getter, setter) }	
	function_body[function]
	{ ValidateFunctionDeclaration(function, getter, setter) }
;

function_body[Method method]
{
}:
	LPAREN (parameter_declaration_list[method])? RPAREN
	(
		COLON tr=type_reference	{ method.ReturnType = tr; }
	)?
	compound_statement[method.Body]
	{ method.EndSourceLocation = method.Body.EndSourceLocation }
;

parameter_declaration_list[INodeWithParameters m]
{
}:
	parameter_declaration[m]
	(
		COMMA
		parameter_declaration[m]
	)*
;

parameter_declaration[INodeWithParameters m]
{
}:
	(attributes)? id=identifier (COLON tr=type_reference)?
	{
		parameter = ParameterDeclaration(ToLexicalInfo(id), Name: id.getText(), Type: tr)
		m.Parameters.Add(parameter)
		FlushAttributes(parameter)
	}
;

compound_or_single_stmt[Block b]
{
}:
	compound_statement[b] |
	statement[b]
;

compound_statement[Block b]
{
}:
	block[b]
	(EOS)*
;

block[Block b]
{
}:
	LBRACE
	(statement[b])*
	rbrace:RBRACE { SetEndSourceLocation(b, rbrace) }
;

statement[Block b]
{
}:
	(macro_application_test) => macro_application_block[b]
	| builtin_statement[b]
	| (EOS)+
;

builtin_statement[Block b]
{
}:
	(
		do_while_statement[b] |
		while_statement[b] |
		for_statement[b] |
		if_statement[b] |
		try_statement[b] |
		switch_statement[b]
	) |
	(
		(
			expression_statement[b] |
			yield_statement[b] |
			return_statement[b] |
			break_statement[b] |
			continue_statement[b] |
			throw_statement[b] |
			declaration_statement[b]
		)
		eos
	)
;

declaration_statement[Block b]
{
}:
	d=declaration (ASSIGN i=expression)?
	{
		stmt = DeclarationStatement(d.LexicalInfo, Declaration: d, Initializer: i)
		b.Add(stmt)
	}
;

yield_statement[Block b]
{
}:
	yt:YIELD (e=expression)?
	{ b.Add(YieldStatement(ToLexicalInfo(yt), Expression: e)) }
;

return_statement[Block b]
{
}:
	ret:RETURN (e=expression)?
	{ b.Add(ReturnStatement(ToLexicalInfo(ret), Expression: e)) }
;

break_statement[Block b]
{
}:
	t:BREAK
	{ b.Add(BreakStatement(ToLexicalInfo(t))) }
;

continue_statement[Block b]
{
}:
	t:CONTINUE
	{
		gotoLabel = GetCurrentLoopLabel()
		if gotoLabel is not null:
			// we might be inside a c style for statement
			b.Add(GotoStatement(ToLexicalInfo(t), Label: ReferenceExpression(gotoLabel)))
		else:
			b.Add(ContinueStatement(ToLexicalInfo(t)))
	}
;


throw_statement[Block b]
{
}:
	t:THROW (e=expression)?
	{ b.Add(RaiseStatement(ToLexicalInfo(t), Exception: e)) }
;


expression_statement[Block b]
{
}:
	e=assignment_expression
	{ b.Add(ExpressionStatement(e)) }
;

for_statement [Block container]
{
}:
	f:FOR
	(
		(EACH LPAREN stmt=for_in[container])
		|
		(
			LPAREN
			(
				((identifier | declaration) IN) => stmt=for_in[container]
				| stmt=for_c[container]
			)
		)
	)
	{ stmt.LexicalInfo = ToLexicalInfo(f) if stmt is not null }
;

for_c [Block container] returns [Statement stmt]
{
}:
	(
		declaration_statement[container]
		{
			stmt = container.Statements[-1] as DeclarationStatement
			stmt.Annotate("PrivateScope") if stmt is not null				
		}
		| expression_statement[container]
	)?
	EOS
	(condition=expression)?
	EOS
	(update=assignment_expression)?
	{
		ws = WhileStatement(Condition: condition)
		if condition is null:
			ws.Condition = BoolLiteralExpression(Value: true)
			
		b = ws.Block
		stmt = ws
		
		// support for 'continue'
		label = SetUpLoopLabel(ws)
		
		container.Add(stmt)
		EnterLoop(ws)
	}
	RPAREN
	compound_or_single_stmt[b]
	{
		LeaveLoop(ws)
		if IsLabelInUse(ws):
			b.Add(LabelStatement(Name: label))
		b.Add(update) if update is not null
	}
;

for_in [Block container] returns [Statement stmt]
{
}:
	(
		(id=identifier { d = Declaration(ToLexicalInfo(id), Name: id.getText()) })
		| d=declaration { DeclarationAnnotations.ForceNewVariable(d) }
	)
	IN iterator=expression
	{
		fs = ForStatement(Iterator: iterator)
		fs.Declarations.Add(d)
		b = fs.Block
		stmt = fs
		
		container.Add(stmt)
		EnterLoop(stmt)
	}
	RPAREN
	compound_or_single_stmt[b]
	{
		LeaveLoop(stmt)
	}
;

declaration returns [Declaration d]
{
}:
	VAR id=identifier (COLON tr=type_reference)?
	{
		d = Declaration(ToLexicalInfo(id), Name: id.getText(), Type: tr)
	}
;

macro_application_test
{
}:
	(member LBRACE)
	| (member expression_list[null] LBRACE)
;
		
macro_application_block[Block container]
{
	m = MacroStatement()
	args = m.Arguments
	b = m.Body
}:
	macroName=member
	(
		(LBRACE) => compound_statement[b]
		| (expression_list[args] compound_statement[b])
	)
	{
		m.LexicalInfo = ToLexicalInfo(macroName)
		m.Name = macroName.getText()
		container.Add(m)
	}
;
		
while_statement[Block container]
{
}:
	w:WHILE e=paren_expression
	{
		ws = WhileStatement(ToLexicalInfo(w), Condition: e)
		b = ws.Block
		container.Add(ws)
		EnterLoop(ws)
	}
	compound_or_single_stmt[b]
	{
		LeaveLoop(ws)
	}
;

do_while_statement[Block container]
{
}:
	d:DO
	{
		ws = WhileStatement(ToLexicalInfo(d), Condition: BoolLiteralExpression(true))
		b = ws.Block
		container.Add(ws)
		EnterLoop(ws)
	}
	block[b]
	w:WHILE e=paren_expression eos
	{
		b.Add(BreakStatement(ToLexicalInfo(w), Modifier: StatementModifier(StatementModifierType.Unless, e)))
		LeaveLoop(ws)
	}
;

switch_statement[Block container]
{
}:
	s:SWITCH e=paren_expression
	{
		switchMacro = MacroStatement(ToLexicalInfo(s), Name: MacroName(s.getText()))
		switchMacro.Arguments.Add(e)
		switchBlock = switchMacro.Body
		container.Add(switchMacro)
	}
	LBRACE
	(
		c:CASE e=expression COLON
		{
			item = MacroStatement(ToLexicalInfo(c), Name: c.getText())
			item.Arguments.Add(e)
			itemBlock = item.Body
			switchBlock.Add(item)
		}
		(
			fallthrough:CASE e=expression COLON
			{ item.Arguments.Add(e); }
		)*
		
		(statement[itemBlock])+
	)*
	(
		d:DEFAULT COLON
		{
			item = MacroStatement(ToLexicalInfo(d), Name: d.getText())
			itemBlock = item.Body
			switchBlock.Add(item)
		}
		(statement[itemBlock])+
	)?
	RBRACE
	(EOS)*
;

try_statement[Block container]
{
}:
	tt:TRY
	{
		s = TryStatement(ToLexicalInfo(tt))
		b = s.ProtectedBlock
		container.Add(s)
	}
	compound_or_single_stmt[b]
	(
		ct:CATCH LPAREN id:ID (COLON tr=type_reference)? RPAREN
		{
			tr = SimpleTypeReference(ToLexicalInfo(id), "System.Exception") if tr is null
			handler = ExceptionHandler(
						ToLexicalInfo(ct),
						Declaration: Declaration(ToLexicalInfo(id), Name: id.getText(), Type: tr))
			s.ExceptionHandlers.Add(handler)
			b = handler.Block
			tr = null
		}
		compound_or_single_stmt[b]
	)*
	(
		finally_block[s]
	)?
;

finally_block[TryStatement s]
{
}:
	ft:FINALLY
	{
		finallyBlock = s.EnsureBlock = Block(ToLexicalInfo(ft))
	}
	compound_or_single_stmt[finallyBlock]
;

if_statement[Block container]
{
}:
	it:IF e=paren_expression
	{
		s = IfStatement(ToLexicalInfo(it), Condition: e)
		b = s.TrueBlock = Block()
		container.Add(s)
	}
	compound_or_single_stmt[b]
	(
		et:ELSE { b = s.FalseBlock = Block(ToLexicalInfo(et)) }
		compound_or_single_stmt[b]
	)?
;

expression returns [Expression e]
{
}:
	e=conditional_expression
;

member returns [Token name]
{
}:
	id:ID { name=id; } |
	st:SET { name=st; } |
	gt:GET { name=gt; }	|
	eh:EACH { name=eh; }
;

type_reference returns [TypeReference tr]
{
	rank = 1
}: 
	(
		(tr=simple_type_reference | tr=anonymous_function_type)
		(
			lbrack:LBRACK
			(COMMA { ++rank })*
			RBRACK
			{
				tr = ArrayTypeReference(tr.LexicalInfo, tr, IntegerLiteralExpression(ToLexicalInfo(lbrack), rank))
			}
		)?
	)
;

anonymous_function_type returns [TypeReference tr]
{
}:
	fn:FUNCTION
	{
		tr = callableTypeRef = CallableTypeReference(ToLexicalInfo(fn))
		parameters = callableTypeRef.Parameters
	}
	function_type_parameters[parameters]
	(
		COLON
		returnType=type_reference { callableTypeRef.ReturnType = returnType }
	)?
;

function_type_parameters[ParameterDeclarationCollection parameters]
{
}:
	LPAREN
	(
		parameterType=type_reference { parameters.Add(ParameterDeclaration(Type: parameterType, Name: "arg" + len(parameters))) }
		(
			COMMA parameterType=type_reference
			{ parameters.Add(ParameterDeclaration(Type: parameterType, Name: "arg" + len(parameters))) }
		)*
	)?
	RPAREN
;

array_initializer returns [Expression e]
{
	dimensions = List of Expression(1)
}:
	tr=simple_type_reference
	LBRACK
	size=sum { dimensions.Add(size) }
	(COMMA size=sum { dimensions.Add(size) })*
	RBRACK
	{
		e = CodeFactory.NewArrayInitializer(tr.LexicalInfo, tr, dimensions)
	}
;

simple_type_reference returns [TypeReference tr]
{
}:
	typeName=qname
	(
		(
			DOT LESS_THAN 
			{
				tr = gtr = GenericTypeReference(ToLexicalInfo(typeName), typeName.getText());
				arguments = gtr.GenericArguments
			}
			type_reference_list[arguments]
			GREATER_THAN
		)
		|
		(
			{
				tr = SimpleTypeReference(ToLexicalInfo(typeName), Name: typeName.getText())
			}
		)
	)
	
;

type_reference_list[TypeReferenceCollection typeReferences]
{
}:
	tr=type_reference { typeReferences.Add(tr) }
	(
		COMMA tr=type_reference
		{ typeReferences.Add(tr) }
	)*
;

new_array_expression returns [Expression e]
{
}:
	NEW e=array_initializer
;

new_expression returns [Expression e]
{
}:
	(new_array_expression)=>e=new_array_expression
	| 
	(
		NEW r=reference_expression			
		{
			e = mie = MethodInvocationExpression(r.LexicalInfo, Target: r)
			args = mie.Arguments
		}
		LPAREN
			expression_list[args]
		RPAREN
	)
;

atom returns [Expression e]
{
}:	
	(
		e=literal |	
		e=function_expression |
		e=simple_reference_expression |
		e=paren_expression  |
		e=new_expression |
		e=typeof_expression
	)
;

function_expression returns [BlockExpression e]
{
}:
	fn:FUNCTION
	{
		e = BlockExpression(ToLexicalInfo(fn))
		e.Annotate("inline");
		body = e.Body
	}
	LPAREN (parameter_declaration_list[e])? RPAREN
	(
		COLON tr=type_reference	{ e.ReturnType = tr; }
	)?
	(block[body] | returnValue=expression { body.Add(returnValue) })
;

simple_reference_expression returns [Expression e]
{ 
}:
	(id:ID | each:EACH { id = each })
	{ e = ReferenceExpression(ToLexicalInfo(id), Name: id.getText()) }
;

reference_expression returns [Expression e]
{
}:
	e=simple_reference_expression
	(
		DOT e=member_reference_expression[e]
	)*
;

member_reference_expression[Expression target] returns [Expression e]
{
	e = target;
}:
	(
		lbrack:LESS_THAN
		{
			e = gre = GenericReferenceExpression(ToLexicalInfo(lbrack), Target: e)
			genericArguments = gre.GenericArguments
		}
		type_reference_list[genericArguments]
		GREATER_THAN
	)
	|
	(
		memberName=member
		{
			e = MemberReferenceExpression(ToLexicalInfo(memberName), Target: e, Name: memberName.getText())
		}
	)
;

paren_expression returns [Expression e]
{
}:
	LPAREN e=expression RPAREN
;

typeof_expression returns [Expression e]
{
}:
	(TYPEOF LPAREN expression RPAREN)=>e=typeof_with_expression
	| e=typeof_expression_alt // workaround antlr boo backend bug that only allows a single predicate per rule
;

protected
typeof_expression_alt returns [Expression e]
{
}:
	(TYPEOF LPAREN type_reference RPAREN)=>e=typeof_with_typeref
	| e=typeof_with_expression
;

protected
typeof_with_expression returns [Expression e]
{
}:
	t:TYPEOF	
	(
		(LPAREN arg=expression RPAREN)
		| arg=expression
	)
	{
		mie = MethodInvocationExpression(ToLexicalInfo(t));
		mie.Target = ReferenceExpression(ToLexicalInfo(t), Name: t.getText())
		mie.Arguments.Add(arg)
			
		e = mie
	}
;

protected
typeof_with_typeref returns [Expression e]
{
}:
	t:TYPEOF LPAREN tr=type_reference RPAREN
	{ e = TypeofExpression(ToLexicalInfo(t), tr); }
;

expression_list[ExpressionCollection ec]
{
}:
	(
		e=expression { ec.Add(e); }
		(
			COMMA
			e=expression { ec.Add(e); }
		)*
	)?
;
	
slice[SlicingExpression se]
{
	begin as Expression
	end as Expression
	step as Expression
}:
	(
		( 
			// [:
			COLON { begin = OmittedExpression.Default; }
			(
				// [:end]
				end=expression
				|
				(
					// [::step]
					COLON { end = OmittedExpression.Default; }
					step=expression
				)
				|
				// [:]
			)			
		) |
		// [begin
		begin=expression
		(
			// [begin:
			COLON
			(
				end=expression | { end = OmittedExpression.Default; } 
			)
			(
				COLON
				step=expression
			)?
		)?
	)
	{
	
		se.Indices.Add(Slice(begin, end, step))
	}
;

assignment_expression returns [Expression e]
{
}:
	e=conditional_expression
	(
		options { greedy = true; }:
		(
			a:ASSIGN { token = a; op = BinaryOperatorType.Assign } |
			ipa:INPLACE_ADD { token = ipa; op = BinaryOperatorType.InPlaceAddition } |
			ips:INPLACE_SUBTRACT { token = ips; op = BinaryOperatorType.InPlaceSubtraction } |
			ipm:INPLACE_MULTIPLY { token = ipm; op = BinaryOperatorType.InPlaceMultiply } |
			ipd:INPLACE_DIVISION { token = ipd; op = BinaryOperatorType.InPlaceDivision } |
			ipbo:INPLACE_BITWISE_OR { token = ipbo; op = BinaryOperatorType.InPlaceBitwiseOr } |
			ipba:INPLACE_BITWISE_AND { token = ipba; op = BinaryOperatorType.InPlaceBitwiseAnd } |
			ipxo:INPLACE_BITWISE_XOR { token = ipxo; op = BinaryOperatorType.InPlaceExclusiveOr } |
			ipsl:INPLACE_SHIFT_LEFT { token = ipsl; op = BinaryOperatorType.InPlaceShiftLeft } |
			ipsr:INPLACE_SHIFT_RIGHT { token = ipsr; op = BinaryOperatorType.InPlaceShiftRight } 
		)	
		r=assignment_expression
		{
			be = BinaryExpression(ToLexicalInfo(token))
			be.Operator = op
			be.Left = e
			be.Right = r
			e = be
		}
	)?
;

slicing_expression returns [Expression e]
{
	se as SlicingExpression
	mce as MethodInvocationExpression
	args as ExpressionCollection
}:
	e=atom
	( options { greedy=true; }:
		(
			lbrack:LBRACK
			{
				se = SlicingExpression(ToLexicalInfo(lbrack))				
				se.Target = e
				e = se
			}
			slice[se] (COMMA slice[se])*
			RBRACK
		)
		|
		(
			DOT e=member_reference_expression[e]
		)
		|
		(
			lparen:LPAREN
				{
					mce = MethodInvocationExpression(ToLexicalInfo(lparen))
					mce.Target = e
					e = mce
					args = mce.Arguments
				}			
			expression_list[args]
			RPAREN
		)
	)*
;


postfix_unary_expression returns [Expression e]
{
}:
	e=slicing_expression
	(
		postinc:INCREMENT { token = postinc; operator = UnaryOperatorType.PostIncrement; } |
		preinc:DECREMENT { token = preinc; operator= UnaryOperatorType.PostDecrement; }
	)?
	{ e = UnaryExpression(ToLexicalInfo(token), operator, e) if token is not null }
;

unary_expression returns [Expression e]
{
}: 
	(
		e=prefix_unary_expression
		| e=postfix_unary_expression
	)
	(
		tc:AS tr=type_reference { e = TryCastExpression(ToLexicalInfo(tc), Target: e, Type: tr) }
		| c:CAST tr=type_reference { e = CastExpression(ToLexicalInfo(c), Target: e, Type: tr) }
	)?
;

prefix_unary_expression returns [Expression e]
{
	uOperator = UnaryOperatorType.None
}: 
	(
		sub:SUBTRACT { op = sub; uOperator = UnaryOperatorType.UnaryNegation; } |
		inc:INCREMENT { op = inc; uOperator = UnaryOperatorType.Increment; } |
		dec:DECREMENT { op = dec; uOperator = UnaryOperatorType.Decrement; } |
		nt:LOGICAL_NOT { op = nt; uOperator = UnaryOperatorType.LogicalNot; } |
		oc:BITWISE_NOT { op = oc; uOperator = UnaryOperatorType.OnesComplement; }
	)
	e=unary_expression { e = UnaryExpression(ToLexicalInfo(op), uOperator, e) }
;


term returns [Expression e]
{
	op = BinaryOperatorType.None 
}:
	e=unary_expression
	( options { greedy = true; } :
	 	(
		 m:MULTIPLY { op=BinaryOperatorType.Multiply; token=m; } |
		 d:DIVISION { op=BinaryOperatorType.Division; token=d; } |
		 md:MODULUS { op=BinaryOperatorType.Modulus; token=md; }
		 )
		r=unary_expression
		{
			be = BinaryExpression(ToLexicalInfo(token))
			be.Operator = op
			be.Left = e
			be.Right = r
			e = be
		}
	)*
;

sum returns [Expression e]
{
	bOperator = BinaryOperatorType.None;
}:
	e=term
	( options { greedy = true; } :
		(
			add:ADD { op=add; bOperator = BinaryOperatorType.Addition; } |
			sub:SUBTRACT { op=sub; bOperator = BinaryOperatorType.Subtraction; }
		)
		r=term
		{
			be = BinaryExpression(ToLexicalInfo(op))
			be.Operator = bOperator
			be.Left = e
			be.Right = r
			e = be
		}
	)*
;

shift returns [Expression e]
{
}:
	e=sum
	( options { greedy = true;} :
		(
		sl:SHIFT_LEFT { op = BinaryOperatorType.ShiftLeft; token = sl } |
		sr:SHIFT_RIGHT { op = BinaryOperatorType.ShiftRight; token = sr }
		)
		r=sum
		{
			e = BinaryExpression(ToLexicalInfo(token), Operator: op, Left: e, Right: r)
		}
	)*
;

comparison returns [Expression e]
{		
	r as Expression
	op = BinaryOperatorType.None;
	token as IToken
}:
	e=shift
	( options { greedy = true; } :
	 (
	  (
		 (
		 	(tni:NOT IN { op = BinaryOperatorType.NotMember; token = tni; } ) |
		 	(tin:IN { op = BinaryOperatorType.Member; token = tin; } ) |
			(tgt:GREATER_THAN { op = BinaryOperatorType.GreaterThan; token = tgt; } ) |
			(tgte:GREATER_THAN_OR_EQUAL { op = BinaryOperatorType.GreaterThanOrEqual; token = tgte }) |
			(tlt:LESS_THAN { op = BinaryOperatorType.LessThan; token = tlt; }) |
			(tlte:LESS_THAN_OR_EQUAL { op = BinaryOperatorType.LessThanOrEqual; token = tlte; })
		 )
		 r=shift
	  ) |	
	  (
	  	tisa:INSTANCEOF
		tr=type_reference
		{
			op = BinaryOperatorType.TypeTest;
			token = tisa;
			r = TypeofExpression(tr.LexicalInfo, tr);
		}
	  )
	)
	{
		be = BinaryExpression(ToLexicalInfo(token))
		be.Operator = op
		be.Left = e
		be.Right = r
		e = be
	}
	)*
;

equality returns [Expression e]
{
}:
	e=comparison
	(options { greedy = true; }:
		(
			(te:EQUALITY { op = BinaryOperatorType.Equality; token = te; } ) |
			(ti:INEQUALITY { op = BinaryOperatorType.Inequality; token = ti }) |			
			(re:REFERENCE_EQUALITY { op = BinaryOperatorType.ReferenceEquality; token = re }) |
			(rie:REFERENCE_INEQUALITY { op = BinaryOperatorType.ReferenceInequality; token = rie })
		)
		r=comparison
		{ e = BinaryExpression(ToLexicalInfo(token), op, e, r) }
	)*
;


bitwise_and returns [Expression e]
{
}:
	e=equality
	(options { greedy = true; }:
		token:BITWISE_AND { op = BinaryOperatorType.BitwiseAnd; }
		r=equality
		{
			e = BinaryExpression(ToLexicalInfo(token), Operator: op, Left: e, Right: r)
		}
	)*
;

bitwise_xor returns [Expression e]
{
}:
	e=bitwise_and
	(options { greedy = true; }:
		token:BITWISE_XOR { op = BinaryOperatorType.ExclusiveOr; }
		r=bitwise_and
		{
			e = BinaryExpression(ToLexicalInfo(token), Operator: op, Left: e, Right: r)
		}
	)*
;


bitwise_or returns [Expression e]
{
}:
	e=bitwise_xor
	(options { greedy = true; }:
	
		token:BITWISE_OR { op = BinaryOperatorType.BitwiseOr; }
		
		r=bitwise_xor
		{
			e = BinaryExpression(ToLexicalInfo(token), Operator: op, Left: e, Right: r)
		}
	)*
;

logical_and returns [Expression e]
{
}:
	e=bitwise_or
	(
		op:LOGICAL_AND
		rhs=bitwise_or
		{
			e=BinaryExpression(ToLexicalInfo(op),
						Operator: BinaryOperatorType.And,
						Left: e,
						Right: rhs)
		}
	)*
;

logical_or returns [Expression e]
{
}:
	e=logical_and
	(
		op:LOGICAL_OR
		rhs=logical_and
		{
			e = BinaryExpression(ToLexicalInfo(op),
						Operator: BinaryOperatorType.Or,
						Left: e,
						Right: rhs)
		}
	)*
;

conditional_expression returns [Expression e]
{
}:
	e=logical_or
	(
		qm:QUESTION_MARK
		trueValue=logical_or 
		COLON
		falseValue=conditional_expression
		{
			e = ConditionalExpression(ToLexicalInfo(qm),
					Condition: e,
					TrueValue: trueValue,
					FalseValue: falseValue)
		}
	)?
;


	
literal returns [Expression e]
{
}:
	(
		e=integer_literal |
		e=string_literal |
		e=array_literal |
		e=hash_literal |
		e=re_literal |
		e=bool_literal |
		e=null_literal |
		e=self_literal |
		e=super_literal |
		e=double_literal
	)
;

array_literal returns [Expression e]
{
}:
	lbrack:LBRACK
		
	(
		(expression FOR)=>(
			projection=expression
			FOR LPAREN ((id=identifier | variable=declaration) IN iterator=expression) RPAREN
			(IF filter=expression)?
			{
				if id is not null: variable = Declaration(ToLexicalInfo(id), Name: id.getText())
				e = CodeFactory.NewArrayComprehension(ToLexicalInfo(lbrack), projection, variable, iterator, filter)
			}
		)
		| { e = ale = ArrayLiteralExpression(ToLexicalInfo(lbrack)); items = ale.Items; } expression_list[items]
	)
	
	RBRACK
;
		
hash_literal returns [HashLiteralExpression dle]
{	
	pair as ExpressionPair
}:
	lbrace:LBRACE { dle = HashLiteralExpression(ToLexicalInfo(lbrace)); }
	(
		pair=expression_pair			
		{ dle.Items.Add(pair); }
		(
			COMMA
			pair=expression_pair
			{ dle.Items.Add(pair); }
		)*
	)?
	RBRACE
;
		
expression_pair returns [ExpressionPair ep]
{
}:
	key=expression t:COLON value=expression
	{
		ep = ExpressionPair(ToLexicalInfo(t), key, value)
	}
;
		
re_literal returns [RELiteralExpression re]
{
}:
	value:RE_LITERAL
	{
		re = RELiteralExpression(ToLexicalInfo(value), value.getText())
	}
;
	
double_literal returns [DoubleLiteralExpression rle]
{
}:
	value:DOUBLE { rle = CodeFactory.NewDoubleLiteralExpression(ToLexicalInfo(value), value.getText()) }
;

self_literal returns [SelfLiteralExpression e]
{
}:
	t:THIS
	{
		e = SelfLiteralExpression(ToLexicalInfo(t))
	}
;
	
super_literal returns [SuperLiteralExpression e]
{
}:
	t:SUPER
	{
		e = SuperLiteralExpression(ToLexicalInfo(t))
	}
;
		
null_literal returns [NullLiteralExpression e]
{
}:
	t:NULL
	{
		e = NullLiteralExpression(ToLexicalInfo(t))
	}
;
		
bool_literal returns [BoolLiteralExpression e]
{
}:
	t:TRUE
	{
		e = BoolLiteralExpression(ToLexicalInfo(t), Value: true)
	} |
	f:FALSE
	{
		e = BoolLiteralExpression(ToLexicalInfo(f), Value: false)
	}
;

integer_literal returns [IntegerLiteralExpression e]
{
}:
	i:INT
	{
		e = ParseIntegerLiteralExpression(i, i.getText(), false);
	}
	|
	l:LONG
	{
		s = l.getText()
		e = ParseIntegerLiteralExpression(l, s[:-1], true)
	}
;
	
string_literal returns [Expression e]
{
}:	
	(dqs:DOUBLE_QUOTED_STRING { s = dqs; } | sqs:SINGLE_QUOTED_STRING { s = sqs; })
	{ e = StringLiteralExpression(ToLexicalInfo(s), s.getText()) }
;


class UnityScriptLexer extends Lexer;
options
{
	testLiterals = false;
	exportVocab = UnityScript;	
	k = 3;
	charVocabulary = '\u0003'..'\uFFFE';
	caseSensitiveLiterals = true;
	// without inlining some bitset tests, ANTLR couldn't do unicode;
	// They need to make ANTLR generate smaller bitsets;
	codeGenBitsetTestThreshold = 20;
}

{
	property PreserveComments = false
	
	static def IsDigit(ch as char):
		return ch >= char('0') and ch <= char('9')
}

ID options { testLiterals = true; }:	ID_LETTER (ID_LETTER | DIGIT)*;

INT: 
	("0x"(HEXDIGIT)+)(('l' | 'L') { $setType(LONG); })? |
	(DIGIT)+
	(
		('l' | 'L') { $setType(LONG); } |
		('f' | 'F' | 'd' | 'D') { $setType(DOUBLE); } |
		('.' DOUBLE_SUFFIX) { $setType(DOUBLE); } |
		EXPONENT { $setType(DOUBLE); } |
	)
;

DOT: '.' (DOUBLE_SUFFIX {$setType(DOUBLE);})?;

protected
DOUBLE_SUFFIX: (DIGIT)+ (EXPONENT)? ('f' | 'F' | 'd' | 'D')?;

protected
EXPONENT: ('e' | 'E') ('+' | '-')? (DIGIT)+;

COLON: ':';

COMMA: ',';

LPAREN: '(';
	
RPAREN: ')';

LBRACK: '[';

RBRACK: ']';

LBRACE: '{';
	
RBRACE: '}';

BITWISE_OR: '|';

INPLACE_BITWISE_OR: "|="; 

BITWISE_AND: '&';

INPLACE_BITWISE_AND: "&=";

BITWISE_XOR: '^';

INPLACE_BITWISE_XOR: "^=";

LOGICAL_OR: "||";

LOGICAL_AND: "&&";

EOS: ';';

ASSIGN: '=';

INCREMENT: "++";

DECREMENT: "--";

ADD: '+';

PRAGMA_ON:
	"#pragma"! (PRAGMA_WHITE_SPACE)+ id:ID
	((PRAGMA_WHITE_SPACE)+ ("off"! { $setType(PRAGMA_OFF); } | "on"!))?
	(PRAGMA_WHITE_SPACE)*
	NEWLINE!;

protected
PRAGMA_WHITE_SPACE: (' '! | '\t'!);

INPLACE_ADD: "+=";

SUBTRACT: '-';

INPLACE_SUBTRACT: "-=";

MODULUS: '%';

MULTIPLY: '*';

INPLACE_MULTIPLY: "*=";

EQUALITY: "==";

INEQUALITY: "!=";

LOGICAL_NOT: '!';

QUESTION_MARK: '?';

BITWISE_NOT: '~';

REFERENCE_EQUALITY: "===";

REFERENCE_INEQUALITY: "!==";

LESS_THAN: '<';

LESS_THAN_OR_EQUAL: "<=";

SHIFT_LEFT: "<<";

INPLACE_SHIFT_LEFT: "<<=";

GREATER_THAN: '>';

GREATER_THAN_OR_EQUAL: ">=";

SHIFT_RIGHT: ">>";

INPLACE_SHIFT_RIGHT: ">>=";

AT: '@';

DIVISION: 
	("/*")=> ML_COMMENT
	{
		if not PreserveComments:
			$setType(Token.SKIP)
	} |
//	(RE_LITERAL)=> RE_LITERAL { $setType(RE_LITERAL); } |	
	'/' (
			('/' (~('\r'|'\n'))*
			{
				if PreserveComments:
					$setType(SL_COMMENT)
				else:
					$setType(Token.SKIP);
			}) |
			('=' { $setType(INPLACE_DIVISION); }) |
		)
;

WHITE_SPACE:
	(
		' ' |
		'\t' |
		'\f' |
		NEWLINE
	)+
	{ $setType(Token.SKIP);	}
;

DOUBLE_QUOTED_STRING:
	'"'!
	(
		DQS_ESC |
		~('"' | '\\' | '\r' | '\n')
	)*
	'"'!
;

SINGLE_QUOTED_STRING:
	'\''!
	(
		SQS_ESC |
		~('\'' | '\\' | '\r' | '\n')
	)*
	'\''!
;


protected
DQS_ESC: '\\'! ( SESC | '"' ) ;	
	
protected
SQS_ESC: '\\'! ( SESC | '\'' );

protected
SESC: 
	( 'r'! {$setText("\r"); }) |
	( 'n'! {$setText("\n"); }) |
	( 't'! {$setText("\t"); }) |
	( 'a'! {text.Length = _begin; text.Append("\a"); }) |
	( 'b'! {text.Length = _begin; text.Append("\b"); }) |
	( 'f'! {text.Length = _begin; text.Append("\f"); }) |
	( '0'! {text.Length = _begin; text.Append("\0"); }) |
	( '\\'! {$setText("\\"); })
;

protected
ML_COMMENT:
	"/*"
    (
		NEWLINE |
		~('*'|'\r'|'\n') |
		{ LA(2) != char('/') }? '*'
    )*
    "*/"
;

protected
RE_LITERAL: '/' (RE_CHAR)+ '/';

protected
RE_CHAR: RE_ESC | ~('/' | '\\' | '\r' | '\n' | ' ' | '\t' );

protected
RE_ESC:
	'\\' (
	
	// character scapes
	// ms-help://MS.NETFrameworkSDKv1.1/cpgenref/html/cpconcharacterescapes.htm
	
				'a' |
				'b' |
				'c' 'A'..'Z' |
				't' |
				'r' |
				'v' |
				'f' |
				'n' |
				'e' |
				(DIGIT)+ |
				'x' DIGIT DIGIT |
				'u' DIGIT DIGIT DIGIT DIGIT |
				'\\' |
				
	// character classes
	// ms-help://MS.NETFrameworkSDKv1.1/cpgenref/html/cpconcharacterclasses.htm
	// /\w\W\s\S\d\D/
	
				'w' |
				'W' |
				's' |
				'S' |
				'd' |
				'D' |
				'p' |
				'P' |
				
	// atomic zero-width assertions
	// ms-help://MS.NETFrameworkSDKv1.1/cpgenref/html/cpconatomiczero-widthassertions.htm
				'A' |
				'z' |
				'Z' |
				'g' |
				'B' |
				
				'k' |
				
				'/' |
				'(' |
				')' |
				'|' |
				'.' |
				'*' |
				'?' |
				'$' |
				'^' |
				'['	|
				']'
			 )
;

protected
NEWLINE:
	(
		'\n' |
		(
			'\r' ('\n')?
		)
	)
	{ newline(); }
;

protected
ID_LETTER: ('_' | 'a'..'z' | 'A'..'Z' );

protected
DIGIT: '0'..'9';

protected
HEXDIGIT : ('a'..'f' | 'A'..'F' | '0'..'9');
