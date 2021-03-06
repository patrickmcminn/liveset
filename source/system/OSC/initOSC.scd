/*
Wednesday, October 17th 2012
initOSC.scd
prm
*/

~scLang = NetAddr("127.0.0.1", 57120);

OSCdef(\server, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \boot } { ~server.boot; }
	{ id == \quit } { ~server.quit; }
	{ id == \memSize } { ~server.memSize(val) }
}, '\server', ~scLang);


OSCdef(\mixer, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \master } { ~mixerSynth[\master].set(\amp, val); }
	{ id == \s1 } { ~mixerSynth[\s1].set(\amp, val); }
	{ id == \s2 } { ~mixerSynth[\s2].set(\amp, val); }
	{ id == \s3 } { ~mixerSynth[\s3].set(\amp, val); }
	{ id == \input } {  ~instI[\mute].set(\amp, val); }
}, '\mixer', ~scLang);

OSCdef(\clear, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \connections } {~connections[\clear].value; }
	{ id == \birds } { ~birds[\clear].value; }
	{ id == \boy } { ~boy[\clear].value; }
}, \clear);



/*
OSCdef(\test, { | msg |
		var id, val;
		id = msg.at(1);
		val = msg.at(2);
		case
		{ id == \doobie } { (val ++ " is a strange word.").postln; }
	}, '\test', ~scLang)

~scLang.sendMsg('\test', \doobie, "Gargle")
	*/