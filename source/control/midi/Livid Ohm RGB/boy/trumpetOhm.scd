/*
Saturday, December 15th 2012
trumpetOhm.scd
prm
*/


var val, toggle, minorThird, majorThird, octave, vol;
val = 32;
toggle = 40;
minorThird = 48;
majorThird = 56;
octave = 57;
vol = 14;

OSCdef(\boyTrumpetOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \boyTrumpet } { ~boyOhm[\trumpet].value; }
	{ id == \boyTrumpetToggle } { ~boyOhm[\trumpetToggle].value; }
	{ id == \boyTrumpetOctaveToggle } { ~boyOhm[\trumpetOctaveToggle].value; }
}, \control, ~scLang);

OSCdef(\boyTrumpetOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \boyTrumpet } {
		if ( val == 1, { ~boyOhmMidi[\trumpet].make; } );
	}
}, \restoreOhm);


~boyOhm[\trumpet] = r ({
	loop {
		~restoreOhm[\boy].boyTrumpet = 1;
		~boyOhmMidi[\trumpet].make;
		~restoreOhm[\boy].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\boy].page.put(minorThird, \blue);
		~ohm.turnBlue(minorThird);
		~restoreOhm[\boy].page.put(majorThird, \lavender);
		~ohm.turnLavender(majorThird);
		~restoreOhm[\boy].page.put(octave, \blue);
		~ohm.turnBlue(octave);
		~restoreOhm[\boy].page.put(val, \blue);
		~ohm.turnBlue(val).yield;

		~restoreOhm[\boy].boyTrumpet = 0;
		~boyOhmMidi[\trumpet].kill;
		~restoreOhm[\boy].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\boy].page.put(minorThird, \off);
		~ohm.turnOff(minorThird);
		~restoreOhm[\boy].page.put(majorThird, \off);
		~ohm.turnOff(majorThird);
		~restoreOhm[\boy].page.put(octave, \off);
		~ohm.turnOff(octave);
		~restoreOhm[\boy].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
});

~boyOhm[\trumpetToggle] = r({
	loop {
		~restoreOhm[\boy].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;

		~restoreOhm[\boy].page.put(toggle, \purple);
		~ohm.turnPurple(toggle).yield;
	};
});

~boyOhm[\trumpetOctaveToggle] = r({
	loop {
		~restoreOhm[\boy].page.put(octave, \yellow);
		~ohm.turnYellow(octave).yield;

		~restoreOhm[\boy].page.put(octave, \red);
		~ohm.turnRed(octave).yield;
	};
});

~boyOhmMidi[\trumpet] = { };
~boyOhmMidi[\trumpet].addUniqueMethod(\make, {
	MIDIdef.noteOn(\trumpetToggle, { ~scLang.sendMsg(\boyTrumpet, \toggle); }, toggle);
	MIDIdef.noteOn(\trumpetMinor, { ~scLang.sendMsg(\boyTrumpet, \minorThird); }, minorThird);
	MIDIdef.noteOn(\trumpetMajor, { ~scLang.sendMsg(\boyTrumpet, \majorThird); }, majorThird);
	MIDIdef.noteOff(\noTrumpetShift, { ~scLang.sendMsg(\boyTrumpet, \unison); }, [minorThird, majorThird]);
	MIDIdef.noteOn(\trumpetOctave, { ~scLang.sendMsg(\boyTrumpet, \octave, octave); }, octave);
	MIDIdef.cc(\trumpetVolume, { | val |
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~scLang.sendMsg(\boyTrumpet, \volume, amp); }, vol);
});
~boyOhmMidi[\trumpet].addUniqueMethod(\kill, {
	MIDIdef(\trumpetOctave).free;
	MIDIdef(\trumpetMinor).free;
	MIDIdef(\trumpetMajor).free;
	MIDIdef(\noTrumpetShift).free;
	MIDIdef(\trumpetToggle).free;
	MIDIdef(\trumpetVolume).free;
});

