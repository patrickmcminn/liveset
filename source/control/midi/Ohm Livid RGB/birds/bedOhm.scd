/*
Sunday, December 16th 2012
bedOhm.scd
prm
*/

var val, play, toggle, vol;
val = 0;
play = 8;
toggle = 16;
vol = 23;

OSCdef(\bedOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \bed } { ~birdsOhm[\bed].value; }
	{ id == \bedPlay } { ~birdsOhm[\bedPlay].value; }
	{ id == \bedToggle } { ~birdsOhm[\bedToggle].value; }
}, \control, ~scLang);


~birdsOhm[\bed] = Routine({
	loop{
		~ohm.turnBlue(play);
		MIDIdef.noteOn(\bedPlay, { ~scLang.sendMsg(\bed, \play)}, play);

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\bedToggle, { ~scLang.sendMsg(\bed, \toggle)}, toggle);

		MIDIdef.cc(\bedVolume, { | val |
			var amp = val.linlin(0, 127, 0, 1.0);
			~scLang.sendMsg(\bed, \volume, amp)}, vol);

		~ohm.turnPink(val).yield;


		~birdsMake[\bedPlay].reset;
		~ohm.turnOff(play);
		MIDIdef(\bedPlay).free;
		~ohm.turnOff(toggle);
		MIDIdef(\bedToggle).free;
		MIDIdef(\bedVolume).free;
		~ohm.turnRed(val).yield;
	}
});



~birdsOhm[\bedPlay] = r ({

	~ohm.turnYellow(play).yield;

	~ohm.turnBlue(play).yield;

	~ohm.turnLavender(play).yield;

	~ohm.turnPurple(play).yield;

	~ohm.turnPink(play).yield;

	~ohm.turnYellow(play).yield;

	loop {
		["all beds playing"].postln;
		~ohm.turnBlue(play).yield;
	};
});



~birdsOhm[\bedToggle] = r ({
	loop{
		// all on
		~ohm.turnPink(toggle).yield;

		// all off
		~ohm.turnRed(toggle).yield;
	}
});

