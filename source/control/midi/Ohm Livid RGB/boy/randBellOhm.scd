/*
Thursday, December 13th, 2012
randBellOhm.scd
prm
*/


var val, toggle, vol;
val = 2;
toggle = 10;
vol = 19;

OSCdef(\randBellOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \randBell } { ~boyOhm[\randBell].value; }
	{ id == \randBellToggle } { ~boyOhm[\randBellToggle].value; }
}, \control, ~scLang);

OSCdef(\randBellOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \randBell } {
		if (val == 1, { ~boyOhmMidi[\randBell].make } );
	}
}, \restoreOhm);


~boyOhm[\randBell] = r({
	loop {
		~restoreOhm[\boy].randBell = 1;
		~boyOhmMidi[\randBell].make;
		~restoreOhm[\boy].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\boy].page.put(val, \purple);
		~ohm.turnPurple(val).yield;

		~restoreOhm[\boy].randBell = 0;
		~boyOhmMidi[\randBell].kill;
		~restoreOhm[\boy].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\boy].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
});


~boyOhm[\randBellToggle] = r({
	loop {
		~restoreOhm[\boy].page.put(toggle, \pink);
		~ohm.turnPink(toggle).yield;

		~restoreOhm[\boy].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;
	};
});

~boyOhmMidi[\randBell] = { };
~boyOhmMidi[\randBell].addUniqueMethod(\make, {
	MIDIdef.noteOn(\randBellToggle, { ~scLang.sendMsg(\randBell, \toggle); }, toggle);
	MIDIdef.cc(\randBellVolume, { | val |
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~scLang.sendMsg(\randBell, \volume, amp); }, vol);
});
~boyOhmMidi[\randBell].addUniqueMethod(\kill, {
	MIDIdef(\randBellToggle).free;
	MIDIdef(\randBellVolume).free;
});

	