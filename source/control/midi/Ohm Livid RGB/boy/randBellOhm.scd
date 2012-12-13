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

~boyOhm[\randBell] = r({
	loop {
		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\randBellToggle, { ~scLang.sendMsg(\randBell, \toggle); }, toggle);
		MIDIdef.cc(\randBellVolume, { | val |
			var amp = val.linlin(0, 127, 0, -4.dbamp);
			~scLang.sendMsg(\randBell, \volume, amp); }, vol);
		~ohm.turnPurple(val).yield;

		~ohm.turnOff(toggle);
		MIDIdef(\randBellToggle).free;
		MIDIdef(\randBellVolume).free;
		~ohm.turnRed(val).yield;
	};
});

~boyOhm[\randBellToggle] = r({
	loop {
		~ohm.turnPink(toggle).yield;

		~ohm.turnRed(toggle).yield;
	};
});


	