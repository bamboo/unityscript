${header}
namespace Boo.Lang.Compiler.Ast
{
	using System;

	public class ${node.Name} : ${node.Name}Impl
	{
		public ${node.Name}()
		{
		}

		public ${node.Name}(LexicalInfo lexicalInfo) : base(lexicalInfo)
		{
		}
	}
}

