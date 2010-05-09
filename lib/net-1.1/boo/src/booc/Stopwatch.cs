using System;

namespace booc
{
	public class Stopwatch
	{
		private DateTime _started;
		private TimeSpan _elapsed;

		public static Stopwatch StartNew()
		{
			return new Stopwatch();
		}

		private Stopwatch()
		{
			_started = DateTime.Now;
		}


		public void Stop()
		{
			_elapsed = DateTime.Now - _started;
		}

		public double ElapsedMilliseconds
		{
			get { return _elapsed.TotalMilliseconds; }
		}
	}
}
