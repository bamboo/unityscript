using System;

namespace UnityScript.Tests.CSharp
{
	public static class MultidimensionalArrays
	{
		public static int[,,] GetArray(int i, int j, int k)
		{
			var array = new int[i, j, k];
			for (var ii=0; ii<i; ++ii)
				for (var jj=0; jj<j; ++jj)
					for (var kk=0; kk<k; ++kk)
						array[ii, jj, kk] = ii + jj + kk;
			return array;
		}
	}
}

