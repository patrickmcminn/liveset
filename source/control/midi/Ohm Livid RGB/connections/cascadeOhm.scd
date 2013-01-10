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

~connectOhm[\cascade] = r {
	loop {
		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\cascadeToggle, { ~scLang.sendMsg(\cascade, \toggle)}, toggle);
		MIDIdef.cc(\cascadeVolume, { | val |
			var amp = val.linlin(0, 127, 0, -4.dbamp);
			~scLang.sendMsg(\cascade, \volume, amp)}, vol);
		~ohm.turnLavender(val).yield;

		MIDIdef(\cascadeVolume).free;
		MIDIdef(\cascadeToggle).free;
		~ohm.turnOff(toggle);
		~ohm.turnRed(val).yield;
	};
};

~connectOhm[\cascadeToggle] = r { | val |
	loop {
		~ohm.turnPink(toggle).yield;

		~ohm.turnRed(toggle).yield;
	};
};
