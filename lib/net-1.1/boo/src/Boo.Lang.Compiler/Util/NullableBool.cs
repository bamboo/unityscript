using System;

namespace Boo.Lang.Compiler.Util
{
	/// <summary>
	/// Summary description for NullableBool.
	/// </summary>
	public struct NullableBool
	{
		public static implicit operator NullableBool(bool value)
		{
			return value ? NullableBool.True : NullableBool.False;
		}

		private bool _value;
		private bool _hasValue;

		private NullableBool(bool value)
		{
			_value = value;
			_hasValue = true;
		}

		public bool Value
		{
			get
			{
				if (!_hasValue) throw new NullReferenceException();
				return _value;
			}
		}

		public bool HasValue
		{
			get { return _hasValue; }
		}

		public bool Equals(bool value)
		{
			return _hasValue && _value == value;
		}

		public static NullableBool False = new NullableBool(false);

		public static NullableBool True = new NullableBool(true);

		public static NullableBool Null = new NullableBool();
	}
}
