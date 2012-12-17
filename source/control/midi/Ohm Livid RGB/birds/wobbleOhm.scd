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
	{ id == \wobbleToggle } { ~birdsOhm[\wobble].value; }
}, \control, ~scLang);


~birdsOhm[\wobble] = r ({
	loop {
		MIDIdef.cc(\wobbleVolume, { | val |
			var amp = val.linlin(0, 127, 0, -9.dbamp);
			~scLang.sendMsg(\wobble, \volume, amp); }, vol);

		~ohm.turnBlue(toggle);
		MIDIdef.noteOn(\wobbleToggle, { ~scLang.sendMsg(\wobble, \toggle); }, toggle);
		~ohm.turnPink(val).yield;


		~birds[\wobble].kill;
		~ohm.turnOff(toggle);
		MIDIdef(\wobbleToggle).free;
		MIDIdef(\wobbleVolume).free;
		["wobble synths freed"].postln;
		~ohm.turnRed(val).yield;

	};
});

~birdsOhm[\wobbleToggle] = r({ | val |
	loop{
		~ohm.turnPurple(toggle).yield;

		~ohm.turnRed(toggle).yield;
	};
});
