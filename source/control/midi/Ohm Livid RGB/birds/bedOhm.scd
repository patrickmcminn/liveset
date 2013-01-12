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
	{ id == \bedTrigger } { ~birdsOhm[\bedTrigger].value; }
}, \control, ~scLang);

OSCdef(\bedOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \bed } {
		if ( val == 1, { ~birdsOhmMidi[\bed].make; } );
	}
}, \restoreOhm);


~birdsOhm[\bed] = Routine({
	loop{
		~restoreOhm[\birds].bed = 1;
		~birdsOhmMidi[\bed].make;
		~restoreOhm[\birds].page.put(play, \blue);
		~ohm.turnBlue(play);
		~restoreOhm[\birds].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\birds].page.put(val, \pink);
		~ohm.turnPink(val).yield;

		~restoreOhm[\birds].bed = 0;
		~birdsOhmMidi[\bed].kill;
		~restoreOhm[\birds].page.put(play, \off);
		~ohm.turnOff(play);
		~restoreOhm[\birds].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\birds].page.put(val, \red);
		~ohm.turnRed(val).yield;
	}
});



~birdsOhm[\bedPlay] = r ({
	~restoreOhm[\birds].page.put(play, \yellow);
	~ohm.turnYellow(play).yield;

	~restoreOhm[\birds].page.put(play, \blue);
	~ohm.turnBlue(play).yield;

	~restoreOhm[\birds].page.put(play, \lavender);
	~ohm.turnLavender(play).yield;

	~restoreOhm[\birds].page.put(play, \purple);
	~ohm.turnPurple(play).yield;

	~restoreOhm[\birds].page.put(play, \pink);
	~ohm.turnPink(play).yield;

	~restoreOhm[\birds].page.put(play, \yellow);
	~ohm.turnYellow(play).yield;

	loop {
		~restoreOhm[\birds].page.put(play, \yellow);
		~ohm.turnBlue(play).yield;
	};
});



~birdsOhm[\bedToggle] = r ({
	loop{
		// all on
		~restoreOhm[\birds].page.put(toggle, \pink);
		~ohm.turnPink(toggle).yield;

		// all off
		~restoreOhm[\birds].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;
	}
});

~birdsOhm[\bedTrigger] = r ({
	loop{
		~restoreOhm[\birds].page.put(val, \blue);
		~ohm.turnBlue(val).yield;

		~restoreOhm[\birds].page.put(val, \yellow);
		~ohm.turnYellow(val).yield;

		~restoreOhm[\birds].page.put(val, \purple);
		~ohm.turnPurple(val).yield;

		~restoreOhm[\birds].page.put(val, \green);
		~ohm.turnGreen(val).yield;

		~restoreOhm[\birds].page.put(val, \lavender);
		~ohm.turnLavender(val).yield;

		~restoreOhm[\birds].page.put(val, \blue);
		~ohm.turnBlue(val).yield;
	};
});

~birdsOhmMidi[\bed] = { };
~birdsOhmMidi[\bed].addUniqueMethod(\make, {
	MIDIdef.noteOn(\bedPlay, { ~scLang.sendMsg(\bed, \play)}, play);
	MIDIdef.noteOn(\bedToggle, { ~scLang.sendMsg(\bed, \toggle)}, toggle);
	MIDIdef.cc(\bedVolume, { | val |
			var amp = val.linlin(0, 127, 0, 1.0);
			~scLang.sendMsg(\bed, \volume, amp)}, vol);
});
~birdsOhmMidi[\bed].addUniqueMethod(\kill, {
	MIDIdef(\bedPlay).free;
	MIDIdef(\bedToggle).free;
	MIDIdef(\bedVolume).free;
});

