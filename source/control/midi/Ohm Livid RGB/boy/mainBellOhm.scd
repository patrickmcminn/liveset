/*
Thursday, December 13th 2012
mainBellOhm.scd
prm
*/

var val, toggle, vol;
val = 0;
toggle = 8;
vol = 21;

OSCdef(\mainBellOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \mainBell } { ~boyOhm[\mainBell].value; }
	{ id == \mainBellToggle } { ~boyOhm[\mainBellToggle].value; }
}, \control, ~scLang);

OSCdef(\mainBellRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \mainBell } {
		if ( val == 1, { ~boyOhmMidi[\mainBell].make } );
	}
}, \restoreOhm);



~boyOhm[\mainBell] = r({
	loop {
		~restoreOhm[\boy].mainBell = 1;
		~boyOhmMidi[\mainBell].make;
		~restoreOhm[\boy].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\boy].page.put(val, \blue);
		~ohm.turnBlue(val).yield;

		~restoreOhm[\boy].mainBell = 0;
		~boyOhmMidi[\mainBell].kill;
		~restoreOhm[\boy].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\boy].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
});

~boyOhm[\mainBellToggle] = r ({
	loop{
		~restoreOhm[\boy].page.put(toggle, \pink);
		~ohm.turnPink(toggle).yield;

		~restoreOhm[\boy].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;
	};
});

~boyOhmMidi[\mainBell] = { };
~boyOhmMidi[\mainBell].addUniqueMethod(\make, {
	MIDIdef.noteOn(\mainBellToggle, { ~scLang.sendMsg(\mainBell, \toggle); }, toggle);
	MIDIdef.cc(\mainBellVolume, { | val |
		var amp = val.linlin(0, 127, 0, 1);
		~scLang.sendMsg(\mainBell, \volume, amp); }, vol);
});
~boyOhmMidi[\mainBell].addUniqueMethod(\kill, {
	MIDIdef(\mainBellToggle).free;
	MIDIdef(\mainBellVolume).free;
});
