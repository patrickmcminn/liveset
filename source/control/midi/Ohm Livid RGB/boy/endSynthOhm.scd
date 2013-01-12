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
	{ id == \endSynthAOne } { ~boyOhm[\endSynthAMajorOne].value; }
	{ id == \endSynthCSharpOne } { ~boyOhm[\endSynthCSharpMinorOne].value; }
	{ id == \endSynthGSharp } { ~boyOhm[\endSynthGSharpMinor].value; }
	{ id == \endSynthATwo } { ~boyOhm[\endSynthAMajorTwo] .value; }
	{ id == \endSynthCSharpTwo } { ~boyOhm[\endSynthCSharpMinorTwo].value; }
	{ id == \endSynthASix } { ~boyOhm[\endSynthAMajorSix].value; }
	{ id == \endSynthBMajor } { ~boyOhm[\endSynthBMajor].value; }
	{ id == \endSynthCSharp } { ~boyOhm[\endSynthCSharp].value; }
}, \control, ~scLang);

OSCdef(\endSynthRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \endSynth } {
		if ( val == 1, { ~boyOhmMidi[\endSynth].make; } );
	}
}, \restoreOhm);



~boyOhm[\endSynth] = r({
	loop {
		~restoreOhm[\boy].endSynth = 1;
		~boyOhmMidi[\endSynth].make;
		~restoreOhm[\boy].page.put(loop, \yellow);
		~ohm.turnYellow(loop);
		~restoreOhm[\boy].page.put(d, \yellow);
		~ohm.turnYellow(d);
		~restoreOhm[\boy].page.put(dSharp, \yellow);
		~ohm.turnYellow(dSharp);
		~restoreOhm[\boy].page.put(aOne, \yellow);
		~ohm.turnYellow(aOne);
		~restoreOhm[\boy].page.put(cSharpOne, \yellow);
		~ohm.turnYellow(cSharpOne);
		~restoreOhm[\boy].page.put(gSharp, \yellow);
		~ohm.turnYellow(gSharp);
		~restoreOhm[\boy].page.put(aTwo, \yellow);
		~ohm.turnYellow(aTwo);
		~restoreOhm[\boy].page.put(cSharpTwo, \yellow);
		~ohm.turnYellow(cSharpTwo);
		~restoreOhm[\boy].page.put(aSix, \yellow);
		~ohm.turnYellow(aSix);
		~restoreOhm[\boy].page.put(bMajor, \yellow);
		~ohm.turnYellow(bMajor);
		~restoreOhm[\boy].page.put(cSharp, \yellow);
		~ohm.turnYellow(cSharp);
		~restoreOhm[\boy].page.put(val, \pink);
		~ohm.turnPink(val).yield;

		~restoreOhm[\boy].endSynth = 0;
		~boyOhmMidi[\endSynth].kill;
		~restoreOhm[\boy].page.put(loop, \off);
		~ohm.turnOff(loop);
		~restoreOhm[\boy].page.put(d, \off);
		~ohm.turnOff(d);
		~restoreOhm[\boy].page.put(dSharp, \off);
		~ohm.turnOff(dSharp);
		~restoreOhm[\boy].page.put(aOne, \off);
		~ohm.turnOff(aOne);
		~restoreOhm[\boy].page.put(cSharpOne, \off);
		~ohm.turnOff(cSharpOne);
		~restoreOhm[\boy].page.put(gSharp, \off);
		~ohm.turnOff(gSharp);
		~restoreOhm[\boy].page.put(aTwo, \off);
		~ohm.turnOff(aTwo);
		~restoreOhm[\boy].page.put(cSharpTwo, \off);
		~ohm.turnOff(cSharpTwo);
		~restoreOhm[\boy].page.put(aSix, \off);
		~ohm.turnOff(aSix);
		~restoreOhm[\boy].page.put(bMajor, \off);
		~ohm.turnOff(bMajor);
		~restoreOhm[\boy].page.put(cSharp, \off);
		~ohm.turnOff(cSharp);
		~restoreOhm[\boy].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
});



~boyOhm[\endSynthLoop] = r({
	loop {
		~restoreOhm[\boy].page.put(loop, \blue);
		~ohm.turnBlue(loop).yield;

		~restoreOhm[\boy].page.put(loop, \red);
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
		~restoreOhm[\boy].page.put(cSharp, \pink);
		~ohm.turnPink(cSharp).yield;

		~restoreOhm[\boy].page.put(cSharp, \yellow);
		~ohm.turnYellow(cSharp).yield;
	};
});

~boyOhmMidi[\endSynth] = { };
~boyOhmMidi[\endSynth].addUniqueMethod(\make, {
	MIDIdef.noteOn(\endSynthLoop, { ~scLang.sendMsg(\endSynth, \loop); }, loop);
	MIDIdef.noteOn(\endSynthD, { ~scLang.sendMsg(\endSynth, \d); }, d);
	MIDIdef.noteOn(\endSynthDSharp, { ~scLang.sendMsg(\endSynth, \dSharp); }, dSharp);
	MIDIdef.noteOn(\endSynthAOne, { ~scLang.sendMsg(\endSynth, \aOne); }, aOne);
	MIDIdef.noteOn(\endSynthCSharpOne, { ~scLang.sendMsg(\endSynth, \cSharpOne); }, cSharpOne);
	MIDIdef.noteOn(\endSynthGSharp, { ~scLang.sendMsg(\endSynth, \gSharp); }, gSharp);
	MIDIdef.noteOn(\endSynthATwo, { ~scLang.sendMsg(\endSynth, \aTwo); }, aTwo);
	MIDIdef.noteOn(\endSynthCSharpTwo, { ~scLang.sendMsg(\endSynth, \cSharpTwo); }, cSharpTwo);
	MIDIdef.noteOn(\endSynthASix, { ~scLang.sendMsg(\endSynth, \aSix); }, aSix);
	MIDIdef.noteOn(\endSynthBMajor, { ~scLang.sendMsg(\endSynth, \bMajor); }, bMajor);
	MIDIdef.noteOn(\endSynthCSharp, { ~scLang.sendMsg(\endSynth, \cSharp); }, cSharp);
	MIDIdef.cc(\endSynthVolume, { | val |
		var amp = val.linlin(0, 127, 0, 1);
		~scLang.sendMsg(\endSynth, \volume, amp); }, vol);
});

~boyOhmMidi[\endSynth].addUniqueMethod(\kill, {
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
});

