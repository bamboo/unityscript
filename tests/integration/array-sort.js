/*
NoteEvent(1),NoteEvent(42)
*/
class NoteEvent {
	var startTime: int;
	
	function NoteEvent(startTime: int) {
		this.startTime = startTime;
	}
	
	function ToString() {
		return "NoteEvent(" + startTime + ")";
	}
	
    static function Compare(lhs: NoteEvent, rhs: NoteEvent) {
    
        if (lhs.startTime < rhs.startTime)
            return -1;
        else if (lhs.startTime > rhs.startTime)
            return 1;
        else
            return 0;
    }
}

var array: Array = new Array();
array.Add(new NoteEvent(42));
array.Add(new NoteEvent(1));
array.Sort(NoteEvent.Compare);
print(array);

