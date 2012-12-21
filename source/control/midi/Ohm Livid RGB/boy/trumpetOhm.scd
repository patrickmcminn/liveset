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

~boyOhm[\trumpet] = r ({
	loop {
		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\trumpetToggle, { ~scLang.sendMsg(\boyTrumpet, \toggle); }, toggle);

		~ohm.turnBlue(minorThird);
		MIDIdef.noteOn(\trumpetMinor, { ~scLang.sendMsg(\boyTrumpet, \minorThird); }, minorThird);

		~ohm.turnLavender(majorThird);
		MIDIdef.noteOn(\trumpetMajor, { ~scLang.sendMsg(\boyTrumpet, \majorThird); }, majorThird);
		MIDIdef.noteOff(\noTrumpetShift, { ~scLang.sendMsg(\boyTrumpet, \unison); }, [minorThird, majorThird]);

		~ohm.turnBlue(octave);
		MIDIdef.noteOn(\trumpetOctave, { ~scLang.sendMsg(\boyTrumpet, \octave, octave); }, octave);

		MIDIdef.cc(\trumpetVolume, { | val |
			var amp = val.linlin(0, 127, 0, -4.dbamp);
			~scLang.sendMsg(\boyTrumpet, \volume, amp); }, vol);

		~ohm.turnBlue(val).yield;


		~ohm.turnOff(toggle);
		~ohm.turnOff(minorThird);
		~ohm.turnOff(majorThird);
		~ohm.turnOff(octave);
		MIDIdef(\trumpetOctave).free;
		MIDIdef(\trumpetMinor).free;
		MIDIdef(\trumpetMajor).free;
		MIDIdef(\noTrumpetShift).free;
		MIDIdef(\trumpetToggle).free;
		MIDIdef(\trumpetVolume).free;

		~ohm.turnRed(val).yield;
	};
});

~boyOhm[\trumpetToggle] = r({
	loop {
		~ohm.turnRed(toggle).yield;

		~ohm.turnPurple(toggle).yield;
	};
});

~boyOhm[\trumpetOctaveToggle] = r({
	loop {
		~ohm.turnYellow(octave).yield;

		~ohm.turnRed(octave).yield;
	};
});

