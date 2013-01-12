/*
Tuesday, December 12th 2012
basslinesOhm.scd
prm
*/

var val, toggleOne, toggleTwo, vol, gran;
val = 4;
toggleOne = 12;
toggleTwo = 20;
vol = 15;
gran = 19;

OSCdef(\basslinesOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \basslines } { ~connectOhm[\basslines].value; }
	{ id == \basslineOne } {~connectOhm[\basslineOne].value; }
	{ id == \basslineTwo } { ~connectOhm[\basslineTwo].value; }
}, \control, ~scLang);

OSCdef(\basslinesOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \basslines } {
		if ( val == 1, { ~connectOhmMidi[\basslines].make; } )
	}
}, \restoreOhm);


~connectOhm[\basslines] = r {
	loop {

		~restoreOhm[\connections].basslines = 1;
		~connectOhmMidi[\basslines].make;
		~restoreOhm[\connections].page.put(toggleOne, \green);
		~ohm.turnGreen(toggleOne);
		~restoreOhm[\connections].page.put(toggleTwo, \green);
		~ohm.turnGreen(toggleTwo);
		~restoreOhm[\connections].page.put(val, \lavender);
		~ohm.turnLavender(val).yield;

		~restoreOhm[\connections].basslines = 0;
		~connectOhmMidi[\basslines].kill;
		~restoreOhm[\connections].page.put(toggleOne, \off);
		~ohm.turnOff(toggleOne);
		~restoreOhm[\connections].page.put(toggleTwo, \off);
		~ohm.turnOff(toggleTwo);
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
};

~connectOhm[\basslineOne] = r {
	loop{
		~restoreOhm[\connections].page.put(toggleOne, \pink);
		~ohm.turnPink(toggleOne).yield;

		~restoreOhm[\connections].page.put(toggleOne, \red);
		~ohm.turnRed(toggleOne).yield;
	};
};

~connectOhm[\basslineTwo] = r { | val |
	loop {
		~restoreOhm[\connections].page.put(toggleTwo, \pink);
		~ohm.turnPink(toggleTwo).yield;

		~restoreOhm[\connections].page.put(toggleTwo, \red);
		~ohm.turnRed(toggleTwo).yield;
	};
};


~connectOhmMidi[\basslines] = { };
~connectOhmMidi[\basslines].addUniqueMethod(\make, {

	MIDIdef.cc(\basslineVolume, { | val |
		var amp = val.linlin(0, 127, 0, 4.dbamp);
		~scLang.sendMsg(\bassline, \volume, amp)}, vol);

	MIDIdef.cc(\basslineGran, { | val |
		var mix = val.linlin(0, 127, 0, 1.0);
		var amp = val.linlin(0, 127, 1.0, 0.7);
		~scLang.sendMsg(\bassline, \gran, mix, amp);
	}, gran);

	MIDIdef.noteOn(\basslineOne, { ~scLang.sendMsg(\bassline, \one)}, toggleOne);

	MIDIdef.noteOn(\basslineTwo, { ~scLang.sendMsg(\bassline, \two)}, toggleTwo);
});
~connectOhmMidi[\basslines].addUniqueMethod(\kill, {
	MIDIdef(\basslineGran).free;
	MIDIdef(\basslineVolume).free;
	MIDIdef(\basslineOne).free;
	MIDIdef(\basslineTwo).free;
});
