/*
Wednesday, October 10th 2012
micVerb.scd
prm
*/

var val, toggle, vol, gran;
val = 34;
toggle = 42;
vol = 14;
gran = 12;

OSCdef(\micVerbOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \micVerb } { ~connectOhm[\micVerb].value; }
	{ id == \micVerbToggle } { ~connectOhm[\micVerbToggle].value; }
}, \control, ~scLang);

OSCdef(\micVerbOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \micVerb } {
		if ( val == 1, { ~connectOhmMidi[\micVerb].make } );
	}
}, \restoreOhm);

~connectOhm[\micVerb] = r {
	loop{
		~restoreOhm[\connections].micVerb = 1;
		~connectOhmMidi[\micVerb].make;
		~restoreOhm[\connections].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\connections].page.put(val, \blue);
		~ohm.turnBlue(val).yield;

		~restoreOhm[\connections].micVerb = 0;
		~connectOhmMidi[\micVerb].kill;
		~restoreOhm[\connections].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
};


~connectOhm[\micVerbToggle] = r {
	loop{
		~restoreOhm[\connections].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;

		~restoreOhm[\connections].page.put(toggle, \blue);
		~ohm.turnBlue(toggle).yield;
	};
};

~connectOhmMidi[\micVerb] = { };
~connectOhmMidi[\micVerb].addUniqueMethod(\make, {
	MIDIdef.noteOn(\micVerbToggle, { ~scLang.sendMsg(\micVerb, \toggle) }, toggle);

	MIDIdef.cc(\micVerbVolume, { | val |
		var amp = val.linlin(0, 127, 0, 1);
		~scLang.sendMsg(\micVerb, \volume, amp) }, vol);

	MIDIdef.cc(\micVerbGran, { | val |
		var mix = val.linlin(0, 127, 0, 0.3);
		~scLang.sendMsg(\micVerb, \gran, mix) }, gran);
});
~connectOhmMidi[\micVerb].addUniqueMethod(\kill, {
	MIDIdef(\micVerbVolume).free;
	MIDIdef(\micVerbToggle).free;
	MIDIdef(\micVerbGran).free;
});
