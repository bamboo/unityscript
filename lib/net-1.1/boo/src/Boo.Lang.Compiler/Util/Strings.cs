using System;

namespace Boo.Lang.Compiler.Util
{
	/// <summary>
	/// Summary description for Strings.
	/// </summary>
	public class Strings
	{
		public static bool IsNullOrEmpty(string s)
		{
			return s == null || s.Length == 0;
		}
	}
}
