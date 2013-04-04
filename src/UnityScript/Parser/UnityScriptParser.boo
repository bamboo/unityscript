// $ANTLR 2.7.5 (20050517): "src/UnityScript/UnityScript.g" -> "UnityScriptParser.boo"$

namespace UnityScript.Parser
// Generate the header common to all output files.
import System

import antlr.TokenBuffer as TokenBuffer
import antlr.TokenStreamException as TokenStreamException
import antlr.TokenStreamIOException as TokenStreamIOException
import antlr.ANTLRException as ANTLRException
import antlr.LLkParser as LLkParser
import antlr.Token as Token
import antlr.IToken as IToken
import antlr.TokenStream as TokenStream
import antlr.RecognitionException as RecognitionException
import antlr.NoViableAltException as NoViableAltException
import antlr.MismatchedTokenException as MismatchedTokenException
import antlr.SemanticException as SemanticException
import antlr.ParserSharedInputState as ParserSharedInputState
import antlr.collections.impl.BitSet as BitSet

import System.Text
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import System.Globalization

import UnityScript
import UnityScript.Core

partial class UnityScriptParser(antlr.LLkParser):
	public static final EOF = 1
	public static final NULL_TREE_LOOKAHEAD = 3
	public static final AS = 4
	public static final BREAK = 5
	public static final CAST = 6
	public static final CATCH = 7
	public static final CLASS = 8
	public static final CONTINUE = 9
	public static final DO = 10
	public static final ELSE = 11
	public static final EACH = 12
	public static final ENUM = 13
	public static final EXTENDS = 14
	public static final FALSE = 15
	public static final FINAL = 16
	public static final FINALLY = 17
	public static final FOR = 18
	public static final FUNCTION = 19
	public static final GET = 20
	public static final IF = 21
	public static final IMPORT = 22
	public static final IMPLEMENTS = 23
	public static final IN = 24
	public static final INTERFACE = 25
	public static final INSTANCEOF = 26
	public static final NEW = 27
	public static final NOT = 28
	public static final NULL = 29
	public static final RETURN = 30
	public static final PUBLIC = 31
	public static final PROTECTED = 32
	public static final INTERNAL = 33
	public static final OVERRIDE = 34
	public static final PARTIAL = 35
	public static final PRIVATE = 36
	public static final SET = 37
	public static final STATIC = 38
	public static final SUPER = 39
	public static final THIS = 40
	public static final THROW = 41
	public static final TRUE = 42
	public static final TRY = 43
	public static final TYPEOF = 44
	public static final VAR = 45
	public static final VIRTUAL = 46
	public static final WHILE = 47
	public static final YIELD = 48
	public static final SWITCH = 49
	public static final CASE = 50
	public static final DEFAULT = 51
	public static final INPLACE_DIVISION = 52
	public static final INPLACE_ADD = 53
	public static final INPLACE_SUBTRACT = 54
	public static final INPLACE_MULTIPLY = 55
	public static final SL_COMMENT = 56
	public static final PRAGMA_ON = 57
	public static final PRAGMA_OFF = 58
	public static final ID = 59
	public static final DOUBLE_QUOTED_STRING = 60
	public static final LBRACE = 61
	public static final RBRACE = 62
	public static final LPAREN = 63
	public static final RPAREN = 64
	public static final DOT = 65
	public static final COLON = 66
	public static final COMMA = 67
	public static final LBRACK = 68
	public static final RBRACK = 69
	public static final BITWISE_OR = 70
	public static final INPLACE_BITWISE_OR = 71
	public static final BITWISE_AND = 72
	public static final BITWISE_XOR = 73
	public static final INPLACE_BITWISE_AND = 74
	public static final LOGICAL_OR = 75
	public static final LOGICAL_AND = 76
	public static final EOS = 77
	public static final ASSIGN = 78
	public static final INCREMENT = 79
	public static final DECREMENT = 80
	public static final ADD = 81
	public static final SUBTRACT = 82
	public static final MODULUS = 83
	public static final MULTIPLY = 84
	public static final EQUALITY = 85
	public static final INEQUALITY = 86
	public static final QUESTION_MARK = 87
	public static final BITWISE_NOT = 88
	public static final REFERENCE_EQUALITY = 89
	public static final REFERENCE_INEQUALITY = 90
	public static final LESS_THAN = 91
	public static final LESS_THAN_OR_EQUAL = 92
	public static final SHIFT_LEFT = 93
	public static final INPLACE_SHIFT_LEFT = 94
	public static final GREATER_THAN = 95
	public static final GREATER_THAN_OR_EQUAL = 96
	public static final SHIFT_RIGHT = 97
	public static final INPLACE_SHIFT_RIGHT = 98
	public static final AT = 99
	public static final SCRIPT_ATTRIBUTE_MARKER = 100
	public static final ASSEMBLY_ATTRIBUTE_MARKER = 101
	public static final INPLACE_BITWISE_XOR = 102
	public static final LOGICAL_NOT = 103
	public static final DIVISION = 104
	public static final RE_LITERAL = 105
	public static final DOUBLE = 106
	public static final INT = 107
	public static final LONG = 108
	public static final SINGLE_QUOTED_STRING = 109
	public static final DOUBLE_SUFFIX = 110
	public static final EXPONENT = 111
	public static final PRAGMA_WHITE_SPACE = 112
	public static final WHITE_SPACE = 113
	public static final DQS_ESC = 114
	public static final SQS_ESC = 115
	public static final SESC = 116
	public static final ML_COMMENT = 117
	public static final RE_CHAR = 118
	public static final RE_ESC = 119
	public static final NEWLINE = 120
	public static final ID_LETTER = 121
	public static final DIGIT = 122
	public static final HEXDIGIT = 123
	
	
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
	
	protected def initialize():
		tokenNames = tokenNames_
	
	
	protected def constructor(tokenBuf as TokenBuffer, k as int):
		super(tokenBuf, k)
		initialize()
	
	def constructor(tokenBuf as TokenBuffer):
		self(tokenBuf, 2)
	
	protected def constructor(lexer as TokenStream, k as int):
		super(lexer, k)
		initialize()
	
	public def constructor(lexer as TokenStream):
		self(lexer, 2)
	
	public def constructor(state as ParserSharedInputState):
		super(state, 2)
		initialize()
	
	public def start(
		cu as CompileUnit 
	) as void: //throws RecognitionException, TokenStreamException
		
		eof as IToken  = null
		module = CodeFactory.NewModule(getFilename())
		cu.Modules.Add(module)
		globals = module.Globals
		
		try:     // for error handling
			while true:
				_givenValue  = LA(1)
				if ((_givenValue == IMPORT)): // 1831
					import_directive(module)
				elif ((_givenValue == PRAGMA_ON)
					 or (_givenValue ==PRAGMA_OFF)
				): // 1827
					pragma_directive(module)
				else: // line 1969
					synPredMatched4 as bool = false
					if ((LA(1)==AT) and (LA(2)==ID)):
						_m4 as int = mark()
						synPredMatched4 = true
						++inputState.guessing
						try:
							match(AT)
							match(ID)
							match(ID)
						except x as RecognitionException:
							synPredMatched4 = false
						rewind(_m4)
						--inputState.guessing
					if synPredMatched4:
						script_or_assembly_attribute(module)
					else:
						goto _loop5_breakloop
			:_loop5_breakloop
			while true:
				synPredMatched8 as bool = false
				if ((LA(1)==AT) and (LA(2)==ID)):
					_m8 as int = mark()
					synPredMatched8 = true
					++inputState.guessing
					try:
						match(AT)
						match(ID)
						match(ID)
					except x as RecognitionException:
						synPredMatched8 = false
					rewind(_m8)
					--inputState.guessing
				if synPredMatched8:
					script_or_assembly_attribute(module)
				elif ((LA(1)==AT) and (LA(2)==ID)): // line 2102
					attributes()
					module_member(module)
				elif ((tokenSet_0_.member(cast(int, LA(1)))) and (tokenSet_1_.member(cast(int, LA(2))))): // line 2102
					module_member(module)
				elif ((tokenSet_2_.member(cast(int, LA(1)))) and (tokenSet_3_.member(cast(int, LA(2))))): // line 2102
					compound_or_single_stmt(globals)
				else:
					goto _loop10_breakloop
			:_loop10_breakloop
			eof = LT(1)
			match(Token.EOF_TYPE)
			if 0 == inputState.guessing:
				SetEndSourceLocation(module, eof)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_4_)
			else:
				raise
	
	public def import_directive(
		container as Module 
	) as void: //throws RecognitionException, TokenStreamException
		
		imp as IToken  = null
		
		try:     // for error handling
			imp = LT(1)
			match(IMPORT)
			ns=qname()
			eos()
			if 0 == inputState.guessing:
				container.Imports.Add(
					Import(ToLexicalInfo(imp), ReferenceExpression(ToLexicalInfo(ns), ns.getText())))
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_5_)
			else:
				raise
	
	public def pragma_directive(
		container as Module 
	) as void: //throws RecognitionException, TokenStreamException
		
		on as IToken  = null
		off as IToken  = null
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == PRAGMA_ON)): // 1831
				on = LT(1)
				match(PRAGMA_ON)
				if 0 == inputState.guessing:
					id=on 
			elif ((_givenValue == PRAGMA_OFF)): // 1831
				off = LT(1)
				match(PRAGMA_OFF)
				if 0 == inputState.guessing:
					id=off 
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				pragma = id.getText()
				if Pragmas.IsValid(pragma):
					if on is not null:
						Pragmas.TryToEnableOn(container, pragma)
					else:
						Pragmas.DisableOn(container, pragma)
				else:
					ReportError(UnityScriptCompilerErrors.UnknownPragma(ToLexicalInfo(id), pragma))
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_5_)
			else:
				raise
	
	public def script_or_assembly_attribute(
		m as Module 
	) as void: //throws RecognitionException, TokenStreamException
		
		attributeKindToken as IToken  = null
		
		try:     // for error handling
			match(AT)
			attributeKindToken = LT(1)
			match(ID)
			attr=attribute_constructor()
			if 0 == inputState.guessing:
				attributeKind = attributeKindToken.getText()
				if attributeKind == "assembly":
					m.AssemblyAttributes.Add(attr)
				elif attributeKind == "script":
					m.Attributes.Add(attr)
				else:
					UnexpectedToken(attributeKindToken)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_5_)
			else:
				raise
	
	public def attributes() as void: //throws RecognitionException, TokenStreamException
		
		_attributes.Clear()
		
		try:     // for error handling
			_cnt18 as int = 0
			while true:
				if ((LA(1)==AT)):
					attribute()
				else:
					if (_cnt18 >= 1):
						goto _loop18_breakloop
					else:
						raise NoViableAltException(LT(1), getFilename())
				++_cnt18
			:_loop18_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_6_)
			else:
				raise
	
	public def module_member(
		module as Module 
	) as void: //throws RecognitionException, TokenStreamException
		
		globals = module.Globals
		
		try:     // for error handling
			synPredMatched27 as bool = false
			if (((tokenSet_7_.member(cast(int, LA(1)))) and (tokenSet_8_.member(cast(int, LA(2))))) and (GlobalVariablesBecomeFields())):
				_m27 as int = mark()
				synPredMatched27 = true
				++inputState.guessing
				try:
					module_member_modifiers()
					match(VAR)
				except x as RecognitionException:
					synPredMatched27 = false
				rewind(_m27)
				--inputState.guessing
			if synPredMatched27:
				module_field(module)
			elif ((LA(1)==VAR) and (tokenSet_9_.member(cast(int, LA(2))))): // line 2102
				declaration_statement(globals)
				eos()
			elif ((tokenSet_10_.member(cast(int, LA(1)))) and (tokenSet_11_.member(cast(int, LA(2))))): // line 2102
				mod=module_member_modifiers()
				_givenValue  = LA(1)
				if ((_givenValue == CLASS)
					 or (_givenValue ==PARTIAL)
				): // 1827
					mm=class_declaration(module)
				elif ((_givenValue == INTERFACE)): // 1831
					mm=interface_declaration(module)
				elif ((_givenValue == ENUM)): // 1831
					mm=enum_declaration(module)
				elif ((_givenValue == FUNCTION)): // 1831
					mm=function_member(module)
				else: // line 1969
						raise NoViableAltException(LT(1), getFilename())
				if 0 == inputState.guessing:
					mm.Modifiers |= mod if mm is not null 
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_12_)
			else:
				raise
	
	public def compound_or_single_stmt(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			if ((LA(1)==LBRACE) and (tokenSet_13_.member(cast(int, LA(2))))):
				compound_statement(b)
			elif ((tokenSet_2_.member(cast(int, LA(1)))) and (tokenSet_14_.member(cast(int, LA(2))))): // line 2102
				statement(b)
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def attribute_parameter(
		attr as Ast.Attribute 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			synPredMatched13 as bool = false
			if ((LA(1)==EACH or LA(1)==ID) and (LA(2)==DOT or LA(2)==ASSIGN)):
				_m13 as int = mark()
				synPredMatched13 = true
				++inputState.guessing
				try:
					match(ID)
					match(ASSIGN)
				except x as RecognitionException:
					synPredMatched13 = false
				rewind(_m13)
				--inputState.guessing
			if synPredMatched13:
				name=reference_expression()
				match(ASSIGN)
				value=expression()
				if 0 == inputState.guessing:
					attr.NamedArguments.Add(ExpressionPair(name, value))
			elif ((tokenSet_16_.member(cast(int, LA(1)))) and (tokenSet_17_.member(cast(int, LA(2))))): // line 2102
				value=expression()
				if 0 == inputState.guessing:
					attr.Arguments.Add(value)
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_18_)
			else:
				raise
	
	public def reference_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		
		try:     // for error handling
			e=simple_reference_expression()
			while true:
				if ((LA(1)==DOT)):
					match(DOT)
					e=member_reference_expression(e)
				else:
					goto _loop211_breakloop
			:_loop211_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_19_)
			else:
				raise
		return e
	
	public def expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		
		try:     // for error handling
			e=conditional_expression()
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def attribute() as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			match(AT)
			attr=attribute_constructor()
			if 0 == inputState.guessing:
				_attributes.Add(attr)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_21_)
			else:
				raise
	
	public def attribute_constructor() as Boo.Lang.Compiler.Ast.Attribute : //throws RecognitionException, TokenStreamException
		attr as Boo.Lang.Compiler.Ast.Attribute 
		
		
		try:     // for error handling
			name=qname()
			if 0 == inputState.guessing:
				attr = Ast.Attribute(ToLexicalInfo(name), name.getText())
			if ((LA(1)==LPAREN) and (tokenSet_22_.member(cast(int, LA(2))))):
				match(LPAREN)
				_givenValue  = LA(1)
				if ((_givenValue == EACH)
					 or (_givenValue ==FALSE)
					 or (_givenValue ==FUNCTION)
					 or (_givenValue ==NEW)
					 or (_givenValue ==NULL)
					 or (_givenValue ==SUPER)
					 or (_givenValue ==THIS)
					 or (_givenValue ==TRUE)
					 or (_givenValue ==TYPEOF)
					 or (_givenValue ==ID)
					 or (_givenValue ==DOUBLE_QUOTED_STRING)
					 or (_givenValue ==LBRACE)
					 or (_givenValue ==LPAREN)
					 or (_givenValue ==LBRACK)
					 or (_givenValue ==INCREMENT)
					 or (_givenValue ==DECREMENT)
					 or (_givenValue ==SUBTRACT)
					 or (_givenValue ==BITWISE_NOT)
					 or (_givenValue ==LOGICAL_NOT)
					 or (_givenValue ==RE_LITERAL)
					 or (_givenValue ==DOUBLE)
					 or (_givenValue ==INT)
					 or (_givenValue ==LONG)
					 or (_givenValue ==SINGLE_QUOTED_STRING)
				): // 1827
					attribute_parameter(attr)
					while true:
						if ((LA(1)==COMMA)):
							match(COMMA)
							attribute_parameter(attr)
						else:
							goto _loop24_breakloop
					:_loop24_breakloop
				elif ((_givenValue == RPAREN)): // 1831
					pass // 947
				else: // line 1969
						raise NoViableAltException(LT(1), getFilename())
				match(RPAREN)
			elif ((tokenSet_23_.member(cast(int, LA(1)))) and (tokenSet_24_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_23_)
			else:
				raise
		return attr
	
	public def qname() as Token : //throws RecognitionException, TokenStreamException
		id as Token 
		
		start as IToken  = null
		other as IToken  = null
		
		try:     // for error handling
			start = LT(1)
			match(ID)
			if 0 == inputState.guessing:
				id = start		
				buffer = StringBuilder()
				buffer.Append(start.getText())
			while true:
				if ((LA(1)==DOT) and (LA(2)==ID)):
					match(DOT)
					other = LT(1)
					match(ID)
					if 0 == inputState.guessing:
						buffer.Append(".")
						buffer.Append(other.getText())
				else:
					goto _loop35_breakloop
			:_loop35_breakloop
			if 0 == inputState.guessing:
				id.setText(buffer.ToString())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_25_)
			else:
				raise
		return id
	
	public def module_member_modifiers() as TypeMemberModifiers : //throws RecognitionException, TokenStreamException
		m as TypeMemberModifiers 
		
		v as IToken  = null
		m = TypeMemberModifiers.None
		
		try:     // for error handling
			while true:
				_givenValue  = LA(1)
				if ((_givenValue == FINAL)): // 1831
					match(FINAL)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Final 
				elif ((_givenValue == PUBLIC)): // 1831
					match(PUBLIC)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Public 
				elif ((_givenValue == PRIVATE)): // 1831
					match(PRIVATE)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Private 
				elif ((_givenValue == PROTECTED)): // 1831
					match(PROTECTED)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Protected 
				elif ((_givenValue == INTERNAL)): // 1831
					match(INTERNAL)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Internal 
				elif ((_givenValue == STATIC)): // 1831
					match(STATIC)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Static 
				elif ((_givenValue == VIRTUAL)): // 1831
					v = LT(1)
					match(VIRTUAL)
					if 0 == inputState.guessing:
						VirtualKeywordHasNoEffect(v) 
				else: // line 1969
						goto _loop45_breakloop
			:_loop45_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_26_)
			else:
				raise
		return m
	
	public def module_field(
		m as Module 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			mod=module_member_modifiers()
			f=field_member(m)
			if 0 == inputState.guessing:
				f.Modifiers |= mod 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_12_)
			else:
				raise
	
	public def declaration_statement(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			d=declaration()
			_givenValue  = LA(1)
			if ((_givenValue == ASSIGN)): // 1831
				match(ASSIGN)
				i=expression()
			elif ((_givenValue == EOF)
				 or (_givenValue ==BREAK)
				 or (_givenValue ==CATCH)
				 or (_givenValue ==CLASS)
				 or (_givenValue ==CONTINUE)
				 or (_givenValue ==DO)
				 or (_givenValue ==ELSE)
				 or (_givenValue ==EACH)
				 or (_givenValue ==ENUM)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==FINALLY)
				 or (_givenValue ==FOR)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==GET)
				 or (_givenValue ==IF)
				 or (_givenValue ==INTERFACE)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==RETURN)
				 or (_givenValue ==PUBLIC)
				 or (_givenValue ==PROTECTED)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==PARTIAL)
				 or (_givenValue ==PRIVATE)
				 or (_givenValue ==SET)
				 or (_givenValue ==STATIC)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==THROW)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TRY)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==VAR)
				 or (_givenValue ==VIRTUAL)
				 or (_givenValue ==WHILE)
				 or (_givenValue ==YIELD)
				 or (_givenValue ==SWITCH)
				 or (_givenValue ==CASE)
				 or (_givenValue ==DEFAULT)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==RBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==EOS)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==AT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				stmt = DeclarationStatement(d.LexicalInfo, Declaration: d, Initializer: i)
				b.Add(stmt)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def eos() as antlr.IToken : //throws RecognitionException, TokenStreamException
		firstEOS as antlr.IToken 
		
		t as IToken  = null
		
		try:     // for error handling
			if ((LA(1)==EOS) and (tokenSet_27_.member(cast(int, LA(2))))):
				_cnt42 as int = 0
				while true:
					if ((LA(1)==EOS) and (tokenSet_27_.member(cast(int, LA(2))))):
						t = LT(1)
						match(EOS)
						if 0 == inputState.guessing:
							if firstEOS is null: firstEOS = t 
					else:
						if (_cnt42 >= 1):
							goto _loop42_breakloop
						else:
							raise NoViableAltException(LT(1), getFilename())
					++_cnt42
				:_loop42_breakloop
			elif ((tokenSet_27_.member(cast(int, LA(1)))) and (tokenSet_28_.member(cast(int, LA(2))))): // line 2102
				if 0 == inputState.guessing:
					SemicolonExpected() 
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_27_)
			else:
				raise
		return firstEOS
	
	public def class_declaration(
		parent as TypeDefinition 
	) as TypeMember : //throws RecognitionException, TokenStreamException
		member as TypeMember 
		
		p as IToken  = null
		name as IToken  = null
		rbrace as IToken  = null
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == PARTIAL)): // 1831
				p = LT(1)
				match(PARTIAL)
			elif ((_givenValue == CLASS)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			match(CLASS)
			name = LT(1)
			match(ID)
			_givenValue  = LA(1)
			if ((_givenValue == EXTENDS)): // 1831
				match(EXTENDS)
				baseType=type_reference()
			elif ((_givenValue == IMPLEMENTS)
				 or (_givenValue ==LBRACE)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				member = cd = ClassDefinition(ToLexicalInfo(name), Name: name.getText())
				baseTypes = cd.BaseTypes
				if baseType is not null:
					baseTypes.Add(baseType)
				cd.Modifiers |= TypeMemberModifiers.Partial if p is not null
				FlushAttributes(cd)
				parent.Members.Add(cd)
			_givenValue  = LA(1)
			if ((_givenValue == IMPLEMENTS)): // 1831
				match(IMPLEMENTS)
				type_reference_list(baseTypes)
			elif ((_givenValue == LBRACE)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				for typeRef in baseTypes:
					if typeRef is baseType:
						BaseTypeAnnotations.AnnotateExtends(typeRef)
					else:
						BaseTypeAnnotations.AnnotateImplements(typeRef)
			match(LBRACE)
			while true:
				if ((tokenSet_29_.member(cast(int, LA(1))))):
					if 0 == inputState.guessing:
						mod = TypeMemberModifiers.None 
					_givenValue  = LA(1)
					if ((_givenValue == AT)): // 1831
						attributes()
					elif ((_givenValue == CLASS)
						 or (_givenValue ==ENUM)
						 or (_givenValue ==FINAL)
						 or (_givenValue ==FUNCTION)
						 or (_givenValue ==INTERFACE)
						 or (_givenValue ==NEW)
						 or (_givenValue ==PUBLIC)
						 or (_givenValue ==PROTECTED)
						 or (_givenValue ==INTERNAL)
						 or (_givenValue ==OVERRIDE)
						 or (_givenValue ==PARTIAL)
						 or (_givenValue ==PRIVATE)
						 or (_givenValue ==STATIC)
						 or (_givenValue ==VAR)
						 or (_givenValue ==VIRTUAL)
					): // 1827
						pass // 947
					else: // line 1969
							raise NoViableAltException(LT(1), getFilename())
					if ((tokenSet_30_.member(cast(int, LA(1)))) and (tokenSet_31_.member(cast(int, LA(2))))):
						mod=member_modifiers()
					elif ((tokenSet_26_.member(cast(int, LA(1)))) and (tokenSet_32_.member(cast(int, LA(2))))): // line 2102
						pass // 947
					else:
						raise NoViableAltException(LT(1), getFilename())
					_givenValue  = LA(1)
					if ((_givenValue == FUNCTION)): // 1831
						m=function_member(cd)
					elif ((_givenValue == VAR)): // 1831
						m=field_member(cd)
					elif ((_givenValue == ENUM)): // 1831
						m=enum_declaration(cd)
					elif ((_givenValue == CLASS)
						 or (_givenValue ==PARTIAL)
					): // 1827
						m=class_declaration(cd)
					elif ((_givenValue == INTERFACE)): // 1831
						m=interface_declaration(cd)
					else: // line 1969
							raise NoViableAltException(LT(1), getFilename())
					if 0 == inputState.guessing:
						m.Modifiers |= mod if m is not null 
				else:
					goto _loop57_breakloop
			:_loop57_breakloop
			rbrace = LT(1)
			match(RBRACE)
			if 0 == inputState.guessing:
				SetEndSourceLocation(cd, rbrace) 
			while true:
				if ((LA(1)==EOS) and (tokenSet_33_.member(cast(int, LA(2))))):
					match(EOS)
				else:
					goto _loop59_breakloop
			:_loop59_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_33_)
			else:
				raise
		return member
	
	public def interface_declaration(
		parent as TypeDefinition 
	) as TypeMember : //throws RecognitionException, TokenStreamException
		member as TypeMember 
		
		name as IToken  = null
		rbrace as IToken  = null
		
		try:     // for error handling
			match(INTERFACE)
			name = LT(1)
			match(ID)
			if 0 == inputState.guessing:
				member = td = InterfaceDefinition(ToLexicalInfo(name), Name: name.getText())
				baseTypes = td.BaseTypes
				FlushAttributes(td)
				parent.Members.Add(td)
			_givenValue  = LA(1)
			if ((_givenValue == EXTENDS)): // 1831
				match(EXTENDS)
				type_reference_list(baseTypes)
			elif ((_givenValue == LBRACE)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			match(LBRACE)
			while true:
				if ((LA(1)==FUNCTION or LA(1)==AT)):
					_givenValue  = LA(1)
					if ((_givenValue == AT)): // 1831
						attributes()
					elif ((_givenValue == FUNCTION)): // 1831
						pass // 947
					else: // line 1969
							raise NoViableAltException(LT(1), getFilename())
					interface_member(td)
				else:
					goto _loop64_breakloop
			:_loop64_breakloop
			rbrace = LT(1)
			match(RBRACE)
			if 0 == inputState.guessing:
				SetEndSourceLocation(td, rbrace) 
			while true:
				if ((LA(1)==EOS) and (tokenSet_33_.member(cast(int, LA(2))))):
					match(EOS)
				else:
					goto _loop66_breakloop
			:_loop66_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_33_)
			else:
				raise
		return member
	
	public def enum_declaration(
		container as TypeDefinition 
	) as TypeMember : //throws RecognitionException, TokenStreamException
		member as TypeMember 
		
		name as IToken  = null
		rbrace as IToken  = null
		
		try:     // for error handling
			match(ENUM)
			name = LT(1)
			match(ID)
			if 0 == inputState.guessing:
				member = ed = EnumDefinition(ToLexicalInfo(name), Name: name.getText())
				FlushAttributes(member);
				container.Members.Add(ed)
			match(LBRACE)
			_givenValue  = LA(1)
			if ((_givenValue == EACH)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==ID)
				 or (_givenValue ==AT)
			): // 1827
				enum_member(ed)
				while true:
					if ((LA(1)==COMMA) and (tokenSet_34_.member(cast(int, LA(2))))):
						match(COMMA)
						enum_member(ed)
					else:
						goto _loop76_breakloop
				:_loop76_breakloop
				_givenValue  = LA(1)
				if ((_givenValue == COMMA)): // 1831
					match(COMMA)
				elif ((_givenValue == RBRACE)): // 1831
					pass // 947
				else: // line 1969
						raise NoViableAltException(LT(1), getFilename())
			elif ((_givenValue == RBRACE)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			rbrace = LT(1)
			match(RBRACE)
			if 0 == inputState.guessing:
				SetEndSourceLocation(ed, rbrace) 
			while true:
				if ((LA(1)==EOS) and (tokenSet_33_.member(cast(int, LA(2))))):
					match(EOS)
				else:
					goto _loop79_breakloop
			:_loop79_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_33_)
			else:
				raise
		return member
	
	public def function_member(
		cd as TypeDefinition 
	) as TypeMember : //throws RecognitionException, TokenStreamException
		member as TypeMember 
		
		getter as IToken  = null
		setter as IToken  = null
		
		try:     // for error handling
			match(FUNCTION)
			_givenValue  = LA(1)
			if ((_givenValue == GET)): // 1831
				getter = LT(1)
				match(GET)
			elif ((_givenValue == SET)): // 1831
				setter = LT(1)
				match(SET)
			elif ((_givenValue == EACH)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==ID)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			memberName=identifier()
			if 0 == inputState.guessing:
				member = function = AddFunctionTo(cd, memberName, getter, setter) 
			function_body(function)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_33_)
			else:
				raise
		return member
	
	public def field_member(
		cd as TypeDefinition 
	) as TypeMember : //throws RecognitionException, TokenStreamException
		member as TypeMember 
		
		
		try:     // for error handling
			match(VAR)
			name=identifier()
			_givenValue  = LA(1)
			if ((_givenValue == COLON)): // 1831
				match(COLON)
				tr=type_reference()
			elif ((_givenValue == EOF)
				 or (_givenValue ==BREAK)
				 or (_givenValue ==CLASS)
				 or (_givenValue ==CONTINUE)
				 or (_givenValue ==DO)
				 or (_givenValue ==EACH)
				 or (_givenValue ==ENUM)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==FOR)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==GET)
				 or (_givenValue ==IF)
				 or (_givenValue ==INTERFACE)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==RETURN)
				 or (_givenValue ==PUBLIC)
				 or (_givenValue ==PROTECTED)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==OVERRIDE)
				 or (_givenValue ==PARTIAL)
				 or (_givenValue ==PRIVATE)
				 or (_givenValue ==SET)
				 or (_givenValue ==STATIC)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==THROW)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TRY)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==VAR)
				 or (_givenValue ==VIRTUAL)
				 or (_givenValue ==WHILE)
				 or (_givenValue ==YIELD)
				 or (_givenValue ==SWITCH)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==RBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==EOS)
				 or (_givenValue ==ASSIGN)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==AT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			_givenValue  = LA(1)
			if ((_givenValue == ASSIGN)): // 1831
				match(ASSIGN)
				initializer=expression()
			elif ((_givenValue == EOF)
				 or (_givenValue ==BREAK)
				 or (_givenValue ==CLASS)
				 or (_givenValue ==CONTINUE)
				 or (_givenValue ==DO)
				 or (_givenValue ==EACH)
				 or (_givenValue ==ENUM)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==FOR)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==GET)
				 or (_givenValue ==IF)
				 or (_givenValue ==INTERFACE)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==RETURN)
				 or (_givenValue ==PUBLIC)
				 or (_givenValue ==PROTECTED)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==OVERRIDE)
				 or (_givenValue ==PARTIAL)
				 or (_givenValue ==PRIVATE)
				 or (_givenValue ==SET)
				 or (_givenValue ==STATIC)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==THROW)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TRY)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==VAR)
				 or (_givenValue ==VIRTUAL)
				 or (_givenValue ==WHILE)
				 or (_givenValue ==YIELD)
				 or (_givenValue ==SWITCH)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==RBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==EOS)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==AT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			finalToken=eos()
			if 0 == inputState.guessing:
				member = Field(ToLexicalInfo(name),
						Name: name.getText(),
						Type: tr,
						Initializer: initializer)
				if finalToken is not null: SetEndSourceLocation(member, finalToken)
				FlushAttributes(member)
				cd.Members.Add(member)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_33_)
			else:
				raise
		return member
	
	public def member_modifiers() as TypeMemberModifiers : //throws RecognitionException, TokenStreamException
		m as TypeMemberModifiers 
		
		v as IToken  = null
		m = TypeMemberModifiers.None
		
		try:     // for error handling
			while true:
				_givenValue  = LA(1)
				if ((_givenValue == FINAL)): // 1831
					match(FINAL)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Final 
				elif ((_givenValue == OVERRIDE)): // 1831
					match(OVERRIDE)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Override 
				elif ((_givenValue == PUBLIC)): // 1831
					match(PUBLIC)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Public 
				elif ((_givenValue == PRIVATE)): // 1831
					match(PRIVATE)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Private 
				elif ((_givenValue == PROTECTED)): // 1831
					match(PROTECTED)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Protected 
				elif ((_givenValue == INTERNAL)): // 1831
					match(INTERNAL)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Internal 
				elif ((_givenValue == STATIC)): // 1831
					match(STATIC)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.Static 
				elif ((_givenValue == NEW)): // 1831
					match(NEW)
					if 0 == inputState.guessing:
						m |= TypeMemberModifiers.New 
				elif ((_givenValue == VIRTUAL)): // 1831
					v = LT(1)
					match(VIRTUAL)
					if 0 == inputState.guessing:
						VirtualKeywordHasNoEffect(v) 
				else: // line 1969
						goto _loop48_breakloop
			:_loop48_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_26_)
			else:
				raise
		return m
	
	public def type_reference() as TypeReference : //throws RecognitionException, TokenStreamException
		tr as TypeReference 
		
		lbrack as IToken  = null
		rank = 1
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == ID)): // 1831
				tr=simple_type_reference()
			elif ((_givenValue == FUNCTION)): // 1831
				tr=anonymous_function_type()
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if ((LA(1)==LBRACK) and (LA(2)==COMMA or LA(2)==RBRACK)):
				lbrack = LT(1)
				match(LBRACK)
				while true:
					if ((LA(1)==COMMA)):
						match(COMMA)
						if 0 == inputState.guessing:
							++rank 
					else:
						goto _loop179_breakloop
				:_loop179_breakloop
				match(RBRACK)
				if 0 == inputState.guessing:
					tr = ArrayTypeReference(tr.LexicalInfo, tr, IntegerLiteralExpression(ToLexicalInfo(lbrack), rank))
			elif ((tokenSet_35_.member(cast(int, LA(1)))) and (tokenSet_25_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_35_)
			else:
				raise
		return tr
	
	public def type_reference_list(
		typeReferences as TypeReferenceCollection 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			tr=type_reference()
			if 0 == inputState.guessing:
				typeReferences.Add(tr) 
			while true:
				if ((LA(1)==COMMA)):
					match(COMMA)
					tr=type_reference()
					if 0 == inputState.guessing:
						typeReferences.Add(tr) 
				else:
					goto _loop195_breakloop
			:_loop195_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_36_)
			else:
				raise
	
	public def interface_member(
		parent as TypeDefinition 
	) as void: //throws RecognitionException, TokenStreamException
		
		getter as IToken  = null
		setter as IToken  = null
		
		try:     // for error handling
			match(FUNCTION)
			_givenValue  = LA(1)
			if ((_givenValue == GET)): // 1831
				getter = LT(1)
				match(GET)
			elif ((_givenValue == SET)): // 1831
				setter = LT(1)
				match(SET)
			elif ((_givenValue == EACH)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==ID)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			memberName=identifier()
			if 0 == inputState.guessing:
				function = AddFunctionTo(parent, memberName, getter, setter) 
			match(LPAREN)
			_givenValue  = LA(1)
			if ((_givenValue == EACH)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==ID)
				 or (_givenValue ==AT)
			): // 1827
				parameter_declaration_list(function)
			elif ((_givenValue == RPAREN)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			match(RPAREN)
			_givenValue  = LA(1)
			if ((_givenValue == COLON)): // 1831
				match(COLON)
				tr=type_reference()
				if 0 == inputState.guessing:
					function.ReturnType = tr; 
			elif ((_givenValue == FUNCTION)
				 or (_givenValue ==RBRACE)
				 or (_givenValue ==EOS)
				 or (_givenValue ==AT)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			while true:
				if ((LA(1)==EOS)):
					match(EOS)
				else:
					goto _loop72_breakloop
			:_loop72_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_37_)
			else:
				raise
	
	public def identifier() as antlr.IToken : //throws RecognitionException, TokenStreamException
		token as antlr.IToken 
		
		name as IToken  = null
		f as IToken  = null
		i as IToken  = null
		e as IToken  = null
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == ID)): // 1831
				name = LT(1)
				match(ID)
				if 0 == inputState.guessing:
					token = name; 
			elif ((_givenValue == FINAL)): // 1831
				f = LT(1)
				match(FINAL)
				if 0 == inputState.guessing:
					token = f; KeywordCannotBeUsedAsAnIdentifier(token); 
			elif ((_givenValue == INTERNAL)): // 1831
				i = LT(1)
				match(INTERNAL)
				if 0 == inputState.guessing:
					token = i; KeywordCannotBeUsedAsAnIdentifier(token); 
			elif ((_givenValue == EACH)): // 1831
				e = LT(1)
				match(EACH)
				if 0 == inputState.guessing:
					token = e; 
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_38_)
			else:
				raise
		return token
	
	public def parameter_declaration_list(
		m as INodeWithParameters 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			parameter_declaration(m)
			while true:
				if ((LA(1)==COMMA)):
					match(COMMA)
					parameter_declaration(m)
				else:
					goto _loop94_breakloop
			:_loop94_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_39_)
			else:
				raise
	
	public def enum_member(
		container as EnumDefinition 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == AT)): // 1831
				attributes()
			elif ((_givenValue == EACH)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==ID)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			name=identifier()
			_givenValue  = LA(1)
			if ((_givenValue == ASSIGN)): // 1831
				match(ASSIGN)
				initializer=integer_literal()
			elif ((_givenValue == RBRACE)
				 or (_givenValue ==COMMA)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				em = EnumMember(ToLexicalInfo(name), Name: name.getText(), Initializer: initializer)
				FlushAttributes(em)
				container.Members.Add(em)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_40_)
			else:
				raise
	
	public def integer_literal() as IntegerLiteralExpression : //throws RecognitionException, TokenStreamException
		e as IntegerLiteralExpression 
		
		i as IToken  = null
		l as IToken  = null
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == INT)): // 1831
				i = LT(1)
				match(INT)
				if 0 == inputState.guessing:
					e = ParseIntegerLiteralExpression(i, i.getText(), false);
			elif ((_givenValue == LONG)): // 1831
				l = LT(1)
				match(LONG)
				if 0 == inputState.guessing:
					s = l.getText()
					e = ParseIntegerLiteralExpression(l, s[:-1], true)
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def function_body(
		method as Method 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			match(LPAREN)
			_givenValue  = LA(1)
			if ((_givenValue == EACH)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==ID)
				 or (_givenValue ==AT)
			): // 1827
				parameter_declaration_list(method)
			elif ((_givenValue == RPAREN)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			match(RPAREN)
			_givenValue  = LA(1)
			if ((_givenValue == COLON)): // 1831
				match(COLON)
				tr=type_reference()
				if 0 == inputState.guessing:
					method.ReturnType = tr; 
			elif ((_givenValue == LBRACE)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			compound_statement(method.Body)
			if 0 == inputState.guessing:
				method.EndSourceLocation = method.Body.EndSourceLocation 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_33_)
			else:
				raise
	
	public def compound_statement(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			block(b)
			while true:
				if ((LA(1)==EOS) and (tokenSet_41_.member(cast(int, LA(2))))):
					match(EOS)
				else:
					goto _loop101_breakloop
			:_loop101_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_41_)
			else:
				raise
	
	public def parameter_declaration(
		m as INodeWithParameters 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == AT)): // 1831
				attributes()
			elif ((_givenValue == EACH)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==ID)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			id=identifier()
			_givenValue  = LA(1)
			if ((_givenValue == COLON)): // 1831
				match(COLON)
				tr=type_reference()
			elif ((_givenValue == RPAREN)
				 or (_givenValue ==COMMA)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				parameter = ParameterDeclaration(ToLexicalInfo(id), Name: id.getText(), Type: tr)
				m.Parameters.Add(parameter)
				FlushAttributes(parameter)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_18_)
			else:
				raise
	
	public def statement(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			synPredMatched107 as bool = false
			if ((tokenSet_42_.member(cast(int, LA(1)))) and (tokenSet_16_.member(cast(int, LA(2))))):
				_m107 as int = mark()
				synPredMatched107 = true
				++inputState.guessing
				try:
					macro_application_test()
				except x as RecognitionException:
					synPredMatched107 = false
				rewind(_m107)
				--inputState.guessing
			if synPredMatched107:
				macro_application_block(b)
			elif ((tokenSet_43_.member(cast(int, LA(1)))) and (tokenSet_14_.member(cast(int, LA(2))))): // line 2102
				builtin_statement(b)
			elif ((LA(1)==EOS)): // line 2102
				_cnt109 as int = 0
				while true:
					if ((LA(1)==EOS) and (tokenSet_15_.member(cast(int, LA(2))))):
						match(EOS)
					else:
						if (_cnt109 >= 1):
							goto _loop109_breakloop
						else:
							raise NoViableAltException(LT(1), getFilename())
					++_cnt109
				:_loop109_breakloop
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def block(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		rbrace as IToken  = null
		
		try:     // for error handling
			match(LBRACE)
			while true:
				if ((tokenSet_2_.member(cast(int, LA(1))))):
					compound_or_single_stmt(b)
				else:
					goto _loop104_breakloop
			:_loop104_breakloop
			rbrace = LT(1)
			match(RBRACE)
			if 0 == inputState.guessing:
				SetEndSourceLocation(b, rbrace) 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
	
	public def macro_application_test() as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			if ((tokenSet_42_.member(cast(int, LA(1)))) and (LA(2)==LBRACE)):
				member()
				match(LBRACE)
			elif ((tokenSet_42_.member(cast(int, LA(1)))) and (tokenSet_16_.member(cast(int, LA(2))))): // line 2102
				member()
				expression_list(null)
				match(LBRACE)
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_4_)
			else:
				raise
	
	public def macro_application_block(
		container as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		m = MacroStatement()
		args = m.Arguments
		b = m.Body
		
		try:     // for error handling
			macroName=member()
			synPredMatched148 as bool = false
			if ((LA(1)==LBRACE) and (tokenSet_13_.member(cast(int, LA(2))))):
				_m148 as int = mark()
				synPredMatched148 = true
				++inputState.guessing
				try:
					match(LBRACE)
				except x as RecognitionException:
					synPredMatched148 = false
				rewind(_m148)
				--inputState.guessing
			if synPredMatched148:
				compound_statement(b)
			elif ((tokenSet_16_.member(cast(int, LA(1)))) and (tokenSet_44_.member(cast(int, LA(2))))): // line 2102
				expression_list(args)
				compound_statement(b)
			else:
				raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				m.LexicalInfo = ToLexicalInfo(macroName)
				m.Name = macroName.getText()
				container.Add(m)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def builtin_statement(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == DO)
				 or (_givenValue ==FOR)
				 or (_givenValue ==IF)
				 or (_givenValue ==TRY)
				 or (_givenValue ==WHILE)
				 or (_givenValue ==SWITCH)
			): // 1827
				_givenValue  = LA(1)
				if ((_givenValue == DO)): // 1831
					do_while_statement(b)
				elif ((_givenValue == WHILE)): // 1831
					while_statement(b)
				elif ((_givenValue == FOR)): // 1831
					for_statement(b)
				elif ((_givenValue == IF)): // 1831
					if_statement(b)
				elif ((_givenValue == TRY)): // 1831
					try_statement(b)
				elif ((_givenValue == SWITCH)): // 1831
					switch_statement(b)
				else: // line 1969
						raise NoViableAltException(LT(1), getFilename())
			elif ((_givenValue == BREAK)
				 or (_givenValue ==CONTINUE)
				 or (_givenValue ==EACH)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==RETURN)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==THROW)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==VAR)
				 or (_givenValue ==YIELD)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				_givenValue  = LA(1)
				if ((_givenValue == EACH)
					 or (_givenValue ==FALSE)
					 or (_givenValue ==FUNCTION)
					 or (_givenValue ==NEW)
					 or (_givenValue ==NULL)
					 or (_givenValue ==SUPER)
					 or (_givenValue ==THIS)
					 or (_givenValue ==TRUE)
					 or (_givenValue ==TYPEOF)
					 or (_givenValue ==ID)
					 or (_givenValue ==DOUBLE_QUOTED_STRING)
					 or (_givenValue ==LBRACE)
					 or (_givenValue ==LPAREN)
					 or (_givenValue ==LBRACK)
					 or (_givenValue ==INCREMENT)
					 or (_givenValue ==DECREMENT)
					 or (_givenValue ==SUBTRACT)
					 or (_givenValue ==BITWISE_NOT)
					 or (_givenValue ==LOGICAL_NOT)
					 or (_givenValue ==RE_LITERAL)
					 or (_givenValue ==DOUBLE)
					 or (_givenValue ==INT)
					 or (_givenValue ==LONG)
					 or (_givenValue ==SINGLE_QUOTED_STRING)
				): // 1827
					expression_statement(b)
				elif ((_givenValue == YIELD)): // 1831
					yield_statement(b)
				elif ((_givenValue == RETURN)): // 1831
					return_statement(b)
				elif ((_givenValue == BREAK)): // 1831
					break_statement(b)
				elif ((_givenValue == CONTINUE)): // 1831
					continue_statement(b)
				elif ((_givenValue == THROW)): // 1831
					throw_statement(b)
				elif ((_givenValue == VAR)): // 1831
					declaration_statement(b)
				else: // line 1969
						raise NoViableAltException(LT(1), getFilename())
				eos()
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def do_while_statement(
		container as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		d as IToken  = null
		w as IToken  = null
		
		try:     // for error handling
			d = LT(1)
			match(DO)
			if 0 == inputState.guessing:
				ws = WhileStatement(ToLexicalInfo(d), Condition: BoolLiteralExpression(true))
				b = ws.Block
				container.Add(ws)
				EnterLoop(ws)
			block(b)
			w = LT(1)
			match(WHILE)
			e=paren_expression()
			eos()
			if 0 == inputState.guessing:
				b.Add(BreakStatement(ToLexicalInfo(w), Modifier: StatementModifier(StatementModifierType.Unless, e)))
				LeaveLoop(ws)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def while_statement(
		container as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		w as IToken  = null
		
		try:     // for error handling
			w = LT(1)
			match(WHILE)
			e=paren_expression()
			if 0 == inputState.guessing:
				ws = WhileStatement(ToLexicalInfo(w), Condition: e)
				b = ws.Block
				container.Add(ws)
				EnterLoop(ws)
			compound_or_single_stmt(b)
			if 0 == inputState.guessing:
				LeaveLoop(ws)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def for_statement(
		container as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		f as IToken  = null
		
		try:     // for error handling
			f = LT(1)
			match(FOR)
			_givenValue  = LA(1)
			if ((_givenValue == EACH)): // 1831
				match(EACH)
				match(LPAREN)
				stmt=for_in(container)
			elif ((_givenValue == LPAREN)): // 1831
				match(LPAREN)
				synPredMatched132 as bool = false
				if ((tokenSet_45_.member(cast(int, LA(1)))) and (tokenSet_46_.member(cast(int, LA(2))))):
					_m132 as int = mark()
					synPredMatched132 = true
					++inputState.guessing
					try:
						_givenValue  = LA(1)
						if ((_givenValue == EACH)
							 or (_givenValue ==FINAL)
							 or (_givenValue ==INTERNAL)
							 or (_givenValue ==ID)
						): // 1827
							identifier()
						elif ((_givenValue == VAR)): // 1831
							declaration()
						else: // line 1969
								raise NoViableAltException(LT(1), getFilename())
						match(IN)
					except x as RecognitionException:
						synPredMatched132 = false
					rewind(_m132)
					--inputState.guessing
				if synPredMatched132:
					stmt=for_in(container)
				elif ((tokenSet_47_.member(cast(int, LA(1)))) and (tokenSet_48_.member(cast(int, LA(2))))): // line 2102
					stmt=for_c(container)
				else:
					raise NoViableAltException(LT(1), getFilename())
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				stmt.LexicalInfo = ToLexicalInfo(f) if stmt is not null 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def if_statement(
		container as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		it as IToken  = null
		et as IToken  = null
		
		try:     // for error handling
			it = LT(1)
			match(IF)
			e=paren_expression()
			if 0 == inputState.guessing:
				s = IfStatement(ToLexicalInfo(it), Condition: e)
				b = s.TrueBlock = Block()
				container.Add(s)
			compound_or_single_stmt(b)
			if ((LA(1)==ELSE) and (tokenSet_2_.member(cast(int, LA(2))))):
				et = LT(1)
				match(ELSE)
				if 0 == inputState.guessing:
					b = s.FalseBlock = Block(ToLexicalInfo(et)) 
				compound_or_single_stmt(b)
			elif ((tokenSet_15_.member(cast(int, LA(1)))) and (tokenSet_20_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def try_statement(
		container as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		tt as IToken  = null
		ct as IToken  = null
		id as IToken  = null
		
		try:     // for error handling
			tt = LT(1)
			match(TRY)
			if 0 == inputState.guessing:
				s = TryStatement(ToLexicalInfo(tt))
				b = s.ProtectedBlock
				container.Add(s)
			compound_or_single_stmt(b)
			while true:
				if ((LA(1)==CATCH) and (LA(2)==LPAREN)):
					ct = LT(1)
					match(CATCH)
					match(LPAREN)
					id = LT(1)
					match(ID)
					_givenValue  = LA(1)
					if ((_givenValue == COLON)): // 1831
						match(COLON)
						tr=type_reference()
					elif ((_givenValue == RPAREN)): // 1831
						pass // 947
					else: // line 1969
							raise NoViableAltException(LT(1), getFilename())
					match(RPAREN)
					if 0 == inputState.guessing:
						tr = SimpleTypeReference(ToLexicalInfo(id), "System.Exception") if tr is null
						handler = ExceptionHandler(
									ToLexicalInfo(ct),
									Declaration: Declaration(ToLexicalInfo(id), Name: id.getText(), Type: tr))
						s.ExceptionHandlers.Add(handler)
						b = handler.Block
						tr = null
					compound_or_single_stmt(b)
				else:
					goto _loop167_breakloop
			:_loop167_breakloop
			if ((LA(1)==FINALLY) and (tokenSet_2_.member(cast(int, LA(2))))):
				finally_block(s)
			elif ((tokenSet_15_.member(cast(int, LA(1)))) and (tokenSet_20_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def switch_statement(
		container as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		s as IToken  = null
		c as IToken  = null
		fallthrough as IToken  = null
		d as IToken  = null
		
		try:     // for error handling
			s = LT(1)
			match(SWITCH)
			e=paren_expression()
			if 0 == inputState.guessing:
				switchMacro = MacroStatement(ToLexicalInfo(s), Name: MacroName(s.getText()))
				switchMacro.Arguments.Add(e)
				switchBlock = switchMacro.Body
				container.Add(switchMacro)
			match(LBRACE)
			while true:
				if ((LA(1)==CASE)):
					c = LT(1)
					match(CASE)
					e=expression()
					match(COLON)
					if 0 == inputState.guessing:
						item = MacroStatement(ToLexicalInfo(c), Name: c.getText())
						item.Arguments.Add(e)
						itemBlock = item.Body
						switchBlock.Add(item)
					while true:
						if ((LA(1)==CASE)):
							fallthrough = LT(1)
							match(CASE)
							e=expression()
							match(COLON)
							if 0 == inputState.guessing:
								item.Arguments.Add(e); 
						else:
							goto _loop155_breakloop
					:_loop155_breakloop
					_cnt157 as int = 0
					while true:
						if ((tokenSet_2_.member(cast(int, LA(1))))):
							statement(itemBlock)
						else:
							if (_cnt157 >= 1):
								goto _loop157_breakloop
							else:
								raise NoViableAltException(LT(1), getFilename())
						++_cnt157
					:_loop157_breakloop
				else:
					goto _loop158_breakloop
			:_loop158_breakloop
			_givenValue  = LA(1)
			if ((_givenValue == DEFAULT)): // 1831
				d = LT(1)
				match(DEFAULT)
				match(COLON)
				if 0 == inputState.guessing:
					item = MacroStatement(ToLexicalInfo(d), Name: d.getText())
					itemBlock = item.Body
					switchBlock.Add(item)
				_cnt161 as int = 0
				while true:
					if ((tokenSet_2_.member(cast(int, LA(1))))):
						statement(itemBlock)
					else:
						if (_cnt161 >= 1):
							goto _loop161_breakloop
						else:
							raise NoViableAltException(LT(1), getFilename())
					++_cnt161
				:_loop161_breakloop
			elif ((_givenValue == RBRACE)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			match(RBRACE)
			while true:
				if ((LA(1)==EOS) and (tokenSet_15_.member(cast(int, LA(2))))):
					match(EOS)
				else:
					goto _loop163_breakloop
			:_loop163_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def expression_statement(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			e=assignment_expression()
			if 0 == inputState.guessing:
				b.Add(ExpressionStatement(e)) 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def yield_statement(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		yt as IToken  = null
		
		try:     // for error handling
			yt = LT(1)
			match(YIELD)
			if ((tokenSet_16_.member(cast(int, LA(1)))) and (tokenSet_49_.member(cast(int, LA(2))))):
				e=expression()
			elif ((tokenSet_15_.member(cast(int, LA(1)))) and (tokenSet_20_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				b.Add(YieldStatement(ToLexicalInfo(yt), Expression: e)) 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def return_statement(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		ret as IToken  = null
		
		try:     // for error handling
			ret = LT(1)
			match(RETURN)
			if ((tokenSet_16_.member(cast(int, LA(1)))) and (tokenSet_49_.member(cast(int, LA(2))))):
				e=expression()
			elif ((tokenSet_15_.member(cast(int, LA(1)))) and (tokenSet_20_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				b.Add(ReturnStatement(ToLexicalInfo(ret), Expression: e)) 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def break_statement(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		t as IToken  = null
		
		try:     // for error handling
			t = LT(1)
			match(BREAK)
			if 0 == inputState.guessing:
				b.Add(BreakStatement(ToLexicalInfo(t))) 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def continue_statement(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		t as IToken  = null
		
		try:     // for error handling
			t = LT(1)
			match(CONTINUE)
			if 0 == inputState.guessing:
				gotoLabel = GetCurrentLoopLabel()
				if gotoLabel is not null:
					// we might be inside a c style for statement
					b.Add(GotoStatement(ToLexicalInfo(t), Label: ReferenceExpression(gotoLabel)))
				else:
					b.Add(ContinueStatement(ToLexicalInfo(t)))
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def throw_statement(
		b as Block 
	) as void: //throws RecognitionException, TokenStreamException
		
		t as IToken  = null
		
		try:     // for error handling
			t = LT(1)
			match(THROW)
			if ((tokenSet_16_.member(cast(int, LA(1)))) and (tokenSet_49_.member(cast(int, LA(2))))):
				e=expression()
			elif ((tokenSet_15_.member(cast(int, LA(1)))) and (tokenSet_20_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				b.Add(RaiseStatement(ToLexicalInfo(t), Exception: e)) 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def declaration() as Declaration : //throws RecognitionException, TokenStreamException
		d as Declaration 
		
		
		try:     // for error handling
			match(VAR)
			id=identifier()
			_givenValue  = LA(1)
			if ((_givenValue == COLON)): // 1831
				match(COLON)
				tr=type_reference()
			elif ((_givenValue == EOF)
				 or (_givenValue ==BREAK)
				 or (_givenValue ==CATCH)
				 or (_givenValue ==CLASS)
				 or (_givenValue ==CONTINUE)
				 or (_givenValue ==DO)
				 or (_givenValue ==ELSE)
				 or (_givenValue ==EACH)
				 or (_givenValue ==ENUM)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==FINALLY)
				 or (_givenValue ==FOR)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==GET)
				 or (_givenValue ==IF)
				 or (_givenValue ==IN)
				 or (_givenValue ==INTERFACE)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==RETURN)
				 or (_givenValue ==PUBLIC)
				 or (_givenValue ==PROTECTED)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==PARTIAL)
				 or (_givenValue ==PRIVATE)
				 or (_givenValue ==SET)
				 or (_givenValue ==STATIC)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==THROW)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TRY)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==VAR)
				 or (_givenValue ==VIRTUAL)
				 or (_givenValue ==WHILE)
				 or (_givenValue ==YIELD)
				 or (_givenValue ==SWITCH)
				 or (_givenValue ==CASE)
				 or (_givenValue ==DEFAULT)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==RBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==EOS)
				 or (_givenValue ==ASSIGN)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==AT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				d = Declaration(ToLexicalInfo(id), Name: id.getText(), Type: tr)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_50_)
			else:
				raise
		return d
	
	public def assignment_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		a as IToken  = null
		ipa as IToken  = null
		ips as IToken  = null
		ipm as IToken  = null
		ipd as IToken  = null
		ipbo as IToken  = null
		ipba as IToken  = null
		ipxo as IToken  = null
		ipsl as IToken  = null
		ipsr as IToken  = null
		
		try:     // for error handling
			e=conditional_expression()
			_givenValue  = LA(1)
			if ((_givenValue == INPLACE_DIVISION)
				 or (_givenValue ==INPLACE_ADD)
				 or (_givenValue ==INPLACE_SUBTRACT)
				 or (_givenValue ==INPLACE_MULTIPLY)
				 or (_givenValue ==INPLACE_BITWISE_OR)
				 or (_givenValue ==INPLACE_BITWISE_AND)
				 or (_givenValue ==ASSIGN)
				 or (_givenValue ==INPLACE_SHIFT_LEFT)
				 or (_givenValue ==INPLACE_SHIFT_RIGHT)
				 or (_givenValue ==INPLACE_BITWISE_XOR)
			): // 1827
				_givenValue  = LA(1)
				if ((_givenValue == ASSIGN)): // 1831
					a = LT(1)
					match(ASSIGN)
					if 0 == inputState.guessing:
						token = a; op = BinaryOperatorType.Assign 
				elif ((_givenValue == INPLACE_ADD)): // 1831
					ipa = LT(1)
					match(INPLACE_ADD)
					if 0 == inputState.guessing:
						token = ipa; op = BinaryOperatorType.InPlaceAddition 
				elif ((_givenValue == INPLACE_SUBTRACT)): // 1831
					ips = LT(1)
					match(INPLACE_SUBTRACT)
					if 0 == inputState.guessing:
						token = ips; op = BinaryOperatorType.InPlaceSubtraction 
				elif ((_givenValue == INPLACE_MULTIPLY)): // 1831
					ipm = LT(1)
					match(INPLACE_MULTIPLY)
					if 0 == inputState.guessing:
						token = ipm; op = BinaryOperatorType.InPlaceMultiply 
				elif ((_givenValue == INPLACE_DIVISION)): // 1831
					ipd = LT(1)
					match(INPLACE_DIVISION)
					if 0 == inputState.guessing:
						token = ipd; op = BinaryOperatorType.InPlaceDivision 
				elif ((_givenValue == INPLACE_BITWISE_OR)): // 1831
					ipbo = LT(1)
					match(INPLACE_BITWISE_OR)
					if 0 == inputState.guessing:
						token = ipbo; op = BinaryOperatorType.InPlaceBitwiseOr 
				elif ((_givenValue == INPLACE_BITWISE_AND)): // 1831
					ipba = LT(1)
					match(INPLACE_BITWISE_AND)
					if 0 == inputState.guessing:
						token = ipba; op = BinaryOperatorType.InPlaceBitwiseAnd 
				elif ((_givenValue == INPLACE_BITWISE_XOR)): // 1831
					ipxo = LT(1)
					match(INPLACE_BITWISE_XOR)
					if 0 == inputState.guessing:
						token = ipxo; op = BinaryOperatorType.InPlaceExclusiveOr 
				elif ((_givenValue == INPLACE_SHIFT_LEFT)): // 1831
					ipsl = LT(1)
					match(INPLACE_SHIFT_LEFT)
					if 0 == inputState.guessing:
						token = ipsl; op = BinaryOperatorType.InPlaceShiftLeft 
				elif ((_givenValue == INPLACE_SHIFT_RIGHT)): // 1831
					ipsr = LT(1)
					match(INPLACE_SHIFT_RIGHT)
					if 0 == inputState.guessing:
						token = ipsr; op = BinaryOperatorType.InPlaceShiftRight 
				else: // line 1969
						raise NoViableAltException(LT(1), getFilename())
				r=assignment_expression()
				if 0 == inputState.guessing:
					be = BinaryExpression(ToLexicalInfo(token))
					be.Operator = op
					be.Left = e
					be.Right = r
					e = be
			elif ((_givenValue == EOF)
				 or (_givenValue ==BREAK)
				 or (_givenValue ==CATCH)
				 or (_givenValue ==CLASS)
				 or (_givenValue ==CONTINUE)
				 or (_givenValue ==DO)
				 or (_givenValue ==ELSE)
				 or (_givenValue ==EACH)
				 or (_givenValue ==ENUM)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==FINALLY)
				 or (_givenValue ==FOR)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==GET)
				 or (_givenValue ==IF)
				 or (_givenValue ==INTERFACE)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==RETURN)
				 or (_givenValue ==PUBLIC)
				 or (_givenValue ==PROTECTED)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==PARTIAL)
				 or (_givenValue ==PRIVATE)
				 or (_givenValue ==SET)
				 or (_givenValue ==STATIC)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==THROW)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TRY)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==VAR)
				 or (_givenValue ==VIRTUAL)
				 or (_givenValue ==WHILE)
				 or (_givenValue ==YIELD)
				 or (_givenValue ==SWITCH)
				 or (_givenValue ==CASE)
				 or (_givenValue ==DEFAULT)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==RBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==RPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==EOS)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==AT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_51_)
			else:
				raise
		return e
	
	public def for_in(
		container as Block 
	) as Statement : //throws RecognitionException, TokenStreamException
		stmt as Statement 
		
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == EACH)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==ID)
			): // 1827
				id=identifier()
				if 0 == inputState.guessing:
					d = Declaration(ToLexicalInfo(id), Name: id.getText()) 
			elif ((_givenValue == VAR)): // 1831
				d=declaration()
				if 0 == inputState.guessing:
					DeclarationAnnotations.ForceNewVariable(d) 
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			match(IN)
			iterator=expression()
			if 0 == inputState.guessing:
				fs = ForStatement(Iterator: iterator)
				fs.Declarations.Add(d)
				b = fs.Block
				stmt = fs
				container.Add(stmt)
				EnterLoop(stmt)
			match(RPAREN)
			compound_or_single_stmt(b)
			if 0 == inputState.guessing:
				LeaveLoop(stmt)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
		return stmt
	
	public def for_c(
		container as Block 
	) as Statement : //throws RecognitionException, TokenStreamException
		stmt as Statement 
		
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == VAR)): // 1831
				declaration_statement(container)
				if 0 == inputState.guessing:
					stmt = container.Statements[-1] as DeclarationStatement
					stmt.Annotate("PrivateScope") if stmt is not null				
			elif ((_givenValue == EACH)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				expression_statement(container)
			elif ((_givenValue == EOS)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			match(EOS)
			_givenValue  = LA(1)
			if ((_givenValue == EACH)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				condition=expression()
			elif ((_givenValue == EOS)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			match(EOS)
			_givenValue  = LA(1)
			if ((_givenValue == EACH)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				update=assignment_expression()
			elif ((_givenValue == RPAREN)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				ws = WhileStatement(Condition: condition)
				if condition is null:
					ws.Condition = BoolLiteralExpression(Value: true)
				b = ws.Block
				stmt = ws
				// support for 'continue'
				label = SetUpLoopLabel(ws)
				container.Add(stmt)
				EnterLoop(ws)
			match(RPAREN)
			compound_or_single_stmt(b)
			if 0 == inputState.guessing:
				LeaveLoop(ws)
				if IsLabelInUse(ws):
					b.Add(LabelStatement(Name: label))
				b.Add(update) if update is not null
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
		return stmt
	
	public def member() as Token : //throws RecognitionException, TokenStreamException
		name as Token 
		
		id as IToken  = null
		st as IToken  = null
		gt as IToken  = null
		eh as IToken  = null
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == ID)): // 1831
				id = LT(1)
				match(ID)
				if 0 == inputState.guessing:
					name=id; 
			elif ((_givenValue == SET)): // 1831
				st = LT(1)
				match(SET)
				if 0 == inputState.guessing:
					name=st; 
			elif ((_givenValue == GET)): // 1831
				gt = LT(1)
				match(GET)
				if 0 == inputState.guessing:
					name=gt; 
			elif ((_givenValue == EACH)): // 1831
				eh = LT(1)
				match(EACH)
				if 0 == inputState.guessing:
					name=eh; 
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return name
	
	public def expression_list(
		ec as ExpressionCollection 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			if ((tokenSet_16_.member(cast(int, LA(1)))) and (tokenSet_17_.member(cast(int, LA(2))))):
				e=expression()
				if 0 == inputState.guessing:
					ec.Add(e); 
				while true:
					if ((LA(1)==COMMA)):
						match(COMMA)
						e=expression()
						if 0 == inputState.guessing:
							ec.Add(e); 
					else:
						goto _loop229_breakloop
				:_loop229_breakloop
			elif ((LA(1)==LBRACE or LA(1)==RPAREN or LA(1)==RBRACK) and (tokenSet_20_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_52_)
			else:
				raise
	
	public def paren_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		
		try:     // for error handling
			match(LPAREN)
			e=expression()
			match(RPAREN)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def finally_block(
		s as TryStatement 
	) as void: //throws RecognitionException, TokenStreamException
		
		ft as IToken  = null
		
		try:     // for error handling
			ft = LT(1)
			match(FINALLY)
			if 0 == inputState.guessing:
				finallyBlock = s.EnsureBlock = Block(ToLexicalInfo(ft))
			compound_or_single_stmt(finallyBlock)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_15_)
			else:
				raise
	
	public def conditional_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		qm as IToken  = null
		
		try:     // for error handling
			e=logical_or()
			if ((LA(1)==QUESTION_MARK) and (tokenSet_16_.member(cast(int, LA(2))))):
				qm = LT(1)
				match(QUESTION_MARK)
				trueValue=logical_or()
				match(COLON)
				falseValue=conditional_expression()
				if 0 == inputState.guessing:
					e = ConditionalExpression(ToLexicalInfo(qm),
							Condition: e,
							TrueValue: trueValue,
							FalseValue: falseValue)
			elif ((tokenSet_20_.member(cast(int, LA(1)))) and (tokenSet_28_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def simple_type_reference() as TypeReference : //throws RecognitionException, TokenStreamException
		tr as TypeReference 
		
		
		try:     // for error handling
			typeName=qname()
			if ((LA(1)==DOT) and (LA(2)==LESS_THAN)):
				match(DOT)
				match(LESS_THAN)
				if 0 == inputState.guessing:
					tr = gtr = GenericTypeReference(ToLexicalInfo(typeName), typeName.getText());
					arguments = gtr.GenericArguments
				type_reference_list(arguments)
				match(GREATER_THAN)
			elif ((tokenSet_35_.member(cast(int, LA(1)))) and (tokenSet_25_.member(cast(int, LA(2))))): // line 2102
				if 0 == inputState.guessing:
					tr = SimpleTypeReference(ToLexicalInfo(typeName), Name: typeName.getText())
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_35_)
			else:
				raise
		return tr
	
	public def anonymous_function_type() as TypeReference : //throws RecognitionException, TokenStreamException
		tr as TypeReference 
		
		fn as IToken  = null
		
		try:     // for error handling
			fn = LT(1)
			match(FUNCTION)
			if 0 == inputState.guessing:
				tr = callableTypeRef = CallableTypeReference(ToLexicalInfo(fn))
				parameters = callableTypeRef.Parameters
			function_type_parameters(parameters)
			if ((LA(1)==COLON) and (LA(2)==FUNCTION or LA(2)==ID)):
				match(COLON)
				returnType=type_reference()
				if 0 == inputState.guessing:
					callableTypeRef.ReturnType = returnType 
			elif ((tokenSet_35_.member(cast(int, LA(1)))) and (tokenSet_25_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_35_)
			else:
				raise
		return tr
	
	public def function_type_parameters(
		parameters as ParameterDeclarationCollection 
	) as void: //throws RecognitionException, TokenStreamException
		
		
		try:     // for error handling
			match(LPAREN)
			_givenValue  = LA(1)
			if ((_givenValue == FUNCTION)
				 or (_givenValue ==ID)
			): // 1827
				parameterType=type_reference()
				if 0 == inputState.guessing:
					parameters.Add(ParameterDeclaration(Type: parameterType, Name: "arg" + len(parameters))) 
				while true:
					if ((LA(1)==COMMA)):
						match(COMMA)
						parameterType=type_reference()
						if 0 == inputState.guessing:
							parameters.Add(ParameterDeclaration(Type: parameterType, Name: "arg" + len(parameters))) 
					else:
						goto _loop185_breakloop
				:_loop185_breakloop
			elif ((_givenValue == RPAREN)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			match(RPAREN)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_35_)
			else:
				raise
	
	public def array_initializer() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		dimensions = List of Expression(1)
		
		try:     // for error handling
			tr=simple_type_reference()
			match(LBRACK)
			size=sum()
			if 0 == inputState.guessing:
				dimensions.Add(size) 
			while true:
				if ((LA(1)==COMMA)):
					match(COMMA)
					size=sum()
					if 0 == inputState.guessing:
						dimensions.Add(size) 
				else:
					goto _loop188_breakloop
			:_loop188_breakloop
			match(RBRACK)
			if 0 == inputState.guessing:
				e = CodeFactory.NewArrayInitializer(tr.LexicalInfo, tr, dimensions)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def sum() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		add as IToken  = null
		sub as IToken  = null
		bOperator = BinaryOperatorType.None;
		
		try:     // for error handling
			e=term()
			while true:
				if ((LA(1)==ADD or LA(1)==SUBTRACT) and (tokenSet_16_.member(cast(int, LA(2))))):
					_givenValue  = LA(1)
					if ((_givenValue == ADD)): // 1831
						add = LT(1)
						match(ADD)
						if 0 == inputState.guessing:
							op=add; bOperator = BinaryOperatorType.Addition; 
					elif ((_givenValue == SUBTRACT)): // 1831
						sub = LT(1)
						match(SUBTRACT)
						if 0 == inputState.guessing:
							op=sub; bOperator = BinaryOperatorType.Subtraction; 
					else: // line 1969
							raise NoViableAltException(LT(1), getFilename())
					r=term()
					if 0 == inputState.guessing:
						be = BinaryExpression(ToLexicalInfo(op))
						be.Operator = bOperator
						be.Left = e
						be.Right = r
						e = be
				else:
					goto _loop263_breakloop
			:_loop263_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def new_array_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		
		try:     // for error handling
			match(NEW)
			e=array_initializer()
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def new_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		
		try:     // for error handling
			synPredMatched199 as bool = false
			if ((LA(1)==NEW) and (LA(2)==ID)):
				_m199 as int = mark()
				synPredMatched199 = true
				++inputState.guessing
				try:
					new_array_expression()
				except x as RecognitionException:
					synPredMatched199 = false
				rewind(_m199)
				--inputState.guessing
			if synPredMatched199:
				e=new_array_expression()
			elif ((LA(1)==NEW) and (LA(2)==EACH or LA(2)==ID)): // line 2102
				match(NEW)
				r=reference_expression()
				if 0 == inputState.guessing:
					e = mie = MethodInvocationExpression(r.LexicalInfo, Target: r)
					args = mie.Arguments
				match(LPAREN)
				expression_list(args)
				match(RPAREN)
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def atom() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == FALSE)
				 or (_givenValue ==NULL)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				e=literal()
			elif ((_givenValue == FUNCTION)): // 1831
				e=function_expression()
			elif ((_givenValue == EACH)
				 or (_givenValue ==ID)
			): // 1827
				e=simple_reference_expression()
			elif ((_givenValue == LPAREN)): // 1831
				e=paren_expression()
			elif ((_givenValue == NEW)): // 1831
				e=new_expression()
			elif ((_givenValue == TYPEOF)): // 1831
				e=typeof_expression()
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def literal() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == INT)
				 or (_givenValue ==LONG)
			): // 1827
				e=integer_literal()
			elif ((_givenValue == DOUBLE_QUOTED_STRING)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				e=string_literal()
			elif ((_givenValue == LBRACK)): // 1831
				e=array_literal()
			elif ((_givenValue == LBRACE)): // 1831
				e=hash_literal()
			elif ((_givenValue == RE_LITERAL)): // 1831
				e=re_literal()
			elif ((_givenValue == FALSE)
				 or (_givenValue ==TRUE)
			): // 1827
				e=bool_literal()
			elif ((_givenValue == NULL)): // 1831
				e=null_literal()
			elif ((_givenValue == THIS)): // 1831
				e=self_literal()
			elif ((_givenValue == SUPER)): // 1831
				e=super_literal()
			elif ((_givenValue == DOUBLE)): // 1831
				e=double_literal()
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def function_expression() as BlockExpression : //throws RecognitionException, TokenStreamException
		e as BlockExpression 
		
		fn as IToken  = null
		
		try:     // for error handling
			fn = LT(1)
			match(FUNCTION)
			if 0 == inputState.guessing:
				e = BlockExpression(ToLexicalInfo(fn))
				e.Annotate("inline");
				body = e.Body
			match(LPAREN)
			_givenValue  = LA(1)
			if ((_givenValue == EACH)
				 or (_givenValue ==FINAL)
				 or (_givenValue ==INTERNAL)
				 or (_givenValue ==ID)
				 or (_givenValue ==AT)
			): // 1827
				parameter_declaration_list(e)
			elif ((_givenValue == RPAREN)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			match(RPAREN)
			_givenValue  = LA(1)
			if ((_givenValue == COLON)): // 1831
				match(COLON)
				tr=type_reference()
				if 0 == inputState.guessing:
					e.ReturnType = tr; 
			elif ((_givenValue == EACH)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if ((LA(1)==LBRACE) and (tokenSet_13_.member(cast(int, LA(2))))):
				block(body)
			elif ((tokenSet_16_.member(cast(int, LA(1)))) and (tokenSet_20_.member(cast(int, LA(2))))): // line 2102
				returnValue=expression()
				if 0 == inputState.guessing:
					body.Add(returnValue) 
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def simple_reference_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		id as IToken  = null
		each as IToken  = null
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == ID)): // 1831
				id = LT(1)
				match(ID)
			elif ((_givenValue == EACH)): // 1831
				each = LT(1)
				match(EACH)
				if 0 == inputState.guessing:
					id = each 
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				e = ReferenceExpression(ToLexicalInfo(id), Name: id.getText()) 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def typeof_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		
		try:     // for error handling
			synPredMatched218 as bool = false
			if ((LA(1)==TYPEOF) and (tokenSet_16_.member(cast(int, LA(2))))):
				_m218 as int = mark()
				synPredMatched218 = true
				++inputState.guessing
				try:
					match(TYPEOF)
					match(LPAREN)
					expression()
					match(RPAREN)
				except x as RecognitionException:
					synPredMatched218 = false
				rewind(_m218)
				--inputState.guessing
			if synPredMatched218:
				e=typeof_with_expression()
			elif ((LA(1)==TYPEOF) and (tokenSet_16_.member(cast(int, LA(2))))): // line 2102
				e=typeof_expression_alt()
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def member_reference_expression(
		target as Expression 
	) as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		lbrack as IToken  = null
		e = target;
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == LESS_THAN)): // 1831
				lbrack = LT(1)
				match(LESS_THAN)
				if 0 == inputState.guessing:
					e = gre = GenericReferenceExpression(ToLexicalInfo(lbrack), Target: e)
					genericArguments = gre.GenericArguments
				type_reference_list(genericArguments)
				match(GREATER_THAN)
			elif ((_givenValue == EACH)
				 or (_givenValue ==GET)
				 or (_givenValue ==SET)
				 or (_givenValue ==ID)
			): // 1827
				memberName=member()
				if 0 == inputState.guessing:
					e = MemberReferenceExpression(ToLexicalInfo(memberName), Target: e, Name: memberName.getText())
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	protected def typeof_with_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		t as IToken  = null
		
		try:     // for error handling
			t = LT(1)
			match(TYPEOF)
			if ((LA(1)==LPAREN) and (tokenSet_16_.member(cast(int, LA(2))))):
				match(LPAREN)
				arg=expression()
				match(RPAREN)
			elif ((tokenSet_16_.member(cast(int, LA(1)))) and (tokenSet_20_.member(cast(int, LA(2))))): // line 2102
				arg=expression()
			else:
				raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				mie = MethodInvocationExpression(ToLexicalInfo(t));
				mie.Target = ReferenceExpression(ToLexicalInfo(t), Name: t.getText())
				mie.Arguments.Add(arg)
				e = mie
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	protected def typeof_expression_alt() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		
		try:     // for error handling
			synPredMatched221 as bool = false
			if ((LA(1)==TYPEOF) and (LA(2)==LPAREN)):
				_m221 as int = mark()
				synPredMatched221 = true
				++inputState.guessing
				try:
					match(TYPEOF)
					match(LPAREN)
					type_reference()
					match(RPAREN)
				except x as RecognitionException:
					synPredMatched221 = false
				rewind(_m221)
				--inputState.guessing
			if synPredMatched221:
				e=typeof_with_typeref()
			elif ((LA(1)==TYPEOF) and (tokenSet_16_.member(cast(int, LA(2))))): // line 2102
				e=typeof_with_expression()
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	protected def typeof_with_typeref() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		t as IToken  = null
		
		try:     // for error handling
			t = LT(1)
			match(TYPEOF)
			match(LPAREN)
			tr=type_reference()
			match(RPAREN)
			if 0 == inputState.guessing:
				e = TypeofExpression(ToLexicalInfo(t), tr); 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def slice(
		se as SlicingExpression 
	) as void: //throws RecognitionException, TokenStreamException
		
		begin as Expression
		end as Expression
		step as Expression
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == COLON)): // 1831
				match(COLON)
				if 0 == inputState.guessing:
					begin = OmittedExpression.Default; 
				_givenValue  = LA(1)
				if ((_givenValue == EACH)
					 or (_givenValue ==FALSE)
					 or (_givenValue ==FUNCTION)
					 or (_givenValue ==NEW)
					 or (_givenValue ==NULL)
					 or (_givenValue ==SUPER)
					 or (_givenValue ==THIS)
					 or (_givenValue ==TRUE)
					 or (_givenValue ==TYPEOF)
					 or (_givenValue ==ID)
					 or (_givenValue ==DOUBLE_QUOTED_STRING)
					 or (_givenValue ==LBRACE)
					 or (_givenValue ==LPAREN)
					 or (_givenValue ==LBRACK)
					 or (_givenValue ==INCREMENT)
					 or (_givenValue ==DECREMENT)
					 or (_givenValue ==SUBTRACT)
					 or (_givenValue ==BITWISE_NOT)
					 or (_givenValue ==LOGICAL_NOT)
					 or (_givenValue ==RE_LITERAL)
					 or (_givenValue ==DOUBLE)
					 or (_givenValue ==INT)
					 or (_givenValue ==LONG)
					 or (_givenValue ==SINGLE_QUOTED_STRING)
				): // 1827
					end=expression()
				elif ((_givenValue == COLON)): // 1831
					match(COLON)
					if 0 == inputState.guessing:
						end = OmittedExpression.Default; 
					step=expression()
				elif ((_givenValue == COMMA)
					 or (_givenValue ==RBRACK)
				): // 1827
					pass // 947
				else: // line 1969
						raise NoViableAltException(LT(1), getFilename())
			elif ((_givenValue == EACH)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				begin=expression()
				_givenValue  = LA(1)
				if ((_givenValue == COLON)): // 1831
					match(COLON)
					_givenValue  = LA(1)
					if ((_givenValue == EACH)
						 or (_givenValue ==FALSE)
						 or (_givenValue ==FUNCTION)
						 or (_givenValue ==NEW)
						 or (_givenValue ==NULL)
						 or (_givenValue ==SUPER)
						 or (_givenValue ==THIS)
						 or (_givenValue ==TRUE)
						 or (_givenValue ==TYPEOF)
						 or (_givenValue ==ID)
						 or (_givenValue ==DOUBLE_QUOTED_STRING)
						 or (_givenValue ==LBRACE)
						 or (_givenValue ==LPAREN)
						 or (_givenValue ==LBRACK)
						 or (_givenValue ==INCREMENT)
						 or (_givenValue ==DECREMENT)
						 or (_givenValue ==SUBTRACT)
						 or (_givenValue ==BITWISE_NOT)
						 or (_givenValue ==LOGICAL_NOT)
						 or (_givenValue ==RE_LITERAL)
						 or (_givenValue ==DOUBLE)
						 or (_givenValue ==INT)
						 or (_givenValue ==LONG)
						 or (_givenValue ==SINGLE_QUOTED_STRING)
					): // 1827
						end=expression()
					elif ((_givenValue == COLON)
						 or (_givenValue ==COMMA)
						 or (_givenValue ==RBRACK)
					): // 1827
						if 0 == inputState.guessing:
							end = OmittedExpression.Default; 
					else: // line 1969
							raise NoViableAltException(LT(1), getFilename())
					_givenValue  = LA(1)
					if ((_givenValue == COLON)): // 1831
						match(COLON)
						step=expression()
					elif ((_givenValue == COMMA)
						 or (_givenValue ==RBRACK)
					): // 1827
						pass // 947
					else: // line 1969
							raise NoViableAltException(LT(1), getFilename())
				elif ((_givenValue == COMMA)
					 or (_givenValue ==RBRACK)
				): // 1827
					pass // 947
				else: // line 1969
						raise NoViableAltException(LT(1), getFilename())
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				se.Indices.Add(Slice(begin, end, step))
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_53_)
			else:
				raise
	
	public def slicing_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		lbrack as IToken  = null
		lparen as IToken  = null
		se as SlicingExpression
		mce as MethodInvocationExpression
		args as ExpressionCollection
		
		try:     // for error handling
			e=atom()
			while true:
				if ((LA(1)==LBRACK) and (tokenSet_54_.member(cast(int, LA(2))))):
					lbrack = LT(1)
					match(LBRACK)
					if 0 == inputState.guessing:
						se = SlicingExpression(ToLexicalInfo(lbrack))				
						se.Target = e
						e = se
					slice(se)
					while true:
						if ((LA(1)==COMMA)):
							match(COMMA)
							slice(se)
						else:
							goto _loop245_breakloop
					:_loop245_breakloop
					match(RBRACK)
				elif ((LA(1)==DOT) and (tokenSet_55_.member(cast(int, LA(2))))): // line 2102
					match(DOT)
					e=member_reference_expression(e)
				elif ((LA(1)==LPAREN) and (tokenSet_22_.member(cast(int, LA(2))))): // line 2102
					lparen = LT(1)
					match(LPAREN)
					if 0 == inputState.guessing:
						mce = MethodInvocationExpression(ToLexicalInfo(lparen))
						mce.Target = e
						e = mce
						args = mce.Arguments
					expression_list(args)
					match(RPAREN)
				else:
					goto _loop248_breakloop
			:_loop248_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def postfix_unary_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		postinc as IToken  = null
		preinc as IToken  = null
		
		try:     // for error handling
			e=slicing_expression()
			if ((LA(1)==INCREMENT) and (tokenSet_20_.member(cast(int, LA(2))))):
				postinc = LT(1)
				match(INCREMENT)
				if 0 == inputState.guessing:
					token = postinc; operator = UnaryOperatorType.PostIncrement; 
			elif ((LA(1)==DECREMENT) and (tokenSet_20_.member(cast(int, LA(2))))): // line 2102
				preinc = LT(1)
				match(DECREMENT)
				if 0 == inputState.guessing:
					token = preinc; operator= UnaryOperatorType.PostDecrement; 
			elif ((tokenSet_20_.member(cast(int, LA(1)))) and (tokenSet_28_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				e = UnaryExpression(ToLexicalInfo(token), operator, e) if token is not null 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def unary_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		tc as IToken  = null
		c as IToken  = null
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==LOGICAL_NOT)
			): // 1827
				e=prefix_unary_expression()
			elif ((_givenValue == EACH)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				e=postfix_unary_expression()
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if ((LA(1)==AS) and (LA(2)==FUNCTION or LA(2)==ID)):
				tc = LT(1)
				match(AS)
				tr=type_reference()
				if 0 == inputState.guessing:
					e = TryCastExpression(ToLexicalInfo(tc), Target: e, Type: tr) 
			elif ((LA(1)==CAST) and (LA(2)==FUNCTION or LA(2)==ID)): // line 2102
				c = LT(1)
				match(CAST)
				tr=type_reference()
				if 0 == inputState.guessing:
					e = CastExpression(ToLexicalInfo(c), Target: e, Type: tr) 
			elif ((tokenSet_20_.member(cast(int, LA(1)))) and (tokenSet_28_.member(cast(int, LA(2))))): // line 2102
				pass // 947
			else:
				raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def prefix_unary_expression() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		sub as IToken  = null
		inc as IToken  = null
		dec as IToken  = null
		nt as IToken  = null
		oc as IToken  = null
		uOperator = UnaryOperatorType.None
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == SUBTRACT)): // 1831
				sub = LT(1)
				match(SUBTRACT)
				if 0 == inputState.guessing:
					op = sub; uOperator = UnaryOperatorType.UnaryNegation; 
			elif ((_givenValue == INCREMENT)): // 1831
				inc = LT(1)
				match(INCREMENT)
				if 0 == inputState.guessing:
					op = inc; uOperator = UnaryOperatorType.Increment; 
			elif ((_givenValue == DECREMENT)): // 1831
				dec = LT(1)
				match(DECREMENT)
				if 0 == inputState.guessing:
					op = dec; uOperator = UnaryOperatorType.Decrement; 
			elif ((_givenValue == LOGICAL_NOT)): // 1831
				nt = LT(1)
				match(LOGICAL_NOT)
				if 0 == inputState.guessing:
					op = nt; uOperator = UnaryOperatorType.LogicalNot; 
			elif ((_givenValue == BITWISE_NOT)): // 1831
				oc = LT(1)
				match(BITWISE_NOT)
				if 0 == inputState.guessing:
					op = oc; uOperator = UnaryOperatorType.OnesComplement; 
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			e=unary_expression()
			if 0 == inputState.guessing:
				e = UnaryExpression(ToLexicalInfo(op), uOperator, e) 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def term() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		m as IToken  = null
		d as IToken  = null
		md as IToken  = null
		op = BinaryOperatorType.None 
		
		try:     // for error handling
			e=unary_expression()
			while true:
				if ((LA(1)==MODULUS or LA(1)==MULTIPLY or LA(1)==DIVISION) and (tokenSet_16_.member(cast(int, LA(2))))):
					_givenValue  = LA(1)
					if ((_givenValue == MULTIPLY)): // 1831
						m = LT(1)
						match(MULTIPLY)
						if 0 == inputState.guessing:
							op=BinaryOperatorType.Multiply; token=m; 
					elif ((_givenValue == DIVISION)): // 1831
						d = LT(1)
						match(DIVISION)
						if 0 == inputState.guessing:
							op=BinaryOperatorType.Division; token=d; 
					elif ((_givenValue == MODULUS)): // 1831
						md = LT(1)
						match(MODULUS)
						if 0 == inputState.guessing:
							op=BinaryOperatorType.Modulus; token=md; 
					else: // line 1969
							raise NoViableAltException(LT(1), getFilename())
					r=unary_expression()
					if 0 == inputState.guessing:
						be = BinaryExpression(ToLexicalInfo(token))
						be.Operator = op
						be.Left = e
						be.Right = r
						e = be
				else:
					goto _loop259_breakloop
			:_loop259_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def shift() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		sl as IToken  = null
		sr as IToken  = null
		
		try:     // for error handling
			e=sum()
			while true:
				if ((LA(1)==SHIFT_LEFT or LA(1)==SHIFT_RIGHT) and (tokenSet_16_.member(cast(int, LA(2))))):
					_givenValue  = LA(1)
					if ((_givenValue == SHIFT_LEFT)): // 1831
						sl = LT(1)
						match(SHIFT_LEFT)
						if 0 == inputState.guessing:
							op = BinaryOperatorType.ShiftLeft; token = sl 
					elif ((_givenValue == SHIFT_RIGHT)): // 1831
						sr = LT(1)
						match(SHIFT_RIGHT)
						if 0 == inputState.guessing:
							op = BinaryOperatorType.ShiftRight; token = sr 
					else: // line 1969
							raise NoViableAltException(LT(1), getFilename())
					r=sum()
					if 0 == inputState.guessing:
						e = BinaryExpression(ToLexicalInfo(token), Operator: op, Left: e, Right: r)
				else:
					goto _loop267_breakloop
			:_loop267_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def comparison() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		tni as IToken  = null
		tin as IToken  = null
		tgt as IToken  = null
		tgte as IToken  = null
		tlt as IToken  = null
		tlte as IToken  = null
		tisa as IToken  = null
		r as Expression
		op = BinaryOperatorType.None;
		token as IToken
		
		try:     // for error handling
			e=shift()
			while true:
				if ((tokenSet_56_.member(cast(int, LA(1)))) and (tokenSet_57_.member(cast(int, LA(2))))):
					_givenValue  = LA(1)
					if ((_givenValue == IN)
						 or (_givenValue ==NOT)
						 or (_givenValue ==LESS_THAN)
						 or (_givenValue ==LESS_THAN_OR_EQUAL)
						 or (_givenValue ==GREATER_THAN)
						 or (_givenValue ==GREATER_THAN_OR_EQUAL)
					): // 1827
						_givenValue  = LA(1)
						if ((_givenValue == NOT)): // 1831
							tni = LT(1)
							match(NOT)
							match(IN)
							if 0 == inputState.guessing:
								op = BinaryOperatorType.NotMember; token = tni; 
						elif ((_givenValue == IN)): // 1831
							tin = LT(1)
							match(IN)
							if 0 == inputState.guessing:
								op = BinaryOperatorType.Member; token = tin; 
						elif ((_givenValue == GREATER_THAN)): // 1831
							tgt = LT(1)
							match(GREATER_THAN)
							if 0 == inputState.guessing:
								op = BinaryOperatorType.GreaterThan; token = tgt; 
						elif ((_givenValue == GREATER_THAN_OR_EQUAL)): // 1831
							tgte = LT(1)
							match(GREATER_THAN_OR_EQUAL)
							if 0 == inputState.guessing:
								op = BinaryOperatorType.GreaterThanOrEqual; token = tgte 
						elif ((_givenValue == LESS_THAN)): // 1831
							tlt = LT(1)
							match(LESS_THAN)
							if 0 == inputState.guessing:
								op = BinaryOperatorType.LessThan; token = tlt; 
						elif ((_givenValue == LESS_THAN_OR_EQUAL)): // 1831
							tlte = LT(1)
							match(LESS_THAN_OR_EQUAL)
							if 0 == inputState.guessing:
								op = BinaryOperatorType.LessThanOrEqual; token = tlte; 
						else: // line 1969
								raise NoViableAltException(LT(1), getFilename())
						r=shift()
					elif ((_givenValue == INSTANCEOF)): // 1831
						tisa = LT(1)
						match(INSTANCEOF)
						tr=type_reference()
						if 0 == inputState.guessing:
							op = BinaryOperatorType.TypeTest;
							token = tisa;
							r = TypeofExpression(tr.LexicalInfo, tr);
					else: // line 1969
							raise NoViableAltException(LT(1), getFilename())
					if 0 == inputState.guessing:
						be = BinaryExpression(ToLexicalInfo(token))
						be.Operator = op
						be.Left = e
						be.Right = r
						e = be
				else:
					goto _loop280_breakloop
			:_loop280_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def equality() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		te as IToken  = null
		ti as IToken  = null
		re as IToken  = null
		rie as IToken  = null
		
		try:     // for error handling
			e=comparison()
			while true:
				if ((tokenSet_58_.member(cast(int, LA(1)))) and (tokenSet_16_.member(cast(int, LA(2))))):
					_givenValue  = LA(1)
					if ((_givenValue == EQUALITY)): // 1831
						te = LT(1)
						match(EQUALITY)
						if 0 == inputState.guessing:
							op = BinaryOperatorType.Equality; token = te; 
					elif ((_givenValue == INEQUALITY)): // 1831
						ti = LT(1)
						match(INEQUALITY)
						if 0 == inputState.guessing:
							op = BinaryOperatorType.Inequality; token = ti 
					elif ((_givenValue == REFERENCE_EQUALITY)): // 1831
						re = LT(1)
						match(REFERENCE_EQUALITY)
						if 0 == inputState.guessing:
							op = BinaryOperatorType.ReferenceEquality; token = re 
					elif ((_givenValue == REFERENCE_INEQUALITY)): // 1831
						rie = LT(1)
						match(REFERENCE_INEQUALITY)
						if 0 == inputState.guessing:
							op = BinaryOperatorType.ReferenceInequality; token = rie 
					else: // line 1969
							raise NoViableAltException(LT(1), getFilename())
					r=comparison()
					if 0 == inputState.guessing:
						e = BinaryExpression(ToLexicalInfo(token), op, e, r) 
				else:
					goto _loop288_breakloop
			:_loop288_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def bitwise_and() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		token as IToken  = null
		
		try:     // for error handling
			e=equality()
			while true:
				if ((LA(1)==BITWISE_AND) and (tokenSet_16_.member(cast(int, LA(2))))):
					token = LT(1)
					match(BITWISE_AND)
					if 0 == inputState.guessing:
						op = BinaryOperatorType.BitwiseAnd; 
					r=equality()
					if 0 == inputState.guessing:
						e = BinaryExpression(ToLexicalInfo(token), Operator: op, Left: e, Right: r)
				else:
					goto _loop291_breakloop
			:_loop291_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def bitwise_xor() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		token as IToken  = null
		
		try:     // for error handling
			e=bitwise_and()
			while true:
				if ((LA(1)==BITWISE_XOR) and (tokenSet_16_.member(cast(int, LA(2))))):
					token = LT(1)
					match(BITWISE_XOR)
					if 0 == inputState.guessing:
						op = BinaryOperatorType.ExclusiveOr; 
					r=bitwise_and()
					if 0 == inputState.guessing:
						e = BinaryExpression(ToLexicalInfo(token), Operator: op, Left: e, Right: r)
				else:
					goto _loop294_breakloop
			:_loop294_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def bitwise_or() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		token as IToken  = null
		
		try:     // for error handling
			e=bitwise_xor()
			while true:
				if ((LA(1)==BITWISE_OR) and (tokenSet_16_.member(cast(int, LA(2))))):
					token = LT(1)
					match(BITWISE_OR)
					if 0 == inputState.guessing:
						op = BinaryOperatorType.BitwiseOr; 
					r=bitwise_xor()
					if 0 == inputState.guessing:
						e = BinaryExpression(ToLexicalInfo(token), Operator: op, Left: e, Right: r)
				else:
					goto _loop297_breakloop
			:_loop297_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def logical_and() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		op as IToken  = null
		
		try:     // for error handling
			e=bitwise_or()
			while true:
				if ((LA(1)==LOGICAL_AND) and (tokenSet_16_.member(cast(int, LA(2))))):
					op = LT(1)
					match(LOGICAL_AND)
					rhs=bitwise_or()
					if 0 == inputState.guessing:
						e=BinaryExpression(ToLexicalInfo(op),
									Operator: BinaryOperatorType.And,
									Left: e,
									Right: rhs)
				else:
					goto _loop300_breakloop
			:_loop300_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def logical_or() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		op as IToken  = null
		
		try:     // for error handling
			e=logical_and()
			while true:
				if ((LA(1)==LOGICAL_OR) and (tokenSet_16_.member(cast(int, LA(2))))):
					op = LT(1)
					match(LOGICAL_OR)
					rhs=logical_and()
					if 0 == inputState.guessing:
						e = BinaryExpression(ToLexicalInfo(op),
									Operator: BinaryOperatorType.Or,
									Left: e,
									Right: rhs)
				else:
					goto _loop303_breakloop
			:_loop303_breakloop
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def string_literal() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		dqs as IToken  = null
		sqs as IToken  = null
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == DOUBLE_QUOTED_STRING)): // 1831
				dqs = LT(1)
				match(DOUBLE_QUOTED_STRING)
				if 0 == inputState.guessing:
					s = dqs; 
			elif ((_givenValue == SINGLE_QUOTED_STRING)): // 1831
				sqs = LT(1)
				match(SINGLE_QUOTED_STRING)
				if 0 == inputState.guessing:
					s = sqs; 
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			if 0 == inputState.guessing:
				e = StringLiteralExpression(ToLexicalInfo(s), s.getText()) 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def array_literal() as Expression : //throws RecognitionException, TokenStreamException
		e as Expression 
		
		lbrack as IToken  = null
		
		try:     // for error handling
			lbrack = LT(1)
			match(LBRACK)
			synPredMatched311 as bool = false
			if ((tokenSet_16_.member(cast(int, LA(1)))) and (tokenSet_59_.member(cast(int, LA(2))))):
				_m311 as int = mark()
				synPredMatched311 = true
				++inputState.guessing
				try:
					expression()
					match(FOR)
				except x as RecognitionException:
					synPredMatched311 = false
				rewind(_m311)
				--inputState.guessing
			if synPredMatched311:
				projection=expression()
				match(FOR)
				match(LPAREN)
				_givenValue  = LA(1)
				if ((_givenValue == EACH)
					 or (_givenValue ==FINAL)
					 or (_givenValue ==INTERNAL)
					 or (_givenValue ==ID)
				): // 1827
					id=identifier()
				elif ((_givenValue == VAR)): // 1831
					variable=declaration()
				else: // line 1969
						raise NoViableAltException(LT(1), getFilename())
				match(IN)
				iterator=expression()
				match(RPAREN)
				_givenValue  = LA(1)
				if ((_givenValue == IF)): // 1831
					match(IF)
					filter=expression()
				elif ((_givenValue == RBRACK)): // 1831
					pass // 947
				else: // line 1969
						raise NoViableAltException(LT(1), getFilename())
				if 0 == inputState.guessing:
					if id is not null: variable = Declaration(ToLexicalInfo(id), Name: id.getText())
					e = CodeFactory.NewArrayComprehension(ToLexicalInfo(lbrack), projection, variable, iterator, filter)
			elif ((tokenSet_60_.member(cast(int, LA(1)))) and (tokenSet_20_.member(cast(int, LA(2))))): // line 2102
				if 0 == inputState.guessing:
					e = ale = ArrayLiteralExpression(ToLexicalInfo(lbrack)); items = ale.Items; 
				expression_list(items)
			else:
				raise NoViableAltException(LT(1), getFilename())
			match(RBRACK)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def hash_literal() as HashLiteralExpression : //throws RecognitionException, TokenStreamException
		dle as HashLiteralExpression 
		
		lbrace as IToken  = null
		pair as ExpressionPair
		
		try:     // for error handling
			lbrace = LT(1)
			match(LBRACE)
			if 0 == inputState.guessing:
				dle = HashLiteralExpression(ToLexicalInfo(lbrace)); 
			_givenValue  = LA(1)
			if ((_givenValue == EACH)
				 or (_givenValue ==FALSE)
				 or (_givenValue ==FUNCTION)
				 or (_givenValue ==NEW)
				 or (_givenValue ==NULL)
				 or (_givenValue ==SUPER)
				 or (_givenValue ==THIS)
				 or (_givenValue ==TRUE)
				 or (_givenValue ==TYPEOF)
				 or (_givenValue ==ID)
				 or (_givenValue ==DOUBLE_QUOTED_STRING)
				 or (_givenValue ==LBRACE)
				 or (_givenValue ==LPAREN)
				 or (_givenValue ==LBRACK)
				 or (_givenValue ==INCREMENT)
				 or (_givenValue ==DECREMENT)
				 or (_givenValue ==SUBTRACT)
				 or (_givenValue ==BITWISE_NOT)
				 or (_givenValue ==LOGICAL_NOT)
				 or (_givenValue ==RE_LITERAL)
				 or (_givenValue ==DOUBLE)
				 or (_givenValue ==INT)
				 or (_givenValue ==LONG)
				 or (_givenValue ==SINGLE_QUOTED_STRING)
			): // 1827
				pair=expression_pair()
				if 0 == inputState.guessing:
					dle.Items.Add(pair); 
				while true:
					if ((LA(1)==COMMA)):
						match(COMMA)
						pair=expression_pair()
						if 0 == inputState.guessing:
							dle.Items.Add(pair); 
					else:
						goto _loop319_breakloop
				:_loop319_breakloop
			elif ((_givenValue == RBRACE)): // 1831
				pass // 947
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
			match(RBRACE)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return dle
	
	public def re_literal() as RELiteralExpression : //throws RecognitionException, TokenStreamException
		re as RELiteralExpression 
		
		value as IToken  = null
		
		try:     // for error handling
			value = LT(1)
			match(RE_LITERAL)
			if 0 == inputState.guessing:
				re = RELiteralExpression(ToLexicalInfo(value), value.getText())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return re
	
	public def bool_literal() as BoolLiteralExpression : //throws RecognitionException, TokenStreamException
		e as BoolLiteralExpression 
		
		t as IToken  = null
		f as IToken  = null
		
		try:     // for error handling
			_givenValue  = LA(1)
			if ((_givenValue == TRUE)): // 1831
				t = LT(1)
				match(TRUE)
				if 0 == inputState.guessing:
					e = BoolLiteralExpression(ToLexicalInfo(t), Value: true)
			elif ((_givenValue == FALSE)): // 1831
				f = LT(1)
				match(FALSE)
				if 0 == inputState.guessing:
					e = BoolLiteralExpression(ToLexicalInfo(f), Value: false)
			else: // line 1969
					raise NoViableAltException(LT(1), getFilename())
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def null_literal() as NullLiteralExpression : //throws RecognitionException, TokenStreamException
		e as NullLiteralExpression 
		
		t as IToken  = null
		
		try:     // for error handling
			t = LT(1)
			match(NULL)
			if 0 == inputState.guessing:
				e = NullLiteralExpression(ToLexicalInfo(t))
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def self_literal() as SelfLiteralExpression : //throws RecognitionException, TokenStreamException
		e as SelfLiteralExpression 
		
		t as IToken  = null
		
		try:     // for error handling
			t = LT(1)
			match(THIS)
			if 0 == inputState.guessing:
				e = SelfLiteralExpression(ToLexicalInfo(t))
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def super_literal() as SuperLiteralExpression : //throws RecognitionException, TokenStreamException
		e as SuperLiteralExpression 
		
		t as IToken  = null
		
		try:     // for error handling
			t = LT(1)
			match(SUPER)
			if 0 == inputState.guessing:
				e = SuperLiteralExpression(ToLexicalInfo(t))
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return e
	
	public def double_literal() as DoubleLiteralExpression : //throws RecognitionException, TokenStreamException
		rle as DoubleLiteralExpression 
		
		value as IToken  = null
		
		try:     // for error handling
			value = LT(1)
			match(DOUBLE)
			if 0 == inputState.guessing:
				rle = CodeFactory.NewDoubleLiteralExpression(ToLexicalInfo(value), value.getText()) 
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_20_)
			else:
				raise
		return rle
	
	public def expression_pair() as ExpressionPair : //throws RecognitionException, TokenStreamException
		ep as ExpressionPair 
		
		t as IToken  = null
		
		try:     // for error handling
			key=expression()
			t = LT(1)
			match(COLON)
			value=expression()
			if 0 == inputState.guessing:
				ep = ExpressionPair(ToLexicalInfo(t), key, value)
		except ex as RecognitionException:
			if (0 == inputState.guessing):
				reportError(ex)
				recover(ex,tokenSet_40_)
			else:
				raise
		return ep
	
	
	public static final tokenNames_ = (
		'<0>',
		'EOF',
		'<2>',
		'NULL_TREE_LOOKAHEAD',
		'as',
		'break',
		'cast',
		'catch',
		'class',
		'continue',
		'do',
		'else',
		'each',
		'enum',
		'extends',
		'false',
		'final',
		'finally',
		'for',
		'function',
		'get',
		'if',
		'import',
		'implements',
		'in',
		'interface',
		'instanceof',
		'new',
		'not',
		'null',
		'return',
		'public',
		'protected',
		'internal',
		'override',
		'partial',
		'private',
		'set',
		'static',
		'super',
		'this',
		'throw',
		'true',
		'try',
		'typeof',
		'var',
		'virtual',
		'while',
		'yield',
		'switch',
		'case',
		'default',
		'/=',
		'+=',
		'-=',
		'*=',
		'//',
		'pragma on',
		'pragma off',
		'an identifier',
		'a string',
		'{',
		'}',
		'(',
		')',
		'.',
		':',
		',',
		'[',
		']',
		'|',
		'|=',
		'&',
		'^',
		'&=',
		'||',
		'&&',
		';',
		'=',
		'++',
		'--',
		'+',
		'-',
		'%',
		'*',
		'==',
		'!=',
		'?',
		'~',
		'===',
		'!==',
		'<',
		'<=',
		'<<',
		'<<=',
		'>',
		'>=',
		'>>',
		'>>=',
		'@',
		'@script',
		'@assembly',
		'INPLACE_BITWISE_XOR',
		'LOGICAL_NOT',
		'DIVISION',
		'RE_LITERAL',
		'DOUBLE',
		'INT',
		'LONG',
		'SINGLE_QUOTED_STRING',
		'DOUBLE_SUFFIX',
		'EXPONENT',
		'PRAGMA_WHITE_SPACE',
		'WHITE_SPACE',
		'DQS_ESC',
		'SQS_ESC',
		'SESC',
		'ML_COMMENT',
		'RE_CHAR',
		'RE_ESC',
		'NEWLINE',
		'ID_LETTER',
		'DIGIT',
		'HEXDIGIT',
	)
	
	private static def mk_tokenSet_0_() as (long):
		data = (105946139926784L, 0L, )
		return data
	public static final tokenSet_0_ = BitSet(mk_tokenSet_0_())
	private static def mk_tokenSet_1_() as (long):
		data = (576566835883356416L, 0L, )
		return data
	public static final tokenSet_1_ = BitSet(mk_tokenSet_1_())
	private static def mk_tokenSet_2_() as (long):
		data = (-5187091650136205792L, 68719493881872L, 0L, 0L, )
		return data
	public static final tokenSet_2_ = BitSet(mk_tokenSet_2_())
	private static def mk_tokenSet_3_() as (long):
		data = (-507780875178625166L, 70162585747442L, 0L, 0L, )
		return data
	public static final tokenSet_3_ = BitSet(mk_tokenSet_3_())
	private static def mk_tokenSet_4_() as (long):
		data = (2L, 0L, )
		return data
	public static final tokenSet_4_ = BitSet(mk_tokenSet_4_())
	private static def mk_tokenSet_5_() as (long):
		data = (-4754675324137130206L, 68753853620240L, 0L, 0L, )
		return data
	public static final tokenSet_5_ = BitSet(mk_tokenSet_5_())
	private static def mk_tokenSet_6_() as (long):
		data = (576566715757441280L, 0L, )
		return data
	public static final tokenSet_6_ = BitSet(mk_tokenSet_6_())
	private static def mk_tokenSet_7_() as (long):
		data = (105911746101248L, 0L, )
		return data
	public static final tokenSet_7_ = BitSet(mk_tokenSet_7_())
	private static def mk_tokenSet_8_() as (long):
		data = (576566664049528832L, 0L, )
		return data
	public static final tokenSet_8_ = BitSet(mk_tokenSet_8_())
	private static def mk_tokenSet_9_() as (long):
		data = (576460760893427712L, 0L, )
		return data
	public static final tokenSet_9_ = BitSet(mk_tokenSet_9_())
	private static def mk_tokenSet_10_() as (long):
		data = (70761767837952L, 0L, )
		return data
	public static final tokenSet_10_ = BitSet(mk_tokenSet_10_())
	private static def mk_tokenSet_11_() as (long):
		data = (576531651511267584L, 0L, )
		return data
	public static final tokenSet_11_ = BitSet(mk_tokenSet_11_())
	private static def mk_tokenSet_12_() as (long):
		data = (-5187020888368892126L, 68753853620240L, 0L, 0L, )
		return data
	public static final tokenSet_12_ = BitSet(mk_tokenSet_12_())
	private static def mk_tokenSet_13_() as (long):
		data = (-575405631708817888L, 68719493881872L, 0L, 0L, )
		return data
	public static final tokenSet_13_ = BitSet(mk_tokenSet_13_())
	private static def mk_tokenSet_14_() as (long):
		data = (-504403175457964046L, 70162585747442L, 0L, 0L, )
		return data
	public static final tokenSet_14_ = BitSet(mk_tokenSet_14_())
	private static def mk_tokenSet_15_() as (long):
		data = (-571957170220843102L, 68753853620240L, 0L, 0L, )
		return data
	public static final tokenSet_15_ = BitSet(mk_tokenSet_15_())
	private static def mk_tokenSet_16_() as (long):
		data = (-5188123130559164416L, 68719493873680L, 0L, 0L, )
		return data
	public static final tokenSet_16_ = BitSet(mk_tokenSet_16_())
	private static def mk_tokenSet_17_() as (long):
		data = (-576437111779454896L, 69835094465403L, 0L, 0L, )
		return data
	public static final tokenSet_17_ = BitSet(mk_tokenSet_17_())
	private static def mk_tokenSet_18_() as (long):
		data = (0L, 9L, 0L, 0L, )
		return data
	public static final tokenSet_18_ = BitSet(mk_tokenSet_18_())
	private static def mk_tokenSet_19_() as (long):
		data = (-9223372036854775808L, 16384L, 0L, 0L, )
		return data
	public static final tokenSet_19_ = BitSet(mk_tokenSet_19_())
	private static def mk_tokenSet_20_() as (long):
		data = (-504403158278094862L, 70162585747455L, 0L, 0L, )
		return data
	public static final tokenSet_20_ = BitSet(mk_tokenSet_20_())
	private static def mk_tokenSet_21_() as (long):
		data = (576566715757441280L, 34359738368L, 0L, 0L, )
		return data
	public static final tokenSet_21_ = BitSet(mk_tokenSet_21_())
	private static def mk_tokenSet_22_() as (long):
		data = (-5188123130559164416L, 68719493873681L, 0L, 0L, )
		return data
	public static final tokenSet_22_ = BitSet(mk_tokenSet_22_())
	private static def mk_tokenSet_23_() as (long):
		data = (-4754675306957261022L, 68753853620240L, 0L, 0L, )
		return data
	public static final tokenSet_23_ = BitSet(mk_tokenSet_23_())
	private static def mk_tokenSet_24_() as (long):
		data = (-75435293766994062L, 70162585747455L, 0L, 0L, )
		return data
	public static final tokenSet_24_ = BitSet(mk_tokenSet_24_())
	private static def mk_tokenSet_25_() as (long):
		data = (-72057594037944334L, 70162585747455L, 0L, 0L, )
		return data
	public static final tokenSet_25_ = BitSet(mk_tokenSet_25_())
	private static def mk_tokenSet_26_() as (long):
		data = (35218765914368L, 0L, )
		return data
	public static final tokenSet_26_ = BitSet(mk_tokenSet_26_())
	private static def mk_tokenSet_27_() as (long):
		data = (-139611588809211998L, 68753853620240L, 0L, 0L, )
		return data
	public static final tokenSet_27_ = BitSet(mk_tokenSet_27_())
	private static def mk_tokenSet_28_() as (long):
		data = (-72057594046332942L, 70162585747455L, 0L, 0L, )
		return data
	public static final tokenSet_28_ = BitSet(mk_tokenSet_28_())
	private static def mk_tokenSet_29_() as (long):
		data = (105963454013696L, 34359738368L, 0L, 0L, )
		return data
	public static final tokenSet_29_ = BitSet(mk_tokenSet_29_())
	private static def mk_tokenSet_30_() as (long):
		data = (105963454013696L, 0L, )
		return data
	public static final tokenSet_30_ = BitSet(mk_tokenSet_30_())
	private static def mk_tokenSet_31_() as (long):
		data = (576566853197443328L, 0L, )
		return data
	public static final tokenSet_31_ = BitSet(mk_tokenSet_31_())
	private static def mk_tokenSet_32_() as (long):
		data = (576460898333430016L, 0L, )
		return data
	public static final tokenSet_32_ = BitSet(mk_tokenSet_32_())
	private static def mk_tokenSet_33_() as (long):
		data = (-575334852761635038L, 68753853620240L, 0L, 0L, )
		return data
	public static final tokenSet_33_ = BitSet(mk_tokenSet_33_())
	private static def mk_tokenSet_34_() as (long):
		data = (576460760893427712L, 34359738368L, 0L, 0L, )
		return data
	public static final tokenSet_34_ = BitSet(mk_tokenSet_34_())
	private static def mk_tokenSet_35_() as (long):
		data = (-504403158269706254L, 70162585747455L, 0L, 0L, )
		return data
	public static final tokenSet_35_ = BitSet(mk_tokenSet_35_())
	private static def mk_tokenSet_36_() as (long):
		data = (2305843009213693952L, 2147483648L, 0L, 0L, )
		return data
	public static final tokenSet_36_ = BitSet(mk_tokenSet_36_())
	private static def mk_tokenSet_37_() as (long):
		data = (4611686018427912192L, 34359738368L, 0L, 0L, )
		return data
	public static final tokenSet_37_ = BitSet(mk_tokenSet_37_())
	private static def mk_tokenSet_38_() as (long):
		data = (-571957153024196702L, 68753853636637L, 0L, 0L, )
		return data
	public static final tokenSet_38_ = BitSet(mk_tokenSet_38_())
	private static def mk_tokenSet_39_() as (long):
		data = (0L, 1L, 0L, 0L, )
		return data
	public static final tokenSet_39_ = BitSet(mk_tokenSet_39_())
	private static def mk_tokenSet_40_() as (long):
		data = (4611686018427387904L, 8L, 0L, 0L, )
		return data
	public static final tokenSet_40_ = BitSet(mk_tokenSet_40_())
	private static def mk_tokenSet_41_() as (long):
		data = (-571957153040973918L, 68753853620240L, 0L, 0L, )
		return data
	public static final tokenSet_41_ = BitSet(mk_tokenSet_41_())
	private static def mk_tokenSet_42_() as (long):
		data = (576460889743429632L, 0L, )
		return data
	public static final tokenSet_42_ = BitSet(mk_tokenSet_42_())
	private static def mk_tokenSet_43_() as (long):
		data = (-5187091787576207840L, 68719493873680L, 0L, 0L, )
		return data
	public static final tokenSet_43_ = BitSet(mk_tokenSet_43_())
	private static def mk_tokenSet_44_() as (long):
		data = (-575405631356496272L, 69835094473594L, 0L, 0L, )
		return data
	public static final tokenSet_44_ = BitSet(mk_tokenSet_44_())
	private static def mk_tokenSet_45_() as (long):
		data = (576495945265516544L, 0L, )
		return data
	public static final tokenSet_45_ = BitSet(mk_tokenSet_45_())
	private static def mk_tokenSet_46_() as (long):
		data = (576460760910204928L, 0L, )
		return data
	public static final tokenSet_46_ = BitSet(mk_tokenSet_46_())
	private static def mk_tokenSet_47_() as (long):
		data = (-5188087946187075584L, 68719493881872L, 0L, 0L, )
		return data
	public static final tokenSet_47_ = BitSet(mk_tokenSet_47_())
	private static def mk_tokenSet_48_() as (long):
		data = (-508883108778897328L, 70128226009074L, 0L, 0L, )
		return data
	public static final tokenSet_48_ = BitSet(mk_tokenSet_48_())
	private static def mk_tokenSet_49_() as (long):
		data = (-571957169868521486L, 69869454211954L, 0L, 0L, )
		return data
	public static final tokenSet_49_ = BitSet(mk_tokenSet_49_())
	private static def mk_tokenSet_50_() as (long):
		data = (-571957170204065886L, 68753853636624L, 0L, 0L, )
		return data
	public static final tokenSet_50_ = BitSet(mk_tokenSet_50_())
	private static def mk_tokenSet_51_() as (long):
		data = (-571957170220843102L, 68753853620241L, 0L, 0L, )
		return data
	public static final tokenSet_51_ = BitSet(mk_tokenSet_51_())
	private static def mk_tokenSet_52_() as (long):
		data = (2305843009213693952L, 33L, 0L, 0L, )
		return data
	public static final tokenSet_52_ = BitSet(mk_tokenSet_52_())
	private static def mk_tokenSet_53_() as (long):
		data = (0L, 40L, 0L, 0L, )
		return data
	public static final tokenSet_53_ = BitSet(mk_tokenSet_53_())
	private static def mk_tokenSet_54_() as (long):
		data = (-5188123130559164416L, 68719493873684L, 0L, 0L, )
		return data
	public static final tokenSet_54_ = BitSet(mk_tokenSet_54_())
	private static def mk_tokenSet_55_() as (long):
		data = (576460889743429632L, 134217728L, 0L, 0L, )
		return data
	public static final tokenSet_55_ = BitSet(mk_tokenSet_55_())
	private static def mk_tokenSet_56_() as (long):
		data = (352321536L, 6845104128L, 0L, 0L, )
		return data
	public static final tokenSet_56_ = BitSet(mk_tokenSet_56_())
	private static def mk_tokenSet_57_() as (long):
		data = (-5188123130542387200L, 68719493873680L, 0L, 0L, )
		return data
	public static final tokenSet_57_ = BitSet(mk_tokenSet_57_())
	private static def mk_tokenSet_58_() as (long):
		data = (0L, 106954752L, 0L, 0L, )
		return data
	public static final tokenSet_58_ = BitSet(mk_tokenSet_58_())
	private static def mk_tokenSet_59_() as (long):
		data = (-576437111779192752L, 69835094465394L, 0L, 0L, )
		return data
	public static final tokenSet_59_ = BitSet(mk_tokenSet_59_())
	private static def mk_tokenSet_60_() as (long):
		data = (-5188123130559164416L, 68719493873712L, 0L, 0L, )
		return data
	public static final tokenSet_60_ = BitSet(mk_tokenSet_60_())
	
