/*
Wednesday, December 12th 2012
chordsOhm.scd
prm
*/

var val, sum, toggle, vol;
val = 32;
sum = 40;
toggle = 48;
vol = 1;

OSCdef(\chordsOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \chords } { ~connectOhm[\chords].value; }
	{ id == \chordSum } { ~connectOhm[\chordSum].value; }
	{ id == \chordsToggle } { ~connectOhm[\chordsToggle].value; }
}, \control, ~scLang);

OSCdef(\chordsOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \chords } {
		if ( val == 1, { ~connectOhmMidi[\chords].make; } )
	}
}, \restoreOhm);

~connectOhm[\chords] = r {
	loop{
		~restoreOhm[\connections].chords = 1;
		~connectOhmMidi[\chords].make;
		~restoreOhm[\connections].page.put(sum, \green);
		~ohm.turnGreen(sum);
		~restoreOhm[\connections].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\connections].page.put(val, \purple);
		~ohm.turnPurple(val).yield;

		~restoreOhm[\connections].chords = 0;
		~connectOhmMidi[\chords].kill;
		~restoreOhm[\connections].page.put(sum, \off);
		~ohm.turnOff(sum);
		~restoreOhm[\connections].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
};


~connectOhm[\chordSum] = r {
	loop {
		~restoreOhm[\connections].page.put(sum, \purple);
		~ohm.turnPurple(sum).yield;
	};
};

~connectOhm[\chordsToggle] = r {
	loop{
		~restoreOhm[\connections].page.put(toggle, \yellow);
		~ohm.turnYellow(toggle).yield;

		~restoreOhm[\connections].page.put(toggle, \lavender);
		~ohm.turnLavender(toggle).yield;

		~restoreOhm[\connections].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;
	};
};


~connectOhmMidi[\chords] = { };
~connectOhmMidi[\chords].addUniqueMethod(\make, {
	MIDIdef.noteOn(\chordSum, { ~scLang.sendMsg(\chords, \sum) }, sum);
	MIDIdef.noteOn(\chordToggle, { ~scLang.sendMsg(\chords, \toggle) }, toggle);
	MIDIdef.cc(\chordVolume, { | val |
		var amp = val.linlin(0, 127, 0, -10.dbamp);
		~scLang.sendMsg(\chords, \volume, amp) }, vol);
});
~connectOhmMidi[\chords].addUniqueMethod(\kill, {
	MIDIdef(\chordVolume).free;
	MIDIdef(\chordSum).free;
	MIDIdef(\chordToggle).free;
});