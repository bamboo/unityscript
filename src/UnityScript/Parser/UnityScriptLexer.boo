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
	public static final CATCH = 6
	public static final CLASS = 7
	public static final CONTINUE = 8
	public static final ELSE = 9
	public static final ENUM = 10
	public static final EXTENDS = 11
	public static final FALSE = 12
	public static final FINAL = 13
	public static final FINALLY = 14
	public static final FOR = 15
	public static final FUNCTION = 16
	public static final GET = 17
	public static final IF = 18
	public static final IMPORT = 19
	public static final IMPLEMENTS = 20
	public static final IN = 21
	public static final INTERFACE = 22
	public static final INSTANCEOF = 23
	public static final NEW = 24
	public static final NOT = 25
	public static final NULL = 26
	public static final RETURN = 27
	public static final PUBLIC = 28
	public static final PROTECTED = 29
	public static final INTERNAL = 30
	public static final OVERRIDE = 31
	public static final PARTIAL = 32
	public static final PRAGMA = 33
	public static final PRIVATE = 34
	public static final SET = 35
	public static final STATIC = 36
	public static final SUPER = 37
	public static final THIS = 38
	public static final THROW = 39
	public static final TRUE = 40
	public static final TRY = 41
	public static final TYPEOF = 42
	public static final VAR = 43
	public static final VIRTUAL = 44
	public static final WHILE = 45
	public static final YIELD = 46
	public static final SWITCH = 47
	public static final CASE = 48
	public static final DEFAULT = 49
	public static final INPLACE_DIVISION = 50
	public static final INPLACE_ADD = 51
	public static final INPLACE_SUBTRACT = 52
	public static final INPLACE_MULTIPLY = 53
	public static final ID = 54
	public static final DOUBLE_QUOTED_STRING = 55
	public static final LBRACE = 56
	public static final RBRACE = 57
	public static final LPAREN = 58
	public static final RPAREN = 59
	public static final DOT = 60
	public static final COLON = 61
	public static final COMMA = 62
	public static final LBRACK = 63
	public static final RBRACK = 64
	public static final BITWISE_OR = 65
	public static final INPLACE_BITWISE_OR = 66
	public static final BITWISE_AND = 67
	public static final BITWISE_XOR = 68
	public static final INPLACE_BITWISE_AND = 69
	public static final LOGICAL_OR = 70
	public static final LOGICAL_AND = 71
	public static final EOS = 72
	public static final ASSIGN = 73
	public static final INCREMENT = 74
	public static final DECREMENT = 75
	public static final ADD = 76
	public static final SUBTRACT = 77
	public static final MODULUS = 78
	public static final MULTIPLY = 79
	public static final EQUALITY = 80
	public static final INEQUALITY = 81
	public static final QUESTION_MARK = 82
	public static final ONES_COMPLEMENT = 83
	public static final REFERENCE_EQUALITY = 84
	public static final REFERENCE_INEQUALITY = 85
	public static final LESS_THAN = 86
	public static final LESS_THAN_OR_EQUAL = 87
	public static final SHIFT_LEFT = 88
	public static final INPLACE_SHIFT_LEFT = 89
	public static final GREATER_THAN = 90
	public static final GREATER_THAN_OR_EQUAL = 91
	public static final SHIFT_RIGHT = 92
	public static final INPLACE_SHIFT_RIGHT = 93
	public static final AT = 94
	public static final SCRIPT_ATTRIBUTE_MARKER = 95
	public static final HASH = 96
	public static final INPLACE_BITWISE_XOR = 97
	public static final EXCLUSIVE_OR = 98
	public static final DIVISION = 99
	public static final RE_LITERAL = 100
	public static final DOUBLE = 101
	public static final INT = 102
	public static final LONG = 103
	public static final DOUBLE_SUFFIX = 104
	public static final EXPONENT = 105
	public static final WHITE_SPACE = 106
	public static final DQS_ESC = 107
	public static final SQS_ESC = 108
	public static final SESC = 109
	public static final ML_COMMENT = 110
	public static final RE_CHAR = 111
	public static final RE_ESC = 112
	public static final NEWLINE = 113
	public static final ID_LETTER = 114
	public static final DIGIT = 115
	public static final HEXDIGIT = 116
	
	
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
		literals.Add(",", 62)
		literals.Add("public", 28)
		literals.Add("a string", 55)
		literals.Add("an identifier", 54)
		literals.Add("]", 64)
		literals.Add("case", 48)
		literals.Add("break", 5)
		literals.Add("while", 45)
		literals.Add("new", 24)
		literals.Add("||", 70)
		literals.Add("+", 76)
		literals.Add("instanceof", 23)
		literals.Add("implements", 20)
		literals.Add("*", 79)
		literals.Add("|=", 66)
		literals.Add("typeof", 42)
		literals.Add("[", 63)
		literals.Add(">>=", 93)
		literals.Add("not", 25)
		literals.Add("return", 27)
		literals.Add("throw", 39)
		literals.Add("var", 43)
		literals.Add(")", 59)
		literals.Add("==", 80)
		literals.Add("null", 26)
		literals.Add("protected", 29)
		literals.Add("@script", 95)
		literals.Add("class", 7)
		literals.Add("(", 58)
		literals.Add("~", 83)
		literals.Add("function", 16)
		literals.Add("/=", 50)
		literals.Add("super", 37)
		literals.Add("@", 94)
		literals.Add("-=", 52)
		literals.Add("set", 35)
		literals.Add("+=", 51)
		literals.Add("!==", 85)
		literals.Add("}", 57)
		literals.Add("interface", 22)
		literals.Add("?", 82)
		literals.Add("&", 67)
		literals.Add("internal", 30)
		literals.Add("final", 13)
		literals.Add("yield", 46)
		literals.Add("!=", 81)
		literals.Add("===", 84)
		literals.Add("if", 18)
		literals.Add("|", 65)
		literals.Add("override", 31)
		literals.Add(">", 90)
		literals.Add("as", 4)
		literals.Add("%", 78)
		literals.Add("pragma", 33)
		literals.Add("catch", 6)
		literals.Add("try", 41)
		literals.Add("{", 56)
		literals.Add("=", 73)
		literals.Add("enum", 10)
		literals.Add("for", 15)
		literals.Add(">>", 92)
		literals.Add("extends", 11)
		literals.Add("private", 34)
		literals.Add("default", 49)
		literals.Add("--", 75)
		literals.Add("<", 86)
		literals.Add("false", 12)
		literals.Add("this", 38)
		literals.Add("static", 36)
		literals.Add(">=", 91)
		literals.Add("<=", 87)
		literals.Add("partial", 32)
		literals.Add(";", 72)
		literals.Add("get", 17)
		literals.Add("<<=", 89)
		literals.Add("continue", 8)
		literals.Add("&&", 71)
		literals.Add("<<", 88)
		literals.Add(".", 60)
		literals.Add("finally", 14)
		literals.Add("else", 9)
		literals.Add("import", 19)
		literals.Add("++", 74)
		literals.Add(":", 61)
		literals.Add("in", 21)
		literals.Add("switch", 47)
		literals.Add("true", 40)
		literals.Add("-", 77)
		literals.Add("*=", 53)
		literals.Add("virtual", 44)
		literals.Add("^", 68)
		literals.Add("&=", 69)
	
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
						mHASH(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('%'))): // 1831
						mMODULUS(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('?'))): // 1831
						mQUESTION_MARK(true)
						theRetToken = returnToken_
					elif ((_givenValue == char('~'))): // 1831
						mONES_COMPLEMENT(true)
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
							mNOT(true)
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
					goto _loop304_breakloop
		:_loop304_breakloop
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
			_cnt308 as int = 0
			while true:
				if ((tokenSet_0_.member(cast(int, cached_LA1)))):
					mHEXDIGIT(false)
				else:
					if (_cnt308 >= 1):
						goto _loop308_breakloop
					else:
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
				++_cnt308
			:_loop308_breakloop
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
			_cnt312 as int = 0
			while true:
				if ((((cached_LA1 >= char('0')) and (cached_LA1 <= char('9'))))):
					mDIGIT(false)
				else:
					if (_cnt312 >= 1):
						goto _loop312_breakloop
					else:
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
				++_cnt312
			:_loop312_breakloop
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
			elif ((_givenValue == char('F'))
				 or (_givenValue ==char('f'))
			): // 1827
				_givenValue  = cached_LA1
				if ((_givenValue == char('f'))): // 1831
					_saveIndex = text.Length
					match('f')
					text.Length = _saveIndex
				elif ((_givenValue == char('F'))): // 1831
					_saveIndex = text.Length
					match('F')
					text.Length = _saveIndex
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
		
		_cnt321 as int = 0
		while true:
			if ((((cached_LA1 >= char('0')) and (cached_LA1 <= char('9'))))):
				mDIGIT(false)
			else:
				if (_cnt321 >= 1):
					goto _loop321_breakloop
				else:
					raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
			++_cnt321
		:_loop321_breakloop
		if ((cached_LA1==char('E') or cached_LA1==char('e'))):
			mEXPONENT(false)
		else: // line 2053
			pass // 947
		_givenValue  = cached_LA1
		if ((_givenValue == char('f'))): // 1831
			_saveIndex = text.Length
			match('f')
			text.Length = _saveIndex
		elif ((_givenValue == char('F'))): // 1831
			_saveIndex = text.Length
			match('F')
			text.Length = _saveIndex
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
		_cnt328 as int = 0
		while true:
			if ((((cached_LA1 >= char('0')) and (cached_LA1 <= char('9'))))):
				mDIGIT(false)
			else:
				if (_cnt328 >= 1):
					goto _loop328_breakloop
				else:
					raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
			++_cnt328
		:_loop328_breakloop
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
	
	public def mHASH(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = HASH
		
		match('#')
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
	
	public def mNOT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = NOT
		
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
	
	public def mONES_COMPLEMENT(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = ONES_COMPLEMENT
		
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
		if ((cached_LA1==char('s'))):
			match("script")
			if 0 == inputState.guessing:
				_ttype = SCRIPT_ATTRIBUTE_MARKER; 
		else: // line 2053
			pass // 947
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mDIVISION(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = DIVISION
		
		synPredMatched376 as bool = false
		if ((cached_LA1==char('/')) and (cached_LA2==char('*'))):
			_m376 as int = mark()
			synPredMatched376 = true
			++inputState.guessing
			try:
				match("/*")
			except x as RecognitionException:
				synPredMatched376 = false
			rewind(_m376)
			--inputState.guessing
		if synPredMatched376:
			mML_COMMENT(false)
			if 0 == inputState.guessing:
				_ttype = Token.SKIP; 
		elif ((cached_LA1==char('/')) and (true)): // line 2102
			match('/')
			_givenValue  = cached_LA1
			if ((_givenValue == char('/'))): // 1831
				match('/')
				while true:
					if ((tokenSet_1_.member(cast(int, cached_LA1)))):
						match(tokenSet_1_)
					else:
						goto _loop381_breakloop
				:_loop381_breakloop
				if 0 == inputState.guessing:
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
				goto _loop406_breakloop
		:_loop406_breakloop
		match("*/")
		if 0 == inputState.guessing:
			_ttype = Token.SKIP; 
		if (_createToken and (_token is null) and (_ttype != Token.SKIP)):
			_token = makeToken(_ttype)
			_token.setText(text.ToString(_begin, text.Length-_begin))
		returnToken_ = _token
	
	public def mWHITE_SPACE(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = WHITE_SPACE
		
		_cnt385 as int = 0
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
					if (_cnt385 >= 1):
						goto _loop385_breakloop
					else:
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
			++_cnt385
		:_loop385_breakloop
		if 0 == inputState.guessing:
			_ttype = Token.SKIP;	
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
				goto _loop389_breakloop
		:_loop389_breakloop
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
		elif ((_givenValue == char('$'))): // 1831
			match('$')
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
	
	protected def mRE_LITERAL(_createToken as bool) as void: //throws RecognitionException, CharStreamException, TokenStreamException
		_ttype as int; _token as IToken; _begin = text.Length;
		_ttype = RE_LITERAL
		
		match('/')
		_cnt409 as int = 0
		while true:
			if ((tokenSet_4_.member(cast(int, cached_LA1)))):
				mRE_CHAR(false)
			else:
				if (_cnt409 >= 1):
					goto _loop409_breakloop
				else:
					raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
			++_cnt409
		:_loop409_breakloop
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
		elif ((tokenSet_5_.member(cast(int, cached_LA1)))): // line 2102
			match(tokenSet_5_)
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
			_cnt415 as int = 0
			while true:
				if ((((cached_LA1 >= char('0')) and (cached_LA1 <= char('9')))) and (tokenSet_6_.member(cast(int, cached_LA2))) and (true)):
					mDIGIT(false)
				else:
					if (_cnt415 >= 1):
						goto _loop415_breakloop
					else:
						raise NoViableAltForCharException(cached_LA1, getFilename(), getLine(), getColumn())
				++_cnt415
			:_loop415_breakloop
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
	public static final tokenSet_4_ = BitSet(mk_tokenSet_4_())
	private static def mk_tokenSet_5_() as (long):
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
	public static final tokenSet_5_ = BitSet(mk_tokenSet_5_())
	private static def mk_tokenSet_6_() as (long):
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
	public static final tokenSet_6_ = BitSet(mk_tokenSet_6_())
	
