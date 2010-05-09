
namespace BooCompiler.Tests
{
	using NUnit.Framework;

	[TestFixture]
	public class MacrosTestFixture : AbstractCompilerTestCase
	{

		[Test]
		public void assert_1()
		{
			RunCompilerTestCase(@"assert-1.boo");
		}
		
		[Test]
		public void debug_1()
		{
			RunCompilerTestCase(@"debug-1.boo");
		}
		
		[Test]
		public void macro_1()
		{
			RunCompilerTestCase(@"macro-1.boo");
		}
		
		[Test]
		public void macro_2()
		{
			RunCompilerTestCase(@"macro-2.boo");
		}
		
		[Test]
		public void macro_attribute_fpa()
		{
			RunCompilerTestCase(@"macro-attribute-fpa.boo");
		}
		
		[Test]
		public void print_1()
		{
			RunCompilerTestCase(@"print-1.boo");
		}
		
		[Test]
		public void print_2()
		{
			RunCompilerTestCase(@"print-2.boo");
		}
		
		[Test]
		public void using_1()
		{
			RunCompilerTestCase(@"using-1.boo");
		}
		
		[Test]
		public void using_2()
		{
			RunCompilerTestCase(@"using-2.boo");
		}
		
		[Test]
		public void using_3()
		{
			RunCompilerTestCase(@"using-3.boo");
		}
		
		[Test]
		public void using_4()
		{
			RunCompilerTestCase(@"using-4.boo");
		}
		
		[Test]
		public void using_5()
		{
			RunCompilerTestCase(@"using-5.boo");
		}
		
		[Test]
		public void yieldAll_1()
		{
			RunCompilerTestCase(@"yieldAll-1.boo");
		}
		

		override protected string GetRelativeTestCasesPath()
		{
			return "macros";
		}
	}
}
