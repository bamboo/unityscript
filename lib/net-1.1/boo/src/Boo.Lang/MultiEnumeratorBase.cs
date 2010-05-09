using System;
using System.Collections;

namespace Boo.Lang
{
	public abstract class MultiEnumeratorBase : IDisposable, IEnumerator
	{
		protected readonly IEnumerator[] _enumerators;

		internal MultiEnumeratorBase(params IEnumerator[] enumerators)
		{
			_enumerators = enumerators;
		}

		public void Dispose()
		{
			foreach (IEnumerator e in _enumerators)
			{
				IDisposable d = e as IDisposable;
				if (d != null) d.Dispose();
			}
		}

		public void Reset()
		{
			foreach (IEnumerator e in _enumerators)
				e.Reset();
		}

		public abstract bool MoveNext();

		public abstract object Current
		{
			get;
		}
	}
}