/*
Wednesday, December 12th 2012
cascadeOhm.scd
prm
*/

var val, toggle, vol;
val = 7;
toggle = 15;
vol = 3;

OSCdef(\cascadeOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \cascade } { ~connectOhm[\cascade].value; }
	{ id == \cascadeToggle } { ~connectOhm[\cascadeToggle].value; }
}, \control, ~scLang);

OSCdef(\cascadeOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \cascade } {
		if ( val == 1, { ~connectOhmMidi[\cascade].make } )
	}
}, \restoreOhm);

~connectOhm[\cascade] = r {
	loop {
		~restoreOhm[\connections].cascade = 1;
		~connectOhmMidi[\cascade].make;
		~restoreOhm[\connections].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\connections].page.put(val, \lavender);
		~ohm.turnLavender(val).yield;

		~restoreOhm[\connections].cascade = 0;
		~connectOhmMidi[\cascade].kill;
		~restoreOhm[\connections].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
};


~connectOhm[\cascadeToggle] = r { | val |
	loop {
		~restoreOhm[\connections].page.put(toggle, \pink);
		~ohm.turnPink(toggle).yield;

		~restoreOhm[\connections].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;
	};
};

~connectOhmMidi[\cascade] = { };
~connectOhmMidi[\cascade].addUniqueMethod(\make, {
	MIDIdef.noteOn(\cascadeToggle, { ~scLang.sendMsg(\cascade, \toggle)}, toggle);
	MIDIdef.cc(\cascadeVolume, { | val |
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~scLang.sendMsg(\cascade, \volume, amp)}, vol);
});
~connectOhmMidi[\cascade].addUniqueMethod(\kill, {
	MIDIdef(\cascadeVolume).free;
	MIDIdef(\cascadeToggle).free;
});
