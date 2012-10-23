/*
Wednesday, October 17th 2012
connections.scd
prm
*/


// creates OSCdefs for function handling for Connections


OSCdef(\airSputters, { | msg |
	var id, val, toggle;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	case
	{ id == \main } { ~connectMake[\airSputters].value([val, toggle]).postln; }
	{ id == \toggle } { ~connectMake[\airSputtersToggle].value(val).postln; }
}, \airSputters, ~scLang);

OSCdef(\attackRandomizer, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\attackRandomizer].value(val).postln; }
	{ id == \toggle } { ~connectMake[\attackRandomizerToggle].value(val).postln; }
}, \attackRandomizer, ~scLang);

OSCdef(\bassline, { | msg |
	var id, val, toggleOne, toggleTwo;
	id = msg.at(1);
	val = msg.at(2);
	toggleOne = msg.at(3);
	toggleTwo = msg.at(4);
	case
	{ id == \main } { ~connectMake[\basslines].value([val, toggleOne, toggleTwo]).postln; }
	{ id == \one } { ~connectMake[\basslineOne].value(val).postln; }
	{ id == \two } { ~connectMake[\basslineTwo].value(val).postln; }
}, \bassline, ~scLang);

OSCdef(\cascade, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \record } { ~connectMake[\cascadeRecord].value(val).postln; }
	{ id == \main } { ~connectMake[\cascade].value(val).postln; }
	{ id == \toggle } { ~connectMake[\cascadeToggle].value(val).postln; }
}, \cascade, ~scLang);


OSCdef(\droner, { | msg |
	var id, val, toggle, erode, rater;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	erode = msg.at(4);
	rater = msg.at(5);
	case
	{ id == \main } { ~connectMake[\droner].value([val, toggle, erode, rater]).postln; }
	{ id == \toggle } { ~connectMake[\dronerToggle].value(val).postln; }
	{ id == \erodeOn } {
		~connectSynth[\droner].erosion.set(\mix, 0.15);
		~ohm.turnRed(val); }
	{ id == \erodeOff } {
		~connectSynth[\droner].erosion.set(\mix, 0.02);
		~ohm.turnYellow(val); }
	{ id == \rater } { ~connectMake[\dronerRater].value(val); }
}, \droner, ~scLang);


OSCdef(\chords, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \record } { ~connectMake[\chordRecord].value(val).postln; }
	{ id == \sum } { ~connectMake[\chordSum].value(val).postln; }
	{ id == \main } { ~connectMake[\chords].value(val).postln; }
	{ id == \toggle } { ~connectMake[\chordsToggle].value(val).postln; }
}, \chords, ~scLang);


OSCdef(\granDelay, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\granDelay].value(val).postln; }
	{ id == \toggle } { ~connectMake[\granDelayToggle].value(val).postln; }
}, \granDelay, ~scLang);


OSCdef(\inlet, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\inlet].value(val).postln; }
}, \inlet, ~scLang);


OSCdef(\micVerb, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\micVerb].value(val).postln; }
	{ id == \toggle } { ~connectMake[\micVerbToggle].value(val).postln; }
}, \micVerb, ~scLang);


OSCdef(\noteRecord, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\noteRecord].value(val).postln; }
}, \noteRecord, ~scLang);


OSCdef(\stabs, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\stabs].value(val).postln; }
	{ id == \toggle } { ~connectMake[\stabsToggle].value(val).postln; }
}, \stabs, ~scLang);


/*
m = NetAddr("127.0.0.1", 57120);
OSCdef(\testMe, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	//msg.postln;
	//id.postln;
	//val.postln;
	case
	{ id == 1 } { msg.postln; }
	{ id == 2 } { val.postln; }
	{ id == 3 } { (val + 127).postln; }
}, '/tester', m)


m.sendMsg(\tester, 3, 5)
*/