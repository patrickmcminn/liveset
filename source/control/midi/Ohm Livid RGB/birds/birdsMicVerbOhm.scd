/*
Monday, December 17th 2012
birdsMicVerbOhm.scd
prm
*/

var val, toggle, vol;
val = 5;
toggle = 13;
vol = 21;

OSCdef(\birdsMicVerbOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \birdsMicVerb } { ~birdsOhm[\birdsMicVerb].value; }
	{ id == \birdsMicVerbToggle } { ~birdsOhm[\birdsMicVerbToggle].value; }
}, \control, ~scLang);


~birdsOhm[\birdsMicVerb] = r ({
	loop {
		~ohm.turnBlue(toggle);
		MIDIdef.noteOn(\birdsMicVerbToggle, { ~scLang.sendMsg(\birdsMicVerb, \toggle, toggle); }, toggle);
		MIDIdef.cc(\birdsMicVerbVolume, { | val |
			var amp = val.linlin(0, 127, 0, 1);
			~scLang.sendMsg(\birdsMicVerb, \volume, amp); }, vol);

		~ohm.turnPurple(val).yield;


		~ohm.turnOff(toggle);
		MIDIdef(\birdsMicVerbToggle).free;
		MIDIdef(\birdsMicVerbVolume).free;
		~ohm.turnRed(val).yield;

	}
});

~birdsOhm[\birdsMicVerbToggle] = r ({
	loop {
		~ohm.turnRed(toggle).yield;

		~ohm.turnBlue(toggle).yield;
	}
});

