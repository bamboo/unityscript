/*
yes
yes
*/
class Component {
	static function op_Implicit(self: Component): boolean {
		return self.enabled;
	}
	
	function Component(enabled: boolean) {
		this.enabled = enabled;
	}
	
	private var enabled: boolean;
}

class Rigidbody extends Component {
	function Rigidbody() {
		super(false);
	}
	
	function get isKinematic() {
		return true;
	}
}

class Collider extends Component {
	function Collider() {
		super(true);
	}
}

class Behaviour extends Component {
	
	function Behaviour() { super(true); }
	
	function get rigidbody() { return new Rigidbody(); }
	function get collider() { return new Collider(); }
}

class Foo extends Behaviour {
	function Start() {
		
		if (rigidbody && rigidbody.isKinematic)
			print("fail");
		else
			print("yes");
		
		if (!collider)
			print("fail");
		else
			print("yes");
	}
}

new Foo().Start();
