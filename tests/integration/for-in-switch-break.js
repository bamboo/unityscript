/*
5
4
3
2
JS for: Boom
5
4
3
2
JS for in: Boom
*/
function Start() {
	for (var a=1; a<=2; ++a) {
		switch (a) {
			case 1:
				for (var b=5; b>0; b--) {
					print(b);
					if (b == 2) {
						break;
					}
				}
				print("JS for: Boom");
				break;
			
			case 2:
				var ts : int[] = [5,4,3,2,1,0];
				for (var t in ts) {
					print(t);
					if (t == 2) {
						break;
					}
				}
				print("JS for in: Boom");
				break;
		}
	}
}

Start();

