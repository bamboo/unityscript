/*
Right
*/

DuckyFunction (this);
if (this.transform.position.x == 500.0 + 200.0) {
	print ("Right");
} else {
    print(this.transform.position.x);
}

function DuckyFunction (value) {
	value.transform.position.x = 500.0;
	value.transform.position.x += 200.0;
}