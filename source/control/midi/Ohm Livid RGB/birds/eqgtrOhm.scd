/*
Sunday, December 16th 2012
eqgtrOhm.scd
prm
*/

var val, toggle, shift, vol;
val = 1;
toggle = 9;
shift = 55;
vol = 22;

OSCdef(\eqgtrOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \eqgtr } { ~birdsOhm[\eqgtr].value }
	{ id == \eqgtrToggle } { ~birdsOhm[\eqgtrToggle].value }
}, \control, ~scLang);

OSCdef(\eqgtrOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \eqgtr } {
		if (val == 1, { ~birdsOhmMidi[\eqgtr].make; } );
	}
}, \restoreOhm);


~birdsOhm[\eqgtr] = r({
	loop {
		~restoreOhm[\birds].eqgtr = 1;
		~birdsOhmMidi[\eqgtr].make;
		~restoreOhm[\birds].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\birds].page.put(shift, \blue);
		~ohm.turnBlue(shift);
		~restoreOhm[\birds].page.put(val, \blue);
		~ohm.turnBlue(val).yield;

		~restoreOhm[\birds].eqgtr = 0;
		~birdsOhmMidi[\eqgtr].kill;
		~restoreOhm[\birds].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\birds].page.put(shift, \off);
		~ohm.turnOff(shift);
		~restoreOhm[\birds].page.put(val, \red);
		~ohm.turnRed(val).yield;
	}
});


~birdsOhm[\eqgtrToggle] = r ({
	loop{
		~restoreOhm[\birds].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;

		~restoreOhm[\birds].page.put(toggle, \yellow);
		~ohm.turnYellow(toggle).yield;
	}
});

~birdsOhmMidi[\eqgtr] = { };
~birdsOhmMidi[\eqgtr].addUniqueMethod(\make, {
	MIDIdef.noteOn(\eqgtrToggle, { ~scLang.sendMsg(\eqgtr, \toggle) }, toggle);
	MIDIdef.cc(\eqgtrVolume, { | val |
		var amp = val.linlin(0, 127, 0, -6.dbamp);
		~scLang.sendMsg(\eqgtr, \volume, amp) }, vol);
	MIDIdef.noteOn(\eqgtrShift, { ~scLang.sendMsg(\eqgtr, \shift) }, shift);
});
~birdsOhmMidi[\eqgtr].addUniqueMethod(\kill, {
	MIDIdef(\eqgtrToggle).free;
	MIDIdef(\eqgtrShift).free;
	MIDIdef(\eqgtrVolume).free;
});
