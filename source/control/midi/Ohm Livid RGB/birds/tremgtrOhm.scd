/*
Monday, December 17th 2012
tremgtrOhm.scd
prm
*/


var val, toggle, shift, vol;
val = 2;
toggle = 10;
shift = 47;
vol = 15;

OSCdef(\tremgtrOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \tremgtr } { ~birdsOhm[\tremgtr].value; }
	{ id == \tremgtrToggle } { ~birdsOhm[\tremgtrToggle].value; }
}, \control, ~scLang);

~birdsOhm[\tremgtr] = r ({
	loop {
		~ohm.turnBlue(toggle);
		MIDIdef.noteOn(\tremgtrToggle, { ~scLang.sendMsg(\tremgtr, \toggle); }, toggle);

		~ohm.turnGreen(shift);
		MIDIdef.noteOn(\tremgtrShift, { ~scLang.sendMsg(\tremgtr, \shift); }, shift);

		MIDIdef.cc(\tremgtrVolume, { | val |
			var amp = val.linlin(0, 127, 0, -6.dbamp);
			~scLang.sendMsg(\tremgtr, \volume, amp); }, vol);

		~ohm.turnPurple(val).yield;



		~ohm.turnOff(toggle);
		~ohm.turnOff(shift);
		MIDIdef(\tremgtrToggle).free;
		MIDIdef(\tremgtrShift).free;
		MIDIdef(\tremgtrVolume).free;

		~ohm.turnRed(val).yield;

	};

});

~birdsOhm[\tremgtrToggle] = r ({
	loop {
		~ohm.turnRed(toggle).yield;

		~ohm.turnBlue(toggle).yield;
	};
});