/*
Saturday, October 13th 2012
airSputters.scd
prm
*/

var val, toggle, vol;
val = 0;
toggle = 8;
vol = 23;

OSCdef(\airSputtersOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \airSputters } { ~connectOhm[\airSputters].value; }
	{ id == \airSputtersToggle } { ~connectOhm[\airSputtersToggle].value; }
	{ id == \sputterMake } { ~connectOhm[\sputterMake].value; }
}, \control, ~scLang);

OSCdef(\airSputtersOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \airSputters } {
		if ( val == 1, { ~connectOhmMidi[\airSputters].make; } )
	}
}, \restoreOhm);


~connectOhm[\airSputters] = r {
	loop {

		~restoreOhm[\connections].airSputters = 1;
		~connectOhmMidi[\airSputters].make;
		~restoreOhm[\connections].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\connections].page.put(val, \purple);
		~ohm.turnPurple(val).yield;

		~restoreOhm[\connections].airSputters = 0;
		~connectOhmMidi[\airSputters].kill;
		~restoreOhm[\connections].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
};


~connectOhm[\airSputtersToggle] = r {
	loop {
		~restoreOhm[\connections].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;

		~restoreOhm[\connections].page.put(toggle, \pink);
		~ohm.turnPink(toggle).yield;
	};
};

~connectOhm[\sputterMake] = r ({
	loop {
		~restoreOhm[\connections].page.put(val, \lavender);
		~ohm.turnLavender(val).yield;

		~restoreOhm[\connections].page.put(val, \pink);
		~ohm.turnPink(val).yield;

		~restoreOhm[\connections].page.put(val, \purple);
		~ohm.turnPurple(val).yield;

		~restoreOhm[\connections].page.put(val, \yellow);
		~ohm.turnYellow(val).yield;

		~restoreOhm[\connections].page.put(val, \blue);
		~ohm.turnBlue(val).yield;
	};
});


~connectOhmMidi[\airSputters] = { };

~connectOhmMidi[\airSputters].addUniqueMethod(\make, {
	MIDIdef.noteOn(\airSputtersToggle, { ~scLang.sendMsg(\airSputters, \toggle, toggle) }, toggle);

	MIDIdef.cc(\airSputtersVol, { | val |
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~scLang.sendMsg(\airSputters, \volume, amp) }, vol);
});

~connectOhmMidi[\airSputters].addUniqueMethod(\kill, {
	MIDIdef(\airSputtersToggle).free;
	MIDIdef(\airSputtersVol).free;
});