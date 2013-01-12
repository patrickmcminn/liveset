/*
Wednesday, December 12th 2012
attackRandomizerOhm.scd
prm
*/

var val, toggle, vol;
val = 6;
toggle = 14;
vol = 2;

OSCdef(\attackRandomizerOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \attackRandomizer } { ~connectOhm[\attackRandomizer].value; }
	{ id == \attackRandomizerToggle } { ~connectOhm[\attackRandomizerToggle].value; }
}, \control, ~scLang);

OSCdef(\attackRandomizerOhmRestore,{ | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \attackRandomizer } {
		if ( val == 1, { ~connectOhmMidi[\attackRandomizer].make; } )
	}
}, \restoreOhm);

~connectOhm[\attackRandomizer] = r {
	loop {
		~restoreOhm[\connections].attackRandomizer = 1;
		~connectOhmMidi[\attackRandomizer].make;
		~restoreOhm[\connections].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\connections].page.put(val, \purple);
		~ohm.turnPurple(val).yield;

		~restoreOhm[\connections].attackRandomizer = 0;
		~connectOhmMidi[\attackRandomizer].kill;
		~restoreOhm[\connections].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
};

~connectOhm[\attackRandomizerToggle] = r {
	loop {
		~restoreOhm[\connections].page.put(toggle, \pink);
		~ohm.turnPink(toggle).yield;

		~restoreOhm[\connections].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;
	};
};


~connectOhmMidi[\attackRandomizer] = { };
~connectOhmMidi[\attackRandomizer].addUniqueMethod(\make, {
	MIDIdef.noteOn(\attackRandomizerToggle, { ~scLang.sendMsg(\attackRandomizer, \toggle) }, toggle);

	MIDIdef.cc(\attackRandomizerVolume, { | val |
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~scLang.sendMsg(\attackRandomizer, \volume, amp) }, vol);
});
~connectOhmMidi[\attackRandomizer].addUniqueMethod(\kill, {
		MIDIdef(\attackRandomizerToggle).free;
		MIDIdef(\attackRandomizerVolume).free;
});

