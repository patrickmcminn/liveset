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


~birdsOhm[\eqgtr] = r({
	loop {
		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\eqgtrToggle, { ~scLang.sendMsg(\eqgtr, \toggle) }, toggle);
		MIDIdef.cc(\eqgtrVolume, { | val |
			var amp = val.linlin(0, 127, 0, -6.dbamp);
			~scLang.sendMsg(\eqgtr, \volume, amp) }, vol);

		~ohm.turnBlue(shift);
		MIDIdef.noteOn(\eqgtrShift, { ~scLang.sendMsg(\eqgtr, \shift) }, shift);

		["eqgtr synths made"].postln;
		~ohm.turnBlue(val).yield;


		~ohm.turnOff(toggle);
		~ohm.turnOff(shift);
		MIDIdef(\eqgtrToggle).free;
		MIDIdef(\eqgtrShift).free;
		MIDIdef(\eqgtrVolume).free;
		~ohm.turnRed(val).yield;
	}
});


~birdsOhm[\eqgtrToggle] = r ({
	loop{
		~ohm.turnRed(toggle).yield;

		~ohm.turnYellow(toggle).yield;
	}
});