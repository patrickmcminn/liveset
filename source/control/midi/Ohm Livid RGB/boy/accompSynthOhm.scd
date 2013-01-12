/*
Sunday, December 16th, 2012
accompSynthOhm.scd
prm
*/


var val, one, two, three, vol;
val = 34;
one = 42;
two = 50;
three = 58;
vol = 12;

OSCdef(\accompSynthOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \accompSynth } { ~boyOhm[\accompSynth].value; }
	{ id == \accompSynthPhraseOne } { ~boyOhm[\accompSynthPhraseOne].value; }
	{ id == \accompSynthPhraseTwo } { ~boyOhm[\accompSynthPhraseTwo].value; }
	{ id == \accompSynthPhraseThree } { ~boyOhm[\accompSynthPhraseThree].value; }
}, \control, ~scLang);

OSCdef(\accompSynthOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \accompSynth } {
		if ( val == 1, { ~boyOhmMidi[\accompSynth].make; } )
	}
}, \restoreOhm);

~boyOhm[\accompSynth] = r({
	loop {
		~restoreOhm[\boy].accompSynth = 1;
		~boyOhmMidi[\accompSynth].make;
		~restoreOhm[\boy].page.put(one, \purple);
		~ohm.turnPurple(one);
		~restoreOhm[\boy].page.put(two, \purple);
		~ohm.turnPurple(two);
		~restoreOhm[\boy].page.put(three, \purple);
		~ohm.turnPurple(three);
		~restoreOhm[\boy].page.put(val, \pink);
		~ohm.turnPink(val).yield;

		~restoreOhm[\boy].accompSynth = 0;
		~boyOhmMidi[\accompSynth].kill;
		~restoreOhm[\boy].page.put(one, \off);
		~ohm.turnOff(one);
		~restoreOhm[\boy].page.put(two, \off);
		~ohm.turnOff(two);
		~restoreOhm[\boy].page.put(three, \off);
		~ohm.turnOff(three);
		~restoreOhm[\boy].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
});


~boyOhm[\accompSynthPhraseOne] = r({
	loop {
		~ohm.turnPink(one);
		{ ~ohm.turnPurple(one); }.defer(7).yield;
	};
});

~boyOhm[\accompSynthPhraseTwo] = r({
	loop {
		~ohm.turnPink(two);
		{ ~ohm.turnPurple(two); }.defer(5).yield;
	};
});

~boyOhm[\accompSynthPhraseThree] = r({
	loop {
		~ohm.turnPink(three);
		{ ~ohm.turnPurple(three); }.defer(4.6).yield;
	};
});


~boyOhmMidi[\accompSynth] = { };
~boyOhmMidi[\accompSynth].addUniqueMethod(\make, {
	MIDIdef.noteOn(\accompSynthPhraseOne, { ~scLang.sendMsg(\accompSynth, \one, one); }, one);
	MIDIdef.noteOn(\accompSynthPhraseTwo, { ~scLang.sendMsg(\accompSynth, \two, two);}, two);
	MIDIdef.noteOn(\accompSynthPhraseThree, { ~scLang.sendMsg(\accompSynth, \three, three); "dongs".postln; }, three);

	MIDIdef.cc(\accompSynthVolume, { | val |
		var amp = val.linlin(0, 127, 0, -2.dbamp);
		~scLang.sendMsg(\accompSynth, \volume, amp); }, vol);
});
~boyOhmMidi[\accompSynth].addUniqueMethod(\kill, {
	MIDIdef(\accompSynthPhraseOne).free;
	MIDIdef(\accompSynthPhraseTwo).free;
	MIDIdef(\accompSynthPhraseThree).free;
	MIDIdef(\accompSynthVolume).free;
});