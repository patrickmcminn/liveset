/*
Sunday, January 13th 2012
gendyOhm.scd
prm
*/

var val, toggle, reset, shift, vol;
val = 0;
toggle = 8;
reset = 16;
shift = 21;
vol = 23;

OSCdef(\gendyOhm,{ | msg |
	var id = msg.at(1);
	case
	{ id == \gendy } { ~improvOhm[\gendy].value; }
	{ id == \gendyToggle } { ~improvOhm[\gendyToggle].value; }
}, \control);

OSCdef(\gendyOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \gendy } {
		if ( val == 1, { ~improvOhmMidi[\gendy].make; } );
	}
}, \restoreOhm);

~improvOhm[\gendy] = r ({
	loop {
		~restoreOhm[\improv].gendy = 1;
		~improvOhmMidi[\gendy].make;
		~restoreOhm[\improv].page.put(toggle, \pink);
		~ohm.turnPink(toggle);
		~restoreOhm[\improv].page.put(reset, \purple);
		~ohm.turnPurple(reset);
		~restoreOhm[\improv].page.put(val, \blue);
		~ohm.turnBlue(val).yield;

		~restoreOhm[\improv].gendy = 0;
		~improvOhmMidi[\gendy].kill;
		~restoreOhm[\improv].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\improv].page.put(reset, \off);
		~ohm.turnOff(reset);
		~restoreOhm[\improv].page.put(val, \red);
		~ohm.turnRed(val).yield;
	}
});

~improvOhm[\gendyToggle] = r ({
	loop {
		~restoreOhm[\improv].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;

		~restoreOhm[\improv].page.put(toggle, \pink);
		~ohm.turnPink(toggle).yield;
	}
});

~improvOhmMidi[\gendy] = { };
~improvOhmMidi[\gendy].addUniqueMethod(\make, {
	MIDIdef.noteOn(\gendyToggle, { ~scLang.sendMsg(\gendy, \toggle, toggle) }, toggle);
	MIDIdef.noteOn(\gendyReset, { ~scLang.sendMsg(\gendy, \reset, reset) }, reset);
	MIDIdef.cc(\gendyShift, { | val |
		var shift = val.linlin(0, 127, -24, 24);
		~scLang.sendMsg(\gendy, \shift, shift); }, shift);
	MIDIdef.cc(\gendyVol, { | val |
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~scLang.sendMsg(\gendy, \volume, amp); }, vol);
});
~improvOhmMidi[\gendy].addUniqueMethod(\kill, {
	MIDIdef(\gendyToggle).free;
	MIDIdef(\gendyReset).free;
	MIDIdef(\gendyShift).free;
	MIDIdef(\gendyVol).free;
});