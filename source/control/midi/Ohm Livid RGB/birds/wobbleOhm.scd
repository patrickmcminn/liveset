/*
Monday, December 17ty
wobbleOhm.scd
prm
*/

var val, toggle, vol;
val = 4;
toggle = 12;
vol = 12;


OSCdef(\wobbleOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \wobble } { ~birdsOhm[\wobble].value; }
	{ id == \wobbleToggle } { ~birdsOhm[\wobbleToggle].value; }
}, \control, ~scLang);

OSCdef(\wobbleOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \wobble } {
		if ( val == 1, { ~birdsOhmMidi[\wobble].make; } );
	}
}, \restoreOhm);





~birdsOhm[\wobble] = r ({
	loop {
		~restoreOhm[\birds].wobble = 1;
		~birdsOhmMidi[\wobble].make;
		~restoreOhm[\birds].page.put(toggle, \blue);
		~ohm.turnBlue(toggle);
		~restoreOhm[\birds].page.put(val, \pink);
		~ohm.turnPink(val).yield;

		~restoreOhm[\birds].wobble = 0;
		~birdsOhmMidi[\wobble].kill;
		~restoreOhm[\birds].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\birds].page.put(val, \red);
		~ohm.turnRed(val).yield;

	};
});

~birdsOhm[\wobbleToggle] = r({
	loop{
		~restoreOhm[\birds].page.put(toggle, \purple);
		~ohm.turnPurple(toggle).yield;

		~restoreOhm[\birds].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;
	};
});

~birdsOhmMidi[\wobble] = { };
~birdsOhmMidi[\wobble].addUniqueMethod(\make, {
	MIDIdef.cc(\wobbleVolume, { | val |
			var amp = val.linlin(0, 127, 0, -9.dbamp);
			~scLang.sendMsg(\wobble, \volume, amp); }, vol);
	MIDIdef.noteOn(\wobbleToggle, { ~scLang.sendMsg(\wobble, \toggle); }, toggle);
});
~birdsOhmMidi[\wobble].addUniqueMethod(\kill, {
	MIDIdef(\wobbleToggle).free;
	MIDIdef(\wobbleVolume).free;
});

