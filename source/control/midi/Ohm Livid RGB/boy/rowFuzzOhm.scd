/*
Thursday, December 13th 2012
rowFuzz.scd
prm
*/

var val, mainToggle, lowToggle, vol;
val = 1;
mainToggle = 9;
lowToggle = 17;
vol = 23;

OSCdef(\rowFuzzOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \rowFuzz } { ~boyOhm[\rowFuzz].value; }
	{ id == \rowFuzzMainToggle } { ~boyOhm[\rowFuzzMainToggle].value; }
	{ id == \rowFuzzLowToggle } { ~boyOhm[\rowFuzzLowToggle].value; }
}, \control, ~scLang);

OSCdef(\rowFuzzOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \rowFuzz } {
		if ( val == 1, { ~boyOhmMidi[\rowFuzz].make; } );
	}
}, \restoreOhm);



~boyOhm[\rowFuzz] = r ({
	loop {
		~restoreOhm[\boy].rowFuzz = 1;
		~boyOhmMidi[\rowFuzz].make;
		~restoreOhm[\boy].page.put(mainToggle, \purple);
		~ohm.turnPurple(mainToggle);
		~restoreOhm[\boy].page.put(lowToggle, \lavender);
		~ohm.turnLavender(lowToggle);
		~restoreOhm[\boy].page.put(val, \blue);
		~ohm.turnBlue(val).yield;

		~restoreOhm[\boy].rowFuzz = 0;
		~boyOhmMidi[\rowFuzz].kill;
		~restoreOhm[\boy].page.put(mainToggle, \off);
		~ohm.turnOff(mainToggle);
		~restoreOhm[\boy].page.put(lowToggle, \off);
		~ohm.turnOff(lowToggle);
		~restoreOhm[\boy].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
});

~boyOhm[\rowFuzzMainToggle] = r ({
	loop{
		~restoreOhm[\boy].page.put(mainToggle, \pink);
		~ohm.turnPink(mainToggle).yield;

		~restoreOhm[\boy].page.put(mainToggle, \red);
		~ohm.turnRed(mainToggle).yield;
	};
});

~boyOhm[\rowFuzzLowToggle] = r ({ | val |
	loop {
		~restoreOhm[\boy].page.put(lowToggle, \purple);
		~ohm.turnPurple(lowToggle).yield;

		~restoreOhm[\boy].page.put(lowToggle, \red);
		~ohm.turnRed(lowToggle).yield;
	};
});

~boyOhmMidi[\rowFuzz] = { };
~boyOhmMidi[\rowFuzz].addUniqueMethod(\make, {
	MIDIdef.noteOn(\rowFuzzMainToggle, { ~scLang.sendMsg(\rowFuzz, \mainToggle); }, mainToggle);
	MIDIdef.noteOn(\rowFuzzLowToggle, { ~scLang.sendMsg(\rowFuzz, \lowToggle); }, lowToggle);
	MIDIdef.cc(\rowFuzzVolume, { | val |
			var amp = val.linlin(0, 127, 0, -3.dbamp);
			~scLang.sendMsg(\rowFuzz, \volume, amp); }, vol);
});
~boyOhmMidi[\rowFuzz].addUniqueMethod(\kill, {
	MIDIdef(\rowFuzzMainToggle).free;
	MIDIdef(\rowFuzzLowToggle).free;
	MIDIdef(\rowFuzzVolume).free;
});

		