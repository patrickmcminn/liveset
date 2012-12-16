/*
Sunday, December 16th 2012
endSynthOhm.scd
prm
*/


var val, loop, d, dSharp, aOne, cSharpOne, gSharp, aTwo, cSharpTwo, aSix, bMajor, cSharp, vol;
val = 35;
loop = 37;
d = 45;
dSharp = 53;
aOne = 61;
cSharpOne = 38;
gSharp = 46;
aTwo = 54;
cSharpTwo = 62;
aSix = 47;
bMajor = 55;
cSharp = 63;
vol = 24;

OSCdef(\endSynthOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \endSynth } { ~boyOhm[\endSynth].value; }
	{ id == \endSynthLoop } { ~boyOhm[\endSynthLoop].value; }
	{ id == \endSynthD } { ~boyOhm[\endSynthD].value; }
	{ id == \endSynthDSharp } { ~boyOhm[\endSynthDSharp].value; }
	{ id == \endSynthAOne } { ~boyOhm[\endSynthAOne].value; }
	{ id == \endSynthCSharpOne } { ~boyOhm[\endSynthCSharpOne].value; }
	{ id == \endSynthGSharp } { ~boyOhm[\endSynthGSharp].value; }
	{ id == \endSynthATwo } { ~boyOhm[\endSynthATwo] .value; }
	{ id == \endSynthCSharpTwo } { ~boyOhm[\endSynthCSharpTwo].value; }
	{ id == \endSynthASix } { ~boyOhm[\endSynthASix].value; }
	{ id == \endSynthBMajor } { ~boyOhm[\endSynthBMajor].value; }
	{ id == \endSynthCSharp } { ~boyOhm[\endSynthCSharp].value; }
}, \control, ~scLang);


~boyOhm[\endSynth] = r({
	loop {


		~ohm.turnYellow(loop);
		MIDIdef.noteOn(\endSynthLoop, { ~scLang.sendMsg(\endSynth, \loop); }, loop);
		~ohm.turnYellow(d);
		MIDIdef.noteOn(\endSynthD, { ~scLang.sendMsg(\endSynth, \d); }, d);
		~ohm.turnYellow(dSharp);
		MIDIdef.noteOn(\endSynthDSharp, { ~scLang.sendMsg(\endSynth, \dSharp); }, dSharp);
		~ohm.turnYellow(aOne);
		MIDIdef.noteOn(\endSynthAOne, { ~scLang.sendMsg(\endSynth, \aOne); }, aOne);
		~ohm.turnYellow(cSharpOne);
		MIDIdef.noteOn(\endSynthCSharpOne, { ~scLang.sendMsg(\endSynth, \cSharpOne); }, cSharpOne);
		~ohm.turnYellow(gSharp);
		MIDIdef.noteOn(\endSynthGSharp, { ~scLang.sendMsg(\endSynth, \gSharp); }, gSharp);
		~ohm.turnYellow(aTwo);
		MIDIdef.noteOn(\endSynthATwo, { ~scLang.sendMsg(\endSynth, \aTwo); }, aTwo);
		~ohm.turnYellow(cSharpTwo);
		MIDIdef.noteOn(\endSynthCSharpTwo, { ~scLang.sendMsg(\endSynth, \cSharpTwo); }, cSharpTwo);
		~ohm.turnYellow(aSix);
		MIDIdef.noteOn(\endSynthASix, { ~scLang.sendMsg(\endSynth, \aSix); }, aSix);
		~ohm.turnYellow(bMajor);
		MIDIdef.noteOn(\endSynthBMajor, { ~scLang.sendMsg(\endSynth, \bMajor); }, bMajor);
		~ohm.turnYellow(cSharp);
		MIDIdef.noteOn(\endSynthCSharp, { ~scLang.sendMsg(\endSynth, \cSharp); }, cSharp);

		MIDIdef.cc(\endSynthVolume, { | val |
			var amp = val.linlin(0, 127, 0, 1);
			~scLang.sendMsg(\endSynth, \volume, amp); }, vol);

		~ohm.turnPink(val).yield;


		MIDIdef(\endSynthLoop).free;
		MIDIdef(\endSynthD).free;
		MIDIdef(\endSynthDSharp).free;
		MIDIdef(\endSynthAOne).free;
		MIDIdef(\endSynthCSharpOne).free;
		MIDIdef(\endSynthGSharp).free;
		MIDIdef(\endSynthATwo).free;
		MIDIdef(\endSynthCSharpTwo).free;
		MIDIdef(\endSynthASix).free;
		MIDIdef(\endSynthBMajor).free;
		MIDIdef(\endSynthCSharp).free;
		MIDIdef(\endSynthVolume).free;
		~ohm.turnOff(loop);
		~ohm.turnOff(d);
		~ohm.turnOff(dSharp);
		~ohm.turnOff(aOne);
		~ohm.turnOff(cSharpOne);
		~ohm.turnOff(gSharp);
		~ohm.turnOff(aTwo);
		~ohm.turnOff(cSharpTwo);
		~ohm.turnOff(aSix);
		~ohm.turnOff(bMajor);
		~ohm.turnOff(cSharp);
		~ohm.turnRed(val).yield;
	};
});

~boyOhm[\endSynthLoop] = r({
	loop {
		~ohm.turnBlue(loop).yield;

		~ohm.turnRed(loop).yield;
	};
});

~boyOhm[\endSynthD] = r({
	loop {
		~ohm.turnPink(d);
		{ ~ohm.turnYellow(d) }.defer(4).yield;
	};
});

~boyOhm[\endSynthDSharp] = r({
	loop {
		~ohm.turnPink(dSharp);
		{ ~ohm.turnYellow(dSharp); }.defer(6).yield;
	};
});

~boyOhm[\endSynthAMajorOne] = r({
	loop {
		~ohm.turnPink(aOne);
		{ ~ohm.turnYellow(aOne); }.defer(6).yield;
	};
});

~boyOhm[\endSynthCSharpMinorOne] = r({
	loop {
		~ohm.turnPink(cSharpOne);
		{ ~ohm.turnYellow(cSharpOne); }.defer(6).yield;
	}
});

~boyOhm[\endSynthGSharpMinor] = r({
	loop {
		~ohm.turnPink(gSharp);
		{ ~ohm.turnYellow(gSharp); }.defer(8).yield;
	};
});

~boyOhm[\endSynthAMajorTwo] = r({
	loop{
		~ohm.turnPink(aTwo);
		{ ~ohm.turnYellow(aTwo); }.defer(6).yield;
	};
});

~boyOhm[\endSynthCSharpMinorTwo] = r({
	loop {
		~ohm.turnPink(cSharpTwo);
		{ ~ohm.turnYellow(cSharpTwo); }.defer(6).yield;
	};
});

~boyOhm[\endSynthAMajorSix] = r({
	loop {
		~ohm.turnPink(aSix);
		{ ~ohm.turnYellow(aSix); }.defer(12).yield;
	};
});

~boyOhm[\endSynthBMajor] = r({
	loop {
		~ohm.turnPink(bMajor).yield;

		~ohm.turnYellow(bMajor).yield;
	};
});

~boyOhm[\endSynthCSharp] = r({
	loop {
		~ohm.turnPink(cSharp).yield;

		~ohm.turnYellow(cSharp).yield;
	};
});
