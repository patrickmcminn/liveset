/*
Wednesday, October 17th 2012
connections.scd
prm
*/


// creates OSCdefs for function handling for Connections


OSCdef(\airSputters, { | msg |
	var id, val, toggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	vol = msg.at(4);
	case
	{ id == \main } { ~connectMake[\airSputters].value([val, toggle, vol]).postln; }
	{ id == \toggle } { ~connectMake[\airSputtersToggle].value(val).postln; }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~connectSynth[\airSputters].del.set(\amp, amp); }
}, \airSputters, ~scLang);

OSCdef(\attackRandomizer, { | msg |
	var id, val, toggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	vol = msg.at(4);
	case
	{ id == \main } { ~connectMake[\attackRandomizer].value([val, toggle, vol]).postln; }
	{ id == \toggle } { ~connectMake[\attackRandomizerToggle].value(val).postln; }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~connectSynth[\attackRandomizer].pan.set(\amp, amp); }
}, \attackRandomizer, ~scLang);


OSCdef(\bassline, { | msg |
	var id, val, toggleOne, toggleTwo, vol, gran;
	id = msg.at(1);
	val = msg.at(2);
	toggleOne = msg.at(3);
	toggleTwo = msg.at(4);
	vol = msg.at(5);
	gran = msg.at(6);
	case
	{ id == \main } { ~connectMake[\basslines].value([val, toggleOne, toggleTwo, vol, gran]).postln; }
	{ id == \one } { ~connectMake[\basslineOne].value(val).postln; }
	{ id == \two } { ~connectMake[\basslineTwo].value(val).postln; }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, 12.dbamp);
		~connectSynth[\basslines].fader.set(\amp, amp); }
	{ id == \gran } {
		var mix = val.linlin(0, 127, 0, 1.0);
		var adj = val.linlin(0, 127, 1.0, 0.7);
		~connectSynth[\basslines].gran.set(\mix, mix);
		~connectSynth[\basslines].gran.set(\amp, adj);
	}
}, \bassline, ~scLang);


OSCdef(\cascade, { | msg |
	var id, val, toggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	vol = msg.at(4);
	case
	{ id == \record } { ~connectMake[\cascadeRecord].value(val).postln; }
	{ id == \main } { ~connectMake[\cascade].value([val, toggle, vol]).postln; }
	{ id == \toggle } { ~connectMake[\cascadeToggle].value(val).postln; }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~connectSynth[\cascade].pan.set(\amp, amp); }
}, \cascade, ~scLang);


OSCdef(\chords, { | msg |
	var id, val, sum, toggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	sum = msg.at(3);
	toggle = msg.at(4);
	vol = msg.at(5);
	case
	{ id == \record } { ~connectMake[\chordRecord].value(val).postln; }
	{ id == \main } { ~connectMake[\chords].value([val, sum, toggle, vol]).postln; }
	{ id == \sum } { ~connectMake[\chordSum].value(val).postln; }
	{ id == \toggle } { ~connectMake[\chordsToggle].value(val).postln; }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, -10.dbamp);
		~connectSynth[\chords].gran.set(\amp, amp); }
}, \chords, ~scLang);


OSCdef(\droner, { | msg |
	var id, val, toggle, erode, rater, granMix, vol, hiShelf, loShelf, erodeControl;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	erode = msg.at(4);
	rater = msg.at(5);
	granMix = msg.at(6);
	vol = msg.at(7);
	loShelf = msg.at(8);
	hiShelf = msg.at(9);
	erodeControl = msg.at(10);
	case
	{ id == \main } {
		~connectMake[\droner].value([val, toggle, erode, rater, granMix, vol, loShelf, hiShelf, erodeControl]).postln; }
	{ id == \toggle } { ~connectMake[\dronerToggle].value(val).postln; }
	{ id == \erodeOn } {
		~connectSynth[\droner].erosion.set(\mix, 0.15);
		~ohm.turnRed(val); }
	{ id == \erodeOff } {
		~connectSynth[\droner].erosion.set(\mix, 0.02);
		~ohm.turnYellow(val); }
	{ id == \rater } { ~connectMake[\dronerRater].value(val); }
	{ id == \granMix } {
			var mix;
			mix = val.linlin(0, 127, 0, 1);
			~connectSynth[\droner].gran.set(\mix, mix);}
	{ id == \volume } {
		var amp;
		amp = val.linlin(0, 127, 0, -4.dbamp);
		~connectSynth[\droner].fader.set(\amp, amp) }
	{ id == \loShelf } {
		var amp = val.linlin(0, 127, -6.0, 6.0);
		~connectSynth[\droner].loShelf.set(\gain, amp); }
	{ id == \hiShelf } {
		var amp = val.linlin(0, 127, -3.0, 4.0);
		~connectSynth[\droner].hiShelf.set(\gain, amp); }
	{ id == \erodeControl } {
		var amt = val.linlin(0, 127, 0, 0.15);
		~connectSynth[\droner].erosion.set(\mix, amt); }

}, \droner, ~scLang);


OSCdef(\granDelay, { | msg |
	var id, val, toggle, hiShelf, decay, vol;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	hiShelf = msg.at(4);
	decay = msg.at(5);
	vol = msg.at(6);
	case
	{ id == \main } { ~connectMake[\granDelay].value([val, toggle, hiShelf, decay, vol]).postln; }
	{ id == \toggle } { ~connectMake[\granDelayToggle].value(val).postln; }
	{ id == \hiShelf } {
		var gain = val.linlin(0, 127, -6.0, 2);
		~connectSynth[\granDelay].hiShelf.set(\gain, gain); }
	{ id == \decay } {
		var decay = val.linlin(0, 127, 7.0, 45.0);
		~connectSynth[\granDelay].del.set(\decayTime, decay); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~connectSynth[\granDelay].fader.set(\amp, amp); }
}, \granDelay, ~scLang);


OSCdef(\inlet, { | msg |
	var id, val, gran;
	id = msg.at(1);
	val = msg.at(2);
	gran = msg.at(3);
	case
	{ id == \main } { ~connectMake[\inlet].value([val, gran]).postln; }
	{ id == \gran } {
		var mix = val.linlin(0, 127, 0, 1.0);
		~connectSynth[\inlet].gran.set(\mix, mix); }
}, \inlet, ~scLang);


OSCdef(\micVerb, { | msg |
	var id, val, toggle, vol, gran;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	vol = msg.at(4);
	gran = msg.at(5);
	case
	{ id == \main } { ~connectMake[\micVerb].value([val, toggle, vol, gran]).postln; }
	{ id == \toggle } { ~connectMake[\micVerbToggle].value(val).postln; }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, 1);
		~connectSynth[\micVerb].fader.set(\amp, amp); }
	{ id == \gran } {
		var mix = val.linlin(0, 127, 0, 0.3);
		~connectSynth[\micVerb].gran.set(\mix, mix); }
}, \micVerb, ~scLang);


OSCdef(\noteRecord, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\noteRecord].value(val).postln; }
}, \noteRecord, ~scLang);


OSCdef(\stabs, { | msg |
	var id, val, toggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	vol = msg.at(4);
	case
	{ id == \main } { ~connectMake[\stabs].value([val, toggle, vol]).postln; }
	{ id == \toggle } { ~connectMake[\stabsToggle].value(val).postln; }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, -14.dbamp);
		~connectSynth[\stabs].fader.set(\amp, amp); }
}, \stabs, ~scLang);

OSCdef(\transport, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~connectMake[\seeTransport].value(val); }
}, \transport, ~scLang);



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