/*
Wednesday, December 12th 2012
stabsOhm.scd
prm
*/


var val, toggle, vol;
val = 33;
toggle = 41;
vol = 0;

OSCdef(\stabsOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \stabs } { ~connectOhm[\stabs].value; }
	{ id == \stabsToggle } { ~connnectOhm[\stabsToggle].value; }
}, \control, ~scLang);

OSCdef(\stabsOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \stabs } {
		if ( val == 1, { ~connectOhmMidi[\stabs].make } );
	}
}, \restoreOhm);


~connectOhm[\stabs] = r {
	loop {
		~restoreOhm[\connections].stabs = 1;
		~connectOhmMidi[\stabs].make;
		~restoreOhm[\connections].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\connections].page.put(val, \purple);
		~ohm.turnPurple(val).yield;

		~restoreOhm[\connections].stabs = 0;
		~connectOhmMidi[\stabs].kill;
		~restoreOhm[\connections].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
};


~connectOhm[\stabsToggle] = r {
	loop {
		~restoreOhm[\connections].page.put(toggle, \lavender);
		~ohm.turnLavender(toggle).yield;

		~restoreOhm[\connections].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;
	};
};

~connectOhmMidi[\stabs] = { };
~connectOhmMidi[\stabs].addUniqueMethod(\make, {
	MIDIdef.noteOn(\stabsToggle, { ~scLang.sendMsg(\stabs, \toggle) }, toggle);
	MIDIdef.cc(\stabsVolume, { | val |
		var amp = val.linlin(0, 127, 0, -14.dbamp);
		~scLang.sendMsg(\stabs, \volume, amp) }, vol);
});
~connectOhmMidi[\stabs].addUniqueMethod(\kill, {
	MIDIdef(\stabsVolume).free;
	MIDIdef(\stabsToggle).free;
});
