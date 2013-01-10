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

~connectOhm[\stabs] = r {
	loop {

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\stabsToggle, { ~scLang.sendMsg(\stabs, \toggle) }, toggle);
		MIDIdef.cc(\stabsVolume, { | val |
			var amp = val.linlin(0, 127, 0, -14.dbamp);
			~scLang.sendMsg(\stabs, \volume, amp) }, vol);
		~ohm.turnPurple(val).yield;


		~ohm.turnOff(toggle);
		MIDIdef(\stabsVolume).free;
		MIDIdef(\stabsToggle).free;
		~ohm.turnRed(val).yield;
	};
};

~connectOhm[\stabsToggle] = r {
	loop {
		~ohm.turnLavender(toggle).yield;

		~ohm.turnRed(toggle).yield;
	};
};
