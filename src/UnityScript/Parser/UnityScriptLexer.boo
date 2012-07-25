// $ANTLR 2.7.5 (20050517): "src/UnityScript/UnityScript.g" -> "UnityScriptLexer.boo"$

namespace UnityScript.Parser
// Generate header specific to lexer Boo file
import System
import System.IO.Stream as Stream
import System.IO.TextReader as TextReader
import System.Collections.Hashtable as Hashtable
import System.Collections.Comparer as Comparer

import antlr.TokenStreamException as TokenStreamException
import antlr.TokenStreamIOException as TokenStreamIOException
import antlr.TokenStreamRecognitionException as TokenStreamRecognitionException
import antlr.CharStreamException as CharStreamException
import antlr.CharStreamIOException as CharStreamIOException
import antlr.ANTLRException as ANTLRException
import antlr.CharScanner as CharScanner
import antlr.InputBuffer as InputBuffer
import antlr.ByteBuffer as ByteBuffer
import antlr.CharBuffer as CharBuffer
import antlr.Token as Token
import antlr.IToken as IToken
import antlr.CommonToken as CommonToken
import antlr.SemanticException as SemanticException
import antlr.RecognitionException as RecognitionException
import antlr.NoViableAltForCharException as NoViableAltForCharException
import antlr.MismatchedCharException as MismatchedCharException
import antlr.TokenStream as TokenStream
import antlr.LexerSharedInputState as LexerSharedInputState
import antlr.collections.impl.BitSet as BitSet

class UnityScriptLexer(antlr.CharScanner, TokenStream):
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
	
	
	property PreserveComments = false
	
	static def IsDigit(ch as char):
		return ch >= char('0') and ch <= char('9')
	def constructor(ins as Stream):
		self(ByteBuffer(ins))
	
	def constructor(r as TextReader):
		self(CharBuffer(r))
	
	def constructor(ib as InputBuffer):
		self(LexerSharedInputState(ib))
	
	def constructor(state as LexerSharedInputState):
		super(state)
		initialize()
	
	private def initialize():
		caseSensitiveLiterals = true
		setCaseSensitive(true)
		literals = Hashtable(100, 0.4, null, Comparer.Default)
		literals.Add(",", 67)
		literals.Add("public", 31)
		literals.Add("a string", 60)
		literals.Add("an identifier", 59)
		literals.Add("]", 69)
		literals.Add("case", 50)
		literals.Add("break", 5)
		literals.Add("while", 47)
		literals.Add("new", 27)
		literals.Add("||", 75)
		literals.Add("+", 81)
		literals.Add("instanceof", 26)
		literals.Add("implements", 23)
		literals.Add("*", 84)
		literals.Add("|=", 71)
		literals.Add("typeof", 44)
		literals.Add("@assembly", 101)
		literals.Add("[", 68)
		literals.Add(">>=", 98)
		literals.Add("not", 28)
		literals.Add("return", 30)
		literals.Add("throw", 41)
		literals.Add("var", 45)
		literals.Add(")", 64)
		literals.Add("==", 85)
		literals.Add("null", 29)
		literals.Add("protected", 32)
		literals.Add("pragma off", 58)
		literals.Add("@script", 100)
		literals.Add("class", 8)
		literals.Add("(", 63)
		literals.Add("do", 10)
		literals.Add("~", 88)
		literals.Add("function", 19)
		literals.Add("/=", 52)
		literals.Add("super", 39)
		literals.Add("each", 12)
		literals.Add("@", 99)
		literals.Add("-=", 54)
		literals.Add("set", 37)
		literals.Add("+=", 53)
		literals.Add("!==", 90)
		literals.Add("}", 62)
		literals.Add("interface", 25)
		literals.Add("?", 87)
		literals.Add("&", 72)
		literals.Add("internal", 33)
		literals.Add("final", 16)
		literals.Add("yield", 48)
		literals.Add("!=", 86)
		literals.Add("//", 56)
		literals.Add("===", 89)
		literals.Add("if", 21)
		literals.Add("|", 70)
		literals.Add("override", 34)
		literals.Add(">", 95)
		literals.Add("as", 4)
		literals.Add("%", 83)
		literals.Add("catch", 7)
		literals.Add("try", 43)
		literals.Add("{", 61)
		literals.Add("=", 78)
		literals.Add("enum", 13)
		literals.Add("for", 18)
		literals.Add(">>", 97)
		literals.Add("extends", 14)
		literals.Add("private", 36)
		literals.Add("default", 51)
		literals.Add("--", 80)
		literals.Add("<", 91)
		literals.Add("false", 15)
		literals.Add("this", 40)
		literals.Add("static", 38)
		literals.Add(">=", 96)
		literals.Add("<=", 92)
		literals.Add("partial", 35)
		literals.Add(";", 77)
		literals.Add("get", 20)
		literals.Add("<<=", 94)
		literals.Add("continue", 9)
		literals.Add("&&", 76)
		literals.Add("cast", 6)
		literals.Add("<<", 93)
		literals.Add("pragma on", 57)
		literals.Add(".", 65)
		literals.Add("finally", 17)
		literals.Add("else", 11)
		literals.Add("import", 22)
		literals.Add("++", 79)
		literals.Add(":", 66)
		literals.Add("in", 24)
		literals.Add("switch", 49)
		literals.Add("true", 42)
		literals.Add("-", 82)
		literals.Add("*=", 55)
		literals.Add("virtual", 46)
		literals.Add("^", 73)
		literals.Add("&=", 74)
	
	override def nextToken() as IToken:
		theRetToken as IToken
		:tryAgain
		while true:
			_token as IToken = null
			_ttype = Token.INVALID_TYPE
			resetText()
			try:     // for char stream error handling
				try:    // for lexical error handling
					_givenValue  = cached_LA1
					if ((_givenValue == char('A'))
						 or (_givenValue ==char('B'))
						 or (_givenValue ==char('C'))
						 or (_givenValue ==char('D'))
						 or (_givenValue ==char('E'))
						 or (_givenValue ==char('F'))
						 or (_givenValue ==char('G'))
						 or (_givenValue ==char('H'))
						 or (_givenValue ==char('I'))
						 or (_givenValue ==char('J'))
						 or (_givenValue ==char('K'))
						 or (_givenValue ==char('L'))
						 or (_givenValue ==char('M'))
						 or (_givenValue ==char('N'))
						 or (_givenValue ==char('O'))
						 or (_givenValue ==char('P'))
						 or (_givenValue ==char('Q'))
						 or (_givenValue ==char('R'))
						 or (_givenValue ==char('S'))
						 or (_givenValue ==char('T'))
						 or (_givenValue ==char('U'))
						 or (_givenValue ==char('V'))
						 or (_givenValue ==char('W'))
						 or (_givenValue ==char('X'))
						 or (_givenValue ==char('Y'))
						 or (_givenValue ==char('Z'))
						 or (_givenValue ==char('_'))
						 or (_givenValue ==char('a'))
						 or (_givenValue ==char('b'))
						 or (_givenValue ==char('c'))
						 or (_givenValue ==char('d'))
						 or (_givenValue ==char('e'))
						 or (_givenValue ==char('f'))
						 or (_givenValue ==char('g'))
						 or (_givenValue ==char('h'))
						 or (_givenValue ==char('i'))
						 or (_givenValue ==char('j'))
						 or (_givenValue ==char('k'))
						 or (_givenValue ==char('l'))
						 or (_givenValue ==char('m'))
						 or (_givenValue ==char('n'))
						 or (_givenValue ==char('o'))
						 or (_givenValue ==char('p'))
						 or (_givenValue ==char('q'))
						 or (_givenValue ==char('r'))
						 or (_givenValue ==char('s'))
						 or (_givenValue ==char('t'))
						 or (_givenValue ==char('u'))
						 or (_givenValue ==char('v'))
						 or (_givenValue ==char('w'))
						 or (_givenValue ==char('x'))
						 or (_givenValue ==char('y'))
						 or (_givenValue ==char('z'))
					): // 1827
						mID(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('0'))
						 or (_givenValue ==char('1'))
						 or (_givenValue ==char('2'))
						 or (_givenValue ==char('3'))
						 or (_givenValue ==char('4'))
						 or (_givenValue ==char('5'))
						 or (_givenValue ==char('6'))
						 or (_givenValue ==char('7'))
						 or (_givenValue ==char('8'))
						 or (_givenValue ==char('9'))
					): // 1827
						mINT(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('.'))): // 1831
						mDOT(true)
						theRetToken = returnToken_
					elif ((_givenValue == char(':'))): // 1831
						mCOLON(true)
						theRetToken = returnToken_
					elif ((_givenValue == char(','))): // 1831
						mCOMMA(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('('))): // 1831
						mLPAREN(true)
						theRetToken = returnToken_
					elif ((_givenValue == char(')'))): // 1831
						mRPAREN(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('['))): // 1831
						mLBRACK(true)
						theRetToken = returnToken_
					elif ((_givenValue == char(']'))): // 1831
						mRBRACK(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('{'))): // 1831
						mLBRACE(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('}'))): // 1831
						mRBRACE(true)
						theRetToken = returnToken_
					elif ((_givenValue == char(';'))): // 1831
						mEOS(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('#'))): // 1831
						mPRAGMA_ON(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('%'))): // 1831
						mMODULUS(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('?'))): // 1831
						mQUESTION_MARK(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('~'))): // 1831
						mBITWISE_NOT(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('@'))): // 1831
						mAT(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('/'))): // 1831
						mDIVISION(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('\t'))
						 or (_givenValue ==char('\n'))
						 or (_givenValue ==char('\u000c'))
						 or (_givenValue ==char('\r'))
						 or (_givenValue ==char(' '))
					): // 1827
						mWHITE_SPACE(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('"'))): // 1831
						mDOUBLE_QUOTED_STRING(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('\''))): // 1831
						mSINGLE_QUOTED_STRING(true)
						theRetToken = returnToken_
					else: // line 1969
						if ((cached_LA1==char('=')) and (cached_LA2==char('=')) and (LA(3)==char('='))):
							mREFERENCE_EQUALITY(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('!')) and (cached_LA2==char('=')) and (LA(3)==char('='))): // line 2102
							mREFERENCE_INEQUALITY(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('<')) and (cached_LA2==char('<')) and (LA(3)==char('='))): // line 2102
							mINPLACE_SHIFT_LEFT(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('>')) and (cached_LA2==char('>')) and (LA(3)==char('='))): // line 2102
							mINPLACE_SHIFT_RIGHT(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('|')) and (cached_LA2==char('='))): // line 2102
							mINPLACE_BITWISE_OR(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('&')) and (cached_LA2==char('='))): // line 2102
							mINPLACE_BITWISE_AND(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('^')) and (cached_LA2==char('='))): // line 2102
							mINPLACE_BITWISE_XOR(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('|')) and (cached_LA2==char('|'))): // line 2102
							mLOGICAL_OR(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('&')) and (cached_LA2==char('&'))): // line 2102
							mLOGICAL_AND(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('+')) and (cached_LA2==char('+'))): // line 2102
							mINCREMENT(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('-')) and (cached_LA2==char('-'))): // line 2102
							mDECREMENT(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('+')) and (cached_LA2==char('='))): // line 2102
							mINPLACE_ADD(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('-')) and (cached_LA2==char('='))): // line 2102
							mINPLACE_SUBTRACT(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('*')) and (cached_LA2==char('='))): // line 2102
							mINPLACE_MULTIPLY(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('=')) and (cached_LA2==char('=')) and (true)): // line 2102
							mEQUALITY(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('!')) and (cached_LA2==char('=')) and (true)): // line 2102
							mINEQUALITY(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('<')) and (cached_LA2==char('='))): // line 2102
							mLESS_THAN_OR_EQUAL(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('<')) and (cached_LA2==char('<')) and (true)): // line 2102
							mSHIFT_LEFT(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('>')) and (cached_LA2==char('='))): // line 2102
							mGREATER_THAN_OR_EQUAL(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('>')) and (cached_LA2==char('>')) and (true)): // line 2102
							mSHIFT_RIGHT(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('|')) and (true)): // line 2102
							mBITWISE_OR(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('&')) and (true)): // line 2102
							mBITWISE_AND(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('^')) and (true)): // line 2102
							mBITWISE_XOR(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('=')) and (true)): // line 2102
							mASSIGN(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('+')) and (true)): // line 2102
							mADD(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('-')) and (true)): // line 2102
							mSUBTRACT(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('*')) and (true)): // line 2102
							mMULTIPLY(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('!')) and (true)): // line 2102
							mLOGICAL_NOT(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('<')) and (true)): // line 2102
							mLESS_THAN(true)
							theRetToken = returnToken_
						elif ((cached_LA1==char('>')) and (true)): // line 2102
							mGREATER_THAN(true)
							theRetToken = returnToken_
						else:
							if cached_LA1 == EOF_CHAR:
								uponEOF(); returnToken_ = makeToken(Token.EOF_TYPE)
							else:
								raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
					goto tryAgain if returnToken_ is null // found SKIP token
					_ttype = returnToken_.Type
					returnToken_.Type = _ttype
					return returnToken_
				except e as RecognitionException:
						raise TokenStreamRecognitionException(e)
			except cse as CharStreamException:
				if cse isa CharStreamIOException:
					raise TokenStreamIOException(cast(CharStreamIOException, cse).io)
				else:
					raise TokenStreamException(cse.Message)
	
	public def mID(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = ID
		
		mID_LETTER(false)
		while true:
			_givenValue  = cached_LA1
			if ((_givenValue == char('A'))
				 or (_givenValue ==char('B'))
				 or (_givenValue ==char('C'))
				 or (_givenValue ==char('D'))
				 or (_givenValue ==char('E'))
				 or (_givenValue ==char('F'))
				 or (_givenValue ==char('G'))
				 or (_givenValue ==char('H'))
				 or (_givenValue ==char('I'))
				 or (_givenValue ==char('J'))
				 or (_givenValue ==char('K'))
				 or (_givenValue ==char('L'))
				 or (_givenValue ==char('M'))
				 or (_givenValue ==char('N'))
				 or (_givenValue ==char('O'))
				 or (_givenValue ==char('P'))
				 or (_givenValue ==char('Q'))
				 or (_givenValue ==char('R'))
				 or (_givenValue ==char('S'))
				 or (_givenValue ==char('T'))
				 or (_givenValue ==char('U'))
				 or (_givenValue ==char('V'))
				 or (_givenValue ==char('W'))
				 or (_givenValue ==char('X'))
				 or (_givenValue ==char('Y'))
				 or (_givenValue ==char('Z'))
				 or (_givenValue ==char('_'))
				 or (_givenValue ==char('a'))
				 or (_givenValue ==char('b'))
				 or (_givenValue ==char('c'))
				 or (_givenValue ==char('d'))
				 or (_givenValue ==char('e'))
				 or (_givenValue ==char('f'))
				 or (_givenValue ==char('g'))
				 or (_givenValue ==char('h'))
				 or (_givenValue ==char('i'))
				 or (_givenValue ==char('j'))
				 or (_givenValue ==char('k'))
				 or (_givenValue ==char('l'))
				 or (_givenValue ==char('m'))
				 or (_givenValue ==char('n'))
				 or (_givenValue ==char('o'))
				 or (_givenValue ==char('p'))
				 or (_givenValue ==char('q'))
				 or (_givenValue ==char('r'))
				 or (_givenValue ==char('s'))
				 or (_givenValue ==char('t'))
				 or (_givenValue ==char('u'))
				 or (_givenValue ==char('v'))
				 or (_givenValue ==char('w'))
				 or (_givenValue ==char('x'))
				 or (_givenValue ==char('y'))
				 or (_givenValue ==char('z'))
			): // 1827
				mID_LETTER(false)
			elif ((_givenValue == char('0'))
				 or (_givenValue ==char('1'))
				 or (_givenValue ==char('2'))
				 or (_givenValue ==char('3'))
				 or (_givenValue ==char('4'))
				 or (_givenValue ==char('5'))
				 or (_givenValue ==char('6'))
				 or (_givenValue ==char('7'))
				 or (_givenValue ==char('8'))
				 or (_givenValue ==char('9'))
			): // 1827
				mDIGIT(false)
			else: // line 1969
					goto _loop332_breakloop
		:_loop332_breakloop
		_ttype = testLiteralsTable(_ttype)
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mID_LETTER(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = ID_LETTER
		
		_givenValue  = cached_LA1
		if ((_givenValue == char('_'))): // 1831
			match('_')
		elif ((_givenValue == char('a'))
			 or (_givenValue ==char('b'))
			 or (_givenValue ==char('c'))
			 or (_givenValue ==char('d'))
			 or (_givenValue ==char('e'))
			 or (_givenValue ==char('f'))
			 or (_givenValue ==char('g'))
			 or (_givenValue ==char('h'))
			 or (_givenValue ==char('i'))
			 or (_givenValue ==char('j'))
			 or (_givenValue ==char('k'))
			 or (_givenValue ==char('l'))
			 or (_givenValue ==char('m'))
			 or (_givenValue ==char('n'))
			 or (_givenValue ==char('o'))
			 or (_givenValue ==char('p'))
			 or (_givenValue ==char('q'))
			 or (_givenValue ==char('r'))
			 or (_givenValue ==char('s'))
			 or (_givenValue ==char('t'))
			 or (_givenValue ==char('u'))
			 or (_givenValue ==char('v'))
			 or (_givenValue ==char('w'))
			 or (_givenValue ==char('x'))
			 or (_givenValue ==char('y'))
			 or (_givenValue ==char('z'))
		): // 1827
			matchRange(char('a'),char('z'))
		elif ((_givenValue == char('A'))
			 or (_givenValue ==char('B'))
			 or (_givenValue ==char('C'))
			 or (_givenValue ==char('D'))
			 or (_givenValue ==char('E'))
			 or (_givenValue ==char('F'))
			 or (_givenValue ==char('G'))
			 or (_givenValue ==char('H'))
			 or (_givenValue ==char('I'))
			 or (_givenValue ==char('J'))
			 or (_givenValue ==char('K'))
			 or (_givenValue ==char('L'))
			 or (_givenValue ==char('M'))
			 or (_givenValue ==char('N'))
			 or (_givenValue ==char('O'))
			 or (_givenValue ==char('P'))
			 or (_givenValue ==char('Q'))
			 or (_givenValue ==char('R'))
			 or (_givenValue ==char('S'))
			 or (_givenValue ==char('T'))
			 or (_givenValue ==char('U'))
			 or (_givenValue ==char('V'))
			 or (_givenValue ==char('W'))
			 or (_givenValue ==char('X'))
			 or (_givenValue ==char('Y'))
			 or (_givenValue ==char('Z'))
		): // 1827
			matchRange(char('A'),char('Z'))
		else: // line 1969
				raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mDIGIT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = DIGIT
		
		matchRange(char('0'),char('9'))
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mINT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = INT
		
		if ((cached_LA1==char('0')) and (cached_LA2==char('x'))):
			match("0x")
			_cnt336 as int = 0
			while true:
				if ((tokenSet_0_.member(cast(int, cached_LA1)))):
					mHEXDIGIT(false)
				else:
					if (_cnt336 >= 1):
						goto _loop336_breakloop
					else:
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
				++_cnt336
			:_loop336_breakloop
			if ((cached_LA1==char('L') or cached_LA1==char('l'))):
				_givenValue  = cached_LA1
				if ((_givenValue == char('l'))): // 1831
					match('l')
				elif ((_givenValue == char('L'))): // 1831
					match('L')
				else: // line 1969
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
				if 0 == inputState.guessing:
					_ttype = LONG; 
			else: // line 2053
				pass // 947
		elif ((((cached_LA1 >= char('0')) and (cached_LA1 <= char('9')))) and (true)): // line 2102
			_cnt340 as int = 0
			while true:
				if ((((cached_LA1 >= char('0')) and (cached_LA1 <= char('9'))))):
					mDIGIT(false)
				else:
					if (_cnt340 >= 1):
						goto _loop340_breakloop
					else:
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
				++_cnt340
			:_loop340_breakloop
			_givenValue  = cached_LA1
			if ((_givenValue == char('L'))
				 or (_givenValue ==char('l'))
			): // 1827
				_givenValue  = cached_LA1
				if ((_givenValue == char('l'))): // 1831
					match('l')
				elif ((_givenValue == char('L'))): // 1831
					match('L')
				else: // line 1969
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
				if 0 == inputState.guessing:
					_ttype = LONG; 
			elif ((_givenValue == char('D'))
				 or (_givenValue ==char('F'))
				 or (_givenValue ==char('d'))
				 or (_givenValue ==char('f'))
			): // 1827
				_givenValue  = cached_LA1
				if ((_givenValue == char('f'))): // 1831
					match('f')
				elif ((_givenValue == char('F'))): // 1831
					match('F')
				elif ((_givenValue == char('d'))): // 1831
					match('d')
				elif ((_givenValue == char('D'))): // 1831
					match('D')
				else: // line 1969
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
				if 0 == inputState.guessing:
					_ttype = DOUBLE; 
			elif ((_givenValue == char('.'))): // 1831
				match('.')
				mDOUBLE_SUFFIX(false)
				if 0 == inputState.guessing:
					_ttype = DOUBLE; 
			elif ((_givenValue == char('E'))
				 or (_givenValue ==char('e'))
			): // 1827
				mEXPONENT(false)
				if 0 == inputState.guessing:
					_ttype = DOUBLE; 
			else: // line 1969
					pass // 947
		else:
			raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mHEXDIGIT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = HEXDIGIT
		
		_givenValue  = cached_LA1
		if ((_givenValue == char('a'))
			 or (_givenValue ==char('b'))
			 or (_givenValue ==char('c'))
			 or (_givenValue ==char('d'))
			 or (_givenValue ==char('e'))
			 or (_givenValue ==char('f'))
		): // 1827
			matchRange(char('a'),char('f'))
		elif ((_givenValue == char('A'))
			 or (_givenValue ==char('B'))
			 or (_givenValue ==char('C'))
			 or (_givenValue ==char('D'))
			 or (_givenValue ==char('E'))
			 or (_givenValue ==char('F'))
		): // 1827
			matchRange(char('A'),char('F'))
		elif ((_givenValue == char('0'))
			 or (_givenValue ==char('1'))
			 or (_givenValue ==char('2'))
			 or (_givenValue ==char('3'))
			 or (_givenValue ==char('4'))
			 or (_givenValue ==char('5'))
			 or (_givenValue ==char('6'))
			 or (_givenValue ==char('7'))
			 or (_givenValue ==char('8'))
			 or (_givenValue ==char('9'))
		): // 1827
			matchRange(char('0'),char('9'))
		else: // line 1969
				raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mDOUBLE_SUFFIX(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = DOUBLE_SUFFIX
		
		_cnt349 as int = 0
		while true:
			if ((((cached_LA1 >= char('0')) and (cached_LA1 <= char('9'))))):
				mDIGIT(false)
			else:
				if (_cnt349 >= 1):
					goto _loop349_breakloop
				else:
					raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
			++_cnt349
		:_loop349_breakloop
		if ((cached_LA1==char('E') or cached_LA1==char('e'))):
			mEXPONENT(false)
		else: // line 2053
			pass // 947
		_givenValue  = cached_LA1
		if ((_givenValue == char('f'))): // 1831
			match('f')
		elif ((_givenValue == char('F'))): // 1831
			match('F')
		elif ((_givenValue == char('d'))): // 1831
			match('d')
		elif ((_givenValue == char('D'))): // 1831
			match('D')
		else: // line 1969
				pass // 947
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mEXPONENT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = EXPONENT
		
		_givenValue  = cached_LA1
		if ((_givenValue == char('e'))): // 1831
			match('e')
		elif ((_givenValue == char('E'))): // 1831
			match('E')
		else: // line 1969
				raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		_givenValue  = cached_LA1
		if ((_givenValue == char('+'))): // 1831
			match('+')
		elif ((_givenValue == char('-'))): // 1831
			match('-')
		elif ((_givenValue == char('0'))
			 or (_givenValue ==char('1'))
			 or (_givenValue ==char('2'))
			 or (_givenValue ==char('3'))
			 or (_givenValue ==char('4'))
			 or (_givenValue ==char('5'))
			 or (_givenValue ==char('6'))
			 or (_givenValue ==char('7'))
			 or (_givenValue ==char('8'))
			 or (_givenValue ==char('9'))
		): // 1827
			pass // 947
		else: // line 1969
				raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		_cnt356 as int = 0
		while true:
			if ((((cached_LA1 >= char('0')) and (cached_LA1 <= char('9'))))):
				mDIGIT(false)
			else:
				if (_cnt356 >= 1):
					goto _loop356_breakloop
				else:
					raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
			++_cnt356
		:_loop356_breakloop
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mDOT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = DOT
		
		match('.')
		if ((((cached_LA1 >= char('0')) and (cached_LA1 <= char('9'))))):
			mDOUBLE_SUFFIX(false)
			if 0 == inputState.guessing:
				_ttype = DOUBLE;
		else: // line 2053
			pass // 947
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mCOLON(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = COLON
		
		match(':')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mCOMMA(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = COMMA
		
		match(',')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mLPAREN(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = LPAREN
		
		match('(')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mRPAREN(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = RPAREN
		
		match(')')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mLBRACK(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = LBRACK
		
		match('[')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mRBRACK(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = RBRACK
		
		match(']')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mLBRACE(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = LBRACE
		
		match('{')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mRBRACE(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = RBRACE
		
		match('}')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mBITWISE_OR(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = BITWISE_OR
		
		match('|')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mINPLACE_BITWISE_OR(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = INPLACE_BITWISE_OR
		
		match("|=")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mBITWISE_AND(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = BITWISE_AND
		
		match('&')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mINPLACE_BITWISE_AND(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = INPLACE_BITWISE_AND
		
		match("&=")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mBITWISE_XOR(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = BITWISE_XOR
		
		match('^')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mINPLACE_BITWISE_XOR(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = INPLACE_BITWISE_XOR
		
		match("^=")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mLOGICAL_OR(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = LOGICAL_OR
		
		match("||")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mLOGICAL_AND(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = LOGICAL_AND
		
		match("&&")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mEOS(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = EOS
		
		match(';')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mASSIGN(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = ASSIGN
		
		match('=')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mINCREMENT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = INCREMENT
		
		match("++")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mDECREMENT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = DECREMENT
		
		match("--")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mADD(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = ADD
		
		match('+')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mPRAGMA_ON(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = PRAGMA_ON
		id as IToken
		
		_saveIndex = text.Length
		match("#pragma")
		text.Length = _saveIndex
		_cnt380 as int = 0
		while true:
			if ((cached_LA1==char('\t') or cached_LA1==char(' '))):
				mPRAGMA_WHITE_SPACE(false)
			else:
				if (_cnt380 >= 1):
					goto _loop380_breakloop
				else:
					raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
			++_cnt380
		:_loop380_breakloop
		mID(true)
		id = returnToken_
		if ((cached_LA1==char('\t') or cached_LA1==char(' ')) and (cached_LA2==char('\t') or cached_LA2==char(' ') or cached_LA2==char('o')) and (LA(3)==char('\t') or LA(3)==char(' ') or LA(3)==char('f') or LA(3)==char('n') or LA(3)==char('o'))):
			_cnt383 as int = 0
			while true:
				if ((cached_LA1==char('\t') or cached_LA1==char(' '))):
					mPRAGMA_WHITE_SPACE(false)
				else:
					if (_cnt383 >= 1):
						goto _loop383_breakloop
					else:
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
				++_cnt383
			:_loop383_breakloop
			if ((cached_LA1==char('o')) and (cached_LA2==char('f'))):
				_saveIndex = text.Length
				match("off")
				text.Length = _saveIndex
				if 0 == inputState.guessing:
					_ttype = PRAGMA_OFF; 
			elif ((cached_LA1==char('o')) and (cached_LA2==char('n'))): // line 2102
				_saveIndex = text.Length
				match("on")
				text.Length = _saveIndex
			else:
				raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		elif ((cached_LA1==char('\t') or cached_LA1==char('\n') or cached_LA1==char('\r') or cached_LA1==char(' ')) and (true) and (true)): // line 2102
			pass // 947
		else:
			raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		while true:
			if ((cached_LA1==char('\t') or cached_LA1==char(' '))):
				mPRAGMA_WHITE_SPACE(false)
			else:
				goto _loop386_breakloop
		:_loop386_breakloop
		_saveIndex = text.Length
		mNEWLINE(false)
		text.Length = _saveIndex
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mPRAGMA_WHITE_SPACE(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = PRAGMA_WHITE_SPACE
		
		_givenValue  = cached_LA1
		if ((_givenValue == char(' '))): // 1831
			_saveIndex = text.Length
			match(' ')
			text.Length = _saveIndex
		elif ((_givenValue == char('\t'))): // 1831
			_saveIndex = text.Length
			match('\t')
			text.Length = _saveIndex
		else: // line 1969
				raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mNEWLINE(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = NEWLINE
		
		_givenValue  = cached_LA1
		if ((_givenValue == char('\n'))): // 1831
			match('\n')
		elif ((_givenValue == char('\r'))): // 1831
			match('\r')
			if ((cached_LA1==char('\n')) and (true) and (true)):
				match('\n')
			else: // line 2053
				pass // 947
		else: // line 1969
				raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		if 0 == inputState.guessing:
			newline(); 
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mINPLACE_ADD(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = INPLACE_ADD
		
		match("+=")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mSUBTRACT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = SUBTRACT
		
		match('-')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mINPLACE_SUBTRACT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = INPLACE_SUBTRACT
		
		match("-=")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mMODULUS(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = MODULUS
		
		match('%')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mMULTIPLY(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = MULTIPLY
		
		match('*')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mINPLACE_MULTIPLY(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = INPLACE_MULTIPLY
		
		match("*=")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mEQUALITY(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = EQUALITY
		
		match("==")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mINEQUALITY(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = INEQUALITY
		
		match("!=")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mLOGICAL_NOT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = LOGICAL_NOT
		
		match('!')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mQUESTION_MARK(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = QUESTION_MARK
		
		match('?')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mBITWISE_NOT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = BITWISE_NOT
		
		match('~')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mREFERENCE_EQUALITY(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = REFERENCE_EQUALITY
		
		match("===")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mREFERENCE_INEQUALITY(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = REFERENCE_INEQUALITY
		
		match("!==")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mLESS_THAN(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = LESS_THAN
		
		match('<')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mLESS_THAN_OR_EQUAL(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = LESS_THAN_OR_EQUAL
		
		match("<=")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mSHIFT_LEFT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = SHIFT_LEFT
		
		match("<<")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mINPLACE_SHIFT_LEFT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = INPLACE_SHIFT_LEFT
		
		match("<<=")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mGREATER_THAN(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = GREATER_THAN
		
		match('>')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mGREATER_THAN_OR_EQUAL(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = GREATER_THAN_OR_EQUAL
		
		match(">=")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mSHIFT_RIGHT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = SHIFT_RIGHT
		
		match(">>")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mINPLACE_SHIFT_RIGHT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = INPLACE_SHIFT_RIGHT
		
		match(">>=")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mAT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = AT
		
		match('@')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mDIVISION(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = DIVISION
		
		synPredMatched413 as bool = false
		if ((cached_LA1==char('/')) and (cached_LA2==char('*'))):
			_m413 as int = mark()
			synPredMatched413 = true
			++inputState.guessing
			try:
				match("/*")
			except x as RecognitionException:
				synPredMatched413 = false
			rewind(_m413)
			--inputState.guessing
		if synPredMatched413:
			mML_COMMENT(false)
			if 0 == inputState.guessing:
				if not PreserveComments:
					_ttype = Token.SKIP
		elif ((cached_LA1==char('/')) and (true)): // line 2102
			match('/')
			_givenValue  = cached_LA1
			if ((_givenValue == char('/'))): // 1831
				match('/')
				while true:
					if ((tokenSet_1_.member(cast(int, cached_LA1)))):
						match(tokenSet_1_)
					else:
						goto _loop418_breakloop
				:_loop418_breakloop
				if 0 == inputState.guessing:
					if PreserveComments:
						_ttype = SL_COMMENT
					else:
						_ttype = Token.SKIP;
			elif ((_givenValue == char('='))): // 1831
				match('=')
				if 0 == inputState.guessing:
					_ttype = INPLACE_DIVISION; 
			else: // line 1969
					pass // 947
		else:
			raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mML_COMMENT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = ML_COMMENT
		
		match("/*")
		while true:
			if (((cached_LA1==char('*')) and (((cached_LA2 >= char('\u0003')) and (cached_LA2 <= char('\ufffe')))) and (((LA(3) >= char('\u0003')) and (LA(3) <= char('\ufffe'))))) and ( LA(2) != char('/') )):
				match('*')
			elif ((cached_LA1==char('\n') or cached_LA1==char('\r'))): // line 2102
				mNEWLINE(false)
			elif ((tokenSet_2_.member(cast(int, cached_LA1)))): // line 2102
				match(tokenSet_2_)
			else:
				goto _loop447_breakloop
		:_loop447_breakloop
		match("*/")
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mWHITE_SPACE(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = WHITE_SPACE
		
		_cnt422 as int = 0
		while true:
			_givenValue  = cached_LA1
			if ((_givenValue == char(' '))): // 1831
				match(' ')
			elif ((_givenValue == char('\t'))): // 1831
				match('\t')
			elif ((_givenValue == char('\u000c'))): // 1831
				match('\f')
			elif ((_givenValue == char('\n'))
				 or (_givenValue ==char('\r'))
			): // 1827
				mNEWLINE(false)
			else: // line 1969
					if (_cnt422 >= 1):
						goto _loop422_breakloop
					else:
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
			++_cnt422
		:_loop422_breakloop
		if 0 == inputState.guessing:
			_ttype = Token.SKIP;	
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mDOUBLE_QUOTED_STRING(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = DOUBLE_QUOTED_STRING
		
		_saveIndex = text.Length
		match('"')
		text.Length = _saveIndex
		while true:
			if ((cached_LA1==char('\\'))):
				mDQS_ESC(false)
			elif ((tokenSet_3_.member(cast(int, cached_LA1)))): // line 2102
				match(tokenSet_3_)
			else:
				goto _loop426_breakloop
		:_loop426_breakloop
		_saveIndex = text.Length
		match('"')
		text.Length = _saveIndex
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mDQS_ESC(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = DQS_ESC
		
		_saveIndex = text.Length
		match('\\')
		text.Length = _saveIndex
		_givenValue  = cached_LA1
		if ((_givenValue == char('0'))
			 or (_givenValue ==char('\\'))
			 or (_givenValue ==char('a'))
			 or (_givenValue ==char('b'))
			 or (_givenValue ==char('f'))
			 or (_givenValue ==char('n'))
			 or (_givenValue ==char('r'))
			 or (_givenValue ==char('t'))
		): // 1827
			mSESC(false)
		elif ((_givenValue == char('"'))): // 1831
			match('"')
		else: // line 1969
				raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mSINGLE_QUOTED_STRING(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = SINGLE_QUOTED_STRING
		
		_saveIndex = text.Length
		match('\'')
		text.Length = _saveIndex
		while true:
			if ((cached_LA1==char('\\'))):
				mSQS_ESC(false)
			elif ((tokenSet_4_.member(cast(int, cached_LA1)))): // line 2102
				match(tokenSet_4_)
			else:
				goto _loop430_breakloop
		:_loop430_breakloop
		_saveIndex = text.Length
		match('\'')
		text.Length = _saveIndex
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mSQS_ESC(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = SQS_ESC
		
		_saveIndex = text.Length
		match('\\')
		text.Length = _saveIndex
		_givenValue  = cached_LA1
		if ((_givenValue == char('0'))
			 or (_givenValue ==char('\\'))
			 or (_givenValue ==char('a'))
			 or (_givenValue ==char('b'))
			 or (_givenValue ==char('f'))
			 or (_givenValue ==char('n'))
			 or (_givenValue ==char('r'))
			 or (_givenValue ==char('t'))
		): // 1827
			mSESC(false)
		elif ((_givenValue == char('\''))): // 1831
			match('\'')
		else: // line 1969
				raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mSESC(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = SESC
		
		_givenValue  = cached_LA1
		if ((_givenValue == char('r'))): // 1831
			_saveIndex = text.Length
			match('r')
			text.Length = _saveIndex
			if 0 == inputState.guessing:
				text.Length = _begin; text.Append("\r"); 
		elif ((_givenValue == char('n'))): // 1831
			_saveIndex = text.Length
			match('n')
			text.Length = _saveIndex
			if 0 == inputState.guessing:
				text.Length = _begin; text.Append("\n"); 
		elif ((_givenValue == char('t'))): // 1831
			_saveIndex = text.Length
			match('t')
			text.Length = _saveIndex
			if 0 == inputState.guessing:
				text.Length = _begin; text.Append("\t"); 
		elif ((_givenValue == char('a'))): // 1831
			_saveIndex = text.Length
			match('a')
			text.Length = _saveIndex
			if 0 == inputState.guessing:
				text.Length = _begin; text.Append("\a"); 
		elif ((_givenValue == char('b'))): // 1831
			_saveIndex = text.Length
			match('b')
			text.Length = _saveIndex
			if 0 == inputState.guessing:
				text.Length = _begin; text.Append("\b"); 
		elif ((_givenValue == char('f'))): // 1831
			_saveIndex = text.Length
			match('f')
			text.Length = _saveIndex
			if 0 == inputState.guessing:
				text.Length = _begin; text.Append("\f"); 
		elif ((_givenValue == char('0'))): // 1831
			_saveIndex = text.Length
			match('0')
			text.Length = _saveIndex
			if 0 == inputState.guessing:
				text.Length = _begin; text.Append("\0"); 
		elif ((_givenValue == char('\\'))): // 1831
			_saveIndex = text.Length
			match('\\')
			text.Length = _saveIndex
			if 0 == inputState.guessing:
				text.Length = _begin; text.Append("\\"); 
		else: // line 1969
				raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mRE_LITERAL(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = RE_LITERAL
		
		match('/')
		_cnt450 as int = 0
		while true:
			if ((tokenSet_5_.member(cast(int, cached_LA1)))):
				mRE_CHAR(false)
			else:
				if (_cnt450 >= 1):
					goto _loop450_breakloop
				else:
					raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
			++_cnt450
		:_loop450_breakloop
		match('/')
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mRE_CHAR(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = RE_CHAR
		
		if ((cached_LA1==char('\\'))):
			mRE_ESC(false)
		elif ((tokenSet_6_.member(cast(int, cached_LA1)))): // line 2102
			match(tokenSet_6_)
		else:
			raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	protected def mRE_ESC(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = RE_ESC
		
		match('\\')
		_givenValue  = cached_LA1
		if ((_givenValue == char('a'))): // 1831
			match('a')
		elif ((_givenValue == char('b'))): // 1831
			match('b')
		elif ((_givenValue == char('c'))): // 1831
			match('c')
			matchRange(char('A'),char('Z'))
		elif ((_givenValue == char('t'))): // 1831
			match('t')
		elif ((_givenValue == char('r'))): // 1831
			match('r')
		elif ((_givenValue == char('v'))): // 1831
			match('v')
		elif ((_givenValue == char('f'))): // 1831
			match('f')
		elif ((_givenValue == char('n'))): // 1831
			match('n')
		elif ((_givenValue == char('e'))): // 1831
			match('e')
		elif ((_givenValue == char('0'))
			 or (_givenValue ==char('1'))
			 or (_givenValue ==char('2'))
			 or (_givenValue ==char('3'))
			 or (_givenValue ==char('4'))
			 or (_givenValue ==char('5'))
			 or (_givenValue ==char('6'))
			 or (_givenValue ==char('7'))
			 or (_givenValue ==char('8'))
			 or (_givenValue ==char('9'))
		): // 1827
			_cnt456 as int = 0
			while true:
				if ((((cached_LA1 >= char('0')) and (cached_LA1 <= char('9')))) and (tokenSet_7_.member(cast(int, cached_LA2))) and (true)):
					mDIGIT(false)
				else:
					if (_cnt456 >= 1):
						goto _loop456_breakloop
					else:
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
				++_cnt456
			:_loop456_breakloop
		elif ((_givenValue == char('x'))): // 1831
			match('x')
			mDIGIT(false)
			mDIGIT(false)
		elif ((_givenValue == char('u'))): // 1831
			match('u')
			mDIGIT(false)
			mDIGIT(false)
			mDIGIT(false)
			mDIGIT(false)
		elif ((_givenValue == char('\\'))): // 1831
			match('\\')
		elif ((_givenValue == char('w'))): // 1831
			match('w')
		elif ((_givenValue == char('W'))): // 1831
			match('W')
		elif ((_givenValue == char('s'))): // 1831
			match('s')
		elif ((_givenValue == char('S'))): // 1831
			match('S')
		elif ((_givenValue == char('d'))): // 1831
			match('d')
		elif ((_givenValue == char('D'))): // 1831
			match('D')
		elif ((_givenValue == char('p'))): // 1831
			match('p')
		elif ((_givenValue == char('P'))): // 1831
			match('P')
		elif ((_givenValue == char('A'))): // 1831
			match('A')
		elif ((_givenValue == char('z'))): // 1831
			match('z')
		elif ((_givenValue == char('Z'))): // 1831
			match('Z')
		elif ((_givenValue == char('g'))): // 1831
			match('g')
		elif ((_givenValue == char('B'))): // 1831
			match('B')
		elif ((_givenValue == char('k'))): // 1831
			match('k')
		elif ((_givenValue == char('/'))): // 1831
			match('/')
		elif ((_givenValue == char('('))): // 1831
			match('(')
		elif ((_givenValue == char(')'))): // 1831
			match(')')
		elif ((_givenValue == char('|'))): // 1831
			match('|')
		elif ((_givenValue == char('.'))): // 1831
			match('.')
		elif ((_givenValue == char('*'))): // 1831
			match('*')
		elif ((_givenValue == char('?'))): // 1831
			match('?')
		elif ((_givenValue == char('$'))): // 1831
			match('$')
		elif ((_givenValue == char('^'))): // 1831
			match('^')
		elif ((_givenValue == char('['))): // 1831
			match('[')
		elif ((_givenValue == char(']'))): // 1831
			match(']')
		else: // line 1969
				raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	
	private static def mk_tokenSet_0_() as (long):
		data = array(long, 1025)
		data[0]=287948901175001088L
		data[1]=541165879422L
		i = 2
		while i<=1024:
			data[i] = 0L
			++i
		return data
	public static final tokenSet_0_ = BitSet(mk_tokenSet_0_())
	private static def mk_tokenSet_1_() as (long):
		data = array(long, 2048)
		data[0]=-9224L
		i = 1
		while i<=1022:
			data[i] = -1L
			++i
		data[1023]=9223372036854775807L
		i = 1024
		while i<=2047:
			data[i] = 0L
			++i
		return data
	public static final tokenSet_1_ = BitSet(mk_tokenSet_1_())
	private static def mk_tokenSet_2_() as (long):
		data = array(long, 2048)
		data[0]=-4398046520328L
		i = 1
		while i<=1022:
			data[i] = -1L
			++i
		data[1023]=9223372036854775807L
		i = 1024
		while i<=2047:
			data[i] = 0L
			++i
		return data
	public static final tokenSet_2_ = BitSet(mk_tokenSet_2_())
	private static def mk_tokenSet_3_() as (long):
		data = array(long, 2048)
		data[0]=-17179878408L
		data[1]=-268435457L
		i = 2
		while i<=1022:
			data[i] = -1L
			++i
		data[1023]=9223372036854775807L
		i = 1024
		while i<=2047:
			data[i] = 0L
			++i
		return data
	public static final tokenSet_3_ = BitSet(mk_tokenSet_3_())
	private static def mk_tokenSet_4_() as (long):
		data = array(long, 2048)
		data[0]=-549755823112L
		data[1]=-268435457L
		i = 2
		while i<=1022:
			data[i] = -1L
			++i
		data[1023]=9223372036854775807L
		i = 1024
		while i<=2047:
			data[i] = 0L
			++i
		return data
	public static final tokenSet_4_ = BitSet(mk_tokenSet_4_())
	private static def mk_tokenSet_5_() as (long):
		data = array(long, 2048)
		data[0]=-140741783332360L
		i = 1
		while i<=1022:
			data[i] = -1L
			++i
		data[1023]=9223372036854775807L
		i = 1024
		while i<=2047:
			data[i] = 0L
			++i
		return data
	public static final tokenSet_5_ = BitSet(mk_tokenSet_5_())
	private static def mk_tokenSet_6_() as (long):
		data = array(long, 2048)
		data[0]=-140741783332360L
		data[1]=-268435457L
		i = 2
		while i<=1022:
			data[i] = -1L
			++i
		data[1023]=9223372036854775807L
		i = 1024
		while i<=2047:
			data[i] = 0L
			++i
		return data
	public static final tokenSet_6_ = BitSet(mk_tokenSet_6_())
	private static def mk_tokenSet_7_() as (long):
		data = array(long, 2048)
		data[0]=-4294977032L
		i = 1
		while i<=1022:
			data[i] = -1L
			++i
		data[1023]=9223372036854775807L
		i = 1024
		while i<=2047:
			data[i] = 0L
			++i
		return data
	public static final tokenSet_7_ = BitSet(mk_tokenSet_7_())
	
