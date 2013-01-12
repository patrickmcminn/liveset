/*
Monday, December 17th 2012
birdsMicVerbOhm.scd
prm
*/

var val, toggle, vol;
val = 5;
toggle = 13;
vol = 21;

OSCdef(\birdsMicVerbOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \birdsMicVerb } { ~birdsOhm[\birdsMicVerb].value; }
	{ id == \birdsMicVerbToggle } { ~birdsOhm[\birdsMicVerbToggle].value; }
}, \control, ~scLang);

OSCdef(\birdsMicVerbOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \birdsMicVerb } {
		if (val == 1, { ~birdsOhmMidi[\birdsMicVerb].make; } );
	}
}, \restoreOhm);


~birdsOhm[\birdsMicVerb] = r ({
	loop {
		~restoreOhm[\birds].birdsMicVerb = 1;
		~birdsOhmMidi[\birdsMicVerb].make;
		~restoreOhm[\birds].page.put(toggle, \blue);
		~ohm.turnBlue(toggle);
		~restoreOhm[\birds].page.put(val, \purple);
		~ohm.turnPurple(val).yield;

		~restoreOhm[\birds].birdsMicVerb = 0;
		~birdsOhmMidi[\birdsMicVerb].kill;
		~restoreOhm[\birds].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\birds].page.put(val, \red);
		~ohm.turnRed(val).yield;

	}
});

~birdsOhm[\birdsMicVerbToggle] = r ({
	loop {
		~restoreOhm[\birds].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;

		~restoreOhm[\birds].page.put(toggle, \blue);
		~ohm.turnBlue(toggle).yield;
	}
});

~birdsOhmMidi[\birdsMicVerb] = { };
~birdsOhmMidi[\birdsMicVerb].addUniqueMethod(\make, {
	MIDIdef.noteOn(\birdsMicVerbToggle, { ~scLang.sendMsg(\birdsMicVerb, \toggle, toggle); }, toggle);
	MIDIdef.cc(\birdsMicVerbVolume, { | val |
		var amp = val.linlin(0, 127, 0, 1);
		~scLang.sendMsg(\birdsMicVerb, \volume, amp); }, vol);
});
~birdsOhmMidi[\birdsMicVerb].addUniqueMethod(\kill, {
	MIDIdef(\birdsMicVerbToggle).free;
	MIDIdef(\birdsMicVerbVolume).free;
});

