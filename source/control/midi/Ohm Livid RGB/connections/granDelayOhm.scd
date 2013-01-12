/*
Tuesday, December 12th 2012
granDelayOhm.scd
prm
*/

var val, toggle, hiShelf, decay, vol;
val = 5;
toggle = 13;
hiShelf = 18;
decay = 11;
vol = 21;

OSCdef(\granDelayOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \granDelay } { ~connectOhm[\granDelay].value; }
	{ id == \granDelayToggle } { ~connectOhm[\granDelayToggle].value }
}, \control, ~scLang);

OSCdef(\granDelayOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \granDelay } {
		if ( val == 1, { ~connectOhmMidi[\granDelay].make; } );
	}
}, \restoreOhm);

~connectOhm[\granDelay] = r {
	loop{
		~restoreOhm[\connections].granDelay = 1;
		~connectOhmMidi[\granDelay].make;
		~restoreOhm[\connections].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\connections].page.put(val, \blue);
		~ohm.turnBlue(val).yield;

		~restoreOhm[\connections].granDelay = 0;
		~connectOhmMidi[\granDelay].kill;
		~restoreOhm[\connections].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
};


~connectOhm[\granDelayToggle] = r {
	loop {
		~restoreOhm[\connections].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;

		~restoreOhm[\connections].page.put(toggle, \blue);
		~ohm.turnBlue(toggle).yield;
	};
};


~connectOhmMidi[\granDelay] = { };
~connectOhmMidi[\granDelay].addUniqueMethod(\make, {
	MIDIdef.noteOn(\granDelayToggle, { ~scLang.sendMsg(\granDelay, \toggle)}, toggle);

	MIDIdef.cc(\granDelayHiShelf, { | val |
		var gain = val.linlin(0, 127, -6.0, 2);
		~scLang.sendMsg(\granDelay, \hiShelf, gain)}, hiShelf);
	MIDIdef.cc(\granDelayDecay, { | val |
		var decay = val.linlin(0, 127, 7.0, 45.0);
		~scLang.sendMsg(\granDelay, \decay, decay)}, decay);
	MIDIdef.cc(\granDelayVolume, { | val |
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~scLang.sendMsg(\granDelay, \volume, amp)}, vol);
});
~connectOhmMidi[\granDelay].addUniqueMethod(\kill, {
	MIDIdef(\granDelayToggle).free;
	MIDIdef(\granDelayHiShelf).free;
	MIDIdef(\granDelayDecay).free;
	MIDIdef(\granDelayVolume).free;
});

