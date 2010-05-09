
namespace BooCompiler.Tests
{
	using NUnit.Framework;
	using Boo.Lang.Compiler;

	[TestFixture]
	public class CompilerWarningsTestFixture : AbstractCompilerTestCase
	{
		protected override CompilerPipeline SetUpCompilerPipeline()
		{
			CompilerPipeline pipeline = new Boo.Lang.Compiler.Pipelines.Compile();
			pipeline.Add(new Boo.Lang.Compiler.Steps.PrintWarnings());
			return pipeline;
		}

		[Test]
		public void BCW0001_1()
		{
			RunCompilerTestCase(@"BCW0001-1.boo");
		}
		
		[Test]
		public void BCW0001_10()
		{
			RunCompilerTestCase(@"BCW0001-10.boo");
		}
		
		[Test]
		public void BCW0001_4()
		{
			RunCompilerTestCase(@"BCW0001-4.boo");
		}
		
		[Test]
		public void BCW0001_6()
		{
			RunCompilerTestCase(@"BCW0001-6.boo");
		}
		
		[Test]
		public void BCW0001_7()
		{
			RunCompilerTestCase(@"BCW0001-7.boo");
		}
		
		[Test]
		public void BCW0002_1()
		{
			RunCompilerTestCase(@"BCW0002-1.boo");
		}
		
		[Test]
		public void BCW0003_1()
		{
			RunCompilerTestCase(@"BCW0003-1.boo");
		}
		
		[Test]
		public void BCW0003_2()
		{
			RunCompilerTestCase(@"BCW0003-2.boo");
		}
		
		[Test]
		public void BCW0004_1()
		{
			RunCompilerTestCase(@"BCW0004-1.boo");
		}
		
		[Test]
		public void BCW0004_2()
		{
			RunCompilerTestCase(@"BCW0004-2.boo");
		}
		
		[Test]
		public void BCW0005_1()
		{
			RunCompilerTestCase(@"BCW0005-1.boo");
		}
		
		[Test]
		public void BCW0006_1()
		{
			RunCompilerTestCase(@"BCW0006-1.boo");
		}
		
		[Test]
		public void BCW0006_2()
		{
			RunCompilerTestCase(@"BCW0006-2.boo");
		}
		
		[Test]
		public void BCW0007_1()
		{
			RunCompilerTestCase(@"BCW0007-1.boo");
		}
		
		[Test]
		public void BCW0008_1()
		{
			RunCompilerTestCase(@"BCW0008-1.boo");
		}
		
		[Test]
		public void BCW0011_1()
		{
			RunCompilerTestCase(@"BCW0011-1.boo");
		}
		
		[Test]
		public void BCW0011_10()
		{
			RunCompilerTestCase(@"BCW0011-10.boo");
		}
		
		[Test]
		public void BCW0011_2()
		{
			RunCompilerTestCase(@"BCW0011-2.boo");
		}
		
		[Test]
		public void BCW0011_3()
		{
			RunCompilerTestCase(@"BCW0011-3.boo");
		}
		
		[Test]
		public void BCW0011_4()
		{
			RunCompilerTestCase(@"BCW0011-4.boo");
		}
		
		[Test]
		public void BCW0011_5()
		{
			RunCompilerTestCase(@"BCW0011-5.boo");
		}
		
		[Test]
		public void BCW0011_6()
		{
			RunCompilerTestCase(@"BCW0011-6.boo");
		}
		
		[Test]
		public void BCW0011_7()
		{
			RunCompilerTestCase(@"BCW0011-7.boo");
		}
		
		[Test]
		public void BCW0011_8()
		{
			RunCompilerTestCase(@"BCW0011-8.boo");
		}
		
		[Test]
		public void BCW0011_9()
		{
			RunCompilerTestCase(@"BCW0011-9.boo");
		}
		
		[Test]
		public void BCW0012_1()
		{
			RunCompilerTestCase(@"BCW0012-1.boo");
		}
		
		[Test]
		public void BCW0013_1()
		{
			RunCompilerTestCase(@"BCW0013-1.boo");
		}
		
		[Test]
		public void BCW0013_2()
		{
			RunCompilerTestCase(@"BCW0013-2.boo");
		}
		
		[Test]
		public void BCW0013_3()
		{
			RunCompilerTestCase(@"BCW0013-3.boo");
		}
		
		[Test]
		public void BCW0014_1()
		{
			RunCompilerTestCase(@"BCW0014-1.boo");
		}
		
		[Test]
		public void BCW0014_2()
		{
			RunCompilerTestCase(@"BCW0014-2.boo");
		}
		
		[Test]
		public void BCW0015_1()
		{
			RunCompilerTestCase(@"BCW0015-1.boo");
		}
		
		[Test]
		public void BCW0015_2()
		{
			RunCompilerTestCase(@"BCW0015-2.boo");
		}
		
		[Test]
		public void BCW0015_3()
		{
			RunCompilerTestCase(@"BCW0015-3.boo");
		}
		
		[Test]
		public void BCW0015_4()
		{
			RunCompilerTestCase(@"BCW0015-4.boo");
		}
		
		[Test]
		public void BCW0016_1()
		{
			RunCompilerTestCase(@"BCW0016-1.boo");
		}
		
		[Test]
		public void BCW0017_1()
		{
			RunCompilerTestCase(@"BCW0017-1.boo");
		}
		
		[Test]
		public void BCW0018_1()
		{
			RunCompilerTestCase(@"BCW0018-1.boo");
		}
		

		override protected string GetRelativeTestCasesPath()
		{
			return "warnings";
		}
	}
}
