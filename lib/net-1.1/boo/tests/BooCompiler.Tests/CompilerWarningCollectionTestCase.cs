using Boo.Lang.Compiler;
using Boo.Lang.Compiler.Ast;
using NUnit.Framework;

namespace BooCompiler.Tests
{
	[TestFixture]
	public class CompilerWarningCollectionTestCase
	{
		[Test]
		public void TestSuppressWarning()
		{
			CompilerWarningCollection warnings = new CompilerWarningCollection();
			warnings.Adding += new CompilerWarningEventHandler(warnings_Adding);
			warnings.Add(new CompilerWarning(LexicalInfo.Empty, "foo", "foo"));
			Assert.AreEqual(0, warnings.Count);
			warnings.Add(new CompilerWarning(LexicalInfo.Empty, "bar", "bar"));
			Assert.AreEqual(1, warnings.Count);
		}

		private void warnings_Adding(object sender, CompilerWarningEventArgs args)
		{
			if (args.Warning.Code == "foo") args.Cancel();
		}
	}
}
