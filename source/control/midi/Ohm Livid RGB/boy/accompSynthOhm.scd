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

~boyOhm[\accompSynth] = r({
	loop {
		~ohm.turnPurple(one);
		MIDIdef.noteOn(\accompSynthPhraseOne, { ~scLang.sendMsg(\accompSynth, \one, one); }, one);

		~ohm.turnPurple(two);
		MIDIdef.noteOn(\accompSynthPhraseTwo, { ~scLang.sendMsg(\accompSynth, \two, two);}, two);

		~ohm.turnPurple(three);
		MIDIdef.noteOn(\accompSynthPhraseThree, { ~scLang.sendMsg(\accompSynth, \three, three); "dongs".postln; }, three);

		MIDIdef.cc(\accompSynthVolume, { | val |
			var amp = val.linlin(0, 127, 0, -2.dbamp);
			~scLang.sendMsg(\accompSynth, \volume, amp); }, vol);

		~ohm.turnPink(val).yield;


		~ohm.turnOff(one);
		~ohm.turnOff(two);
		~ohm.turnOff(three);
		MIDIdef(\accompSynthPhraseOne).free;
		MIDIdef(\accompSynthPhraseTwo).free;
		MIDIdef(\accompSynthPhraseThree).free;
		MIDIdef(\accompSynthVolume).free;
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