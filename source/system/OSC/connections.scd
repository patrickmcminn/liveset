/*
Wednesday, October 17th 2012
connections.scd
prm
*/


// creates OSCdefs for function handling for Connections


OSCdef(\airSputters, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\airSputters].value; }
	{ id == \toggle } { ~connectMake[\airSputtersToggle].value; }
	{ id == \volume } { ~connectSynth[\airSputters].del.set(\amp, val); }
}, \airSputters, ~scLang);


OSCdef(\attackRandomizer, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\attackRandomizer].value; }
	{ id == \toggle } { ~connectMake[\attackRandomizerToggle].value; }
	{ id == \volume } { ~connectSynth[\attackRandomizer].pan.set(\amp, val); }
}, \attackRandomizer, ~scLang);


OSCdef(\bassline, { | msg |
	var id, val, val2;
	id = msg.at(1);
	val = msg.at(2);
	val2 = msg.at(3);
	case
	{ id == \main } { ~connectMake[\basslines].value; }
	{ id == \one } { ~connectMake[\basslineOne].value; }
	{ id == \two } { ~connectMake[\basslineTwo].value; }
	{ id == \volume } { ~connectSynth[\basslines].fader.set(\amp, val); }
	{ id == \gran } {
		~connectSynth[\basslines].gran.set(\mix, val);
		~connectSynth[\basslines].gran.set(\amp, val2);
	}
}, \bassline, ~scLang);


OSCdef(\cascade, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \record } { ~connectMake[\cascadeRecord].value; }
	{ id == \main } { ~connectMake[\cascade].value; }
	{ id == \toggle } { ~connectMake[\cascadeToggle].value; }
	{ id == \volume } { ~connectSynth[\cascade].pan.set(\amp, val); }
}, \cascade, ~scLang);


OSCdef(\chords, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \record } { ~connectMake[\chordRecord].value; }
	{ id == \main } { ~connectMake[\chords].value; }
	{ id == \sum } { ~connectMake[\chordSum].value; }
	{ id == \toggle } { ~connectMake[\chordsToggle].value; }
	{ id == \volume } { ~connectSynth[\chords].gran.set(\amp, val); }
}, \chords, ~scLang);


OSCdef(\droner, { | msg |

	var id = msg.at(1);
	var val = msg.at(2);

	case
	{ id == \main } {~connectMake[\droner].value; }
	{ id == \toggle } { ~connectMake[\dronerToggle].value; }
	{ id == \erodeOn } { ~connectSynth[\droner].erosion.set(\mix, 0.15);
		~scLang.sendMsg(\control, \dronerErodeOn);
	}
	{ id == \erodeOff } { ~connectSynth[\droner].erosion.set(\mix, 0.02);
		~scLang.sendMsg(\control, \dronerErodeOff);
	}
	{ id == \rater } { ~connectMake[\dronerRater].value; }
	{ id == \granMix } { ~connectSynth[\droner].gran.set(\mix, val);}
	{ id == \volume } { ~connectSynth[\droner].fader.set(\amp, val) }
	{ id == \loShelf } { ~connectSynth[\droner].loShelf.set(\gain, val); }
	{ id == \hiShelf } { ~connectSynth[\droner].hiShelf.set(\gain, val); }
	{ id == \erodeControl } { ~connectSynth[\droner].erosion.set(\mix, val); }
}, \droner, ~scLang);


OSCdef(\granDelay, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\granDelay].value; }
	{ id == \toggle } { ~connectMake[\granDelayToggle].value; }
	{ id == \hiShelf } { ~connectSynth[\granDelay].hiShelf.set(\gain, val); }
	{ id == \decay } { ~connectSynth[\granDelay].del.set(\decayTime, val); }
	{ id == \volume } { ~connectSynth[\granDelay].fader.set(\amp, val); }
}, \granDelay, ~scLang);


OSCdef(\inlet, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\inlet].value; }
	{ id == \gran } { ~connectSynth[\inlet].gran.set(\mix, val); }
}, \inlet, ~scLang);


OSCdef(\micVerb, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\micVerb].value; }
	{ id == \toggle } { ~connectMake[\micVerbToggle].value; }
	{ id == \volume } { ~connectSynth[\micVerb].fader.set(\amp, val); }
	{ id == \gran } { ~connectSynth[\micVerb].gran.set(\mix, val); }
}, \micVerb, ~scLang);


OSCdef(\noteRecord, { | msg |
	var id, val;
	id = msg.at(1);
	case
	{ id == \main } { ~connectMake[\noteRecord].value; }
}, \noteRecord, ~scLang);


OSCdef(\stabs, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\stabs].value; }
	{ id == \toggle } { ~connectMake[\stabsToggle].value; }
	{ id == \volume } { ~connectSynth[\stabs].fader.set(\amp, val); }
}, \stabs, ~scLang);

OSCdef(\transport, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\seeTransport].value; }
}, \connectionsTransport, ~scLang);



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