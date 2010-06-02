/*
FaderInvers.FadeIn
Received coroutine
Fader.FadeOut
Received coroutine
False
FaderInvers.FadeOut
Received coroutine
Fader.FadeIn
Received coroutine
True
*/
class Fader extends UnityScript.Tests.MonoBehaviour {
	function FadeIn() {
		print("Fader.FadeIn");
		yield Fade(true);
	}
	
	function FadeOut() {
		print("Fader.FadeOut");
		yield Fade(false);
	}
	
	function Fade(value) {
		yield value;
	}
		
}

class FaderInvers extends Fader {

	function FadeIn() {
		print("FaderInvers.FadeIn");
		yield super.FadeOut();
	}
	
	function FadeOut() {
		print("FaderInvers.FadeOut");
		yield super.FadeIn();
	}
}

function printAll(items) {
	for (var e in items)
		if (e instanceof System.Collections.IEnumerator)
			printAll(e);
		else
			print(e);
}

printAll(new FaderInvers().FadeIn());
printAll(new FaderInvers().FadeOut()); 
