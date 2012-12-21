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


~boyOhm[\mainBell] = r({
	loop {

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\mainBellToggle, { ~scLang.sendMsg(\mainBell, \toggle); }, toggle);
		MIDIdef.cc(\mainBellVolume, { | val |
			var amp = val.linlin(0, 127, 0, 1);
			~scLang.sendMsg(\mainBell, \volume, amp); }, vol);
		~ohm.turnBlue(val).yield;



		~ohm.turnOff(toggle);
		MIDIdef(\mainBellToggle).free;
		MIDIdef(\mainBellVolume).free;
		["main bell synths freed"].postln;
		~ohm.turnRed(val).yield;

	};
});

~boyOhm[\mainBellToggle] = r ({
	loop{
		~ohm.turnPink(toggle).yield;

		~ohm.turnRed(toggle).yield;
	};
});
