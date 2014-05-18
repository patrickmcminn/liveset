/*
Friday, December 14th 2012
noiseChordsOhm.scd
prm
*/

var val, one, two, three, vol;
val = 5;
one = 6;
two = 14;
three = 22;
vol = 15;

OSCdef(\noiseChordsOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \noiseChords } { ~boyOhm[\noiseChords].value; }
	{ id == \noiseChordsOne } { ~boyOhm[\noiseChordsOne].value; }
	{ id == \noiseChordsTwo } { ~boyOhm[\noiseChordsTwo].value; }
	{ id == \noiseChordsThree } { ~boyOhm[\noiseChordsThree].value; }
}, \control, ~scLang);

OSCdef(\noiseChordsRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \noiseChords } {
		if (val == 1, { ~boyOhmMidi[\noiseChords].make } );
	}
}, \restoreOhm);

~boyOhm[\noiseChords] = r({
	loop {
		~restoreOhm[\boy].noiseChords = 1;
		~boyOhmMidi[\noiseChords].make;
		~restoreOhm[\boy].page.put(one, \green);
		~ohm.turnGreen(one);
		~restoreOhm[\boy].page.put(two, \blue);
		~ohm.turnBlue(two);
		~restoreOhm[\boy].page.put(three, \pink);
		~ohm.turnPink(three);
		~restoreOhm[\boy].page.put(val, \lavender);
		~ohm.turnLavender(val).yield;

		~restoreOhm[\boy].noiseChords = 1;
		~boyOhmMidi[\noiseChords].kill;
		~restoreOhm[\boy].page.put(one, \off);
		~ohm.turnOff(one);
		~restoreOhm[\boy].page.put(two, \off);
		~ohm.turnOff(two);
		~restoreOhm[\boy].page.put(three, \off);
		~ohm.turnOff(three);
		~restoreOhm[\boy].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
});

~boyOhm[\noiseChordsOne] = r ({
	loop{
		~restoreOhm[\boy].page.put(one, \pink);
		~ohm.turnPink(one).yield;

		~restoreOhm[\boy].page.put(one, \red);
		~ohm.turnRed(one).yield;
	};
});

~boyOhm[\noiseChordsTwo] = r ({
	loop {
		~restoreOhm[\boy].page.put(two, \purple);
		~ohm.turnPurple(two).yield;

		~restoreOhm[\boy].page.put(two, \red);
		~ohm.turnRed(two).yield;
	};
});

~boyOhm[\noiseChordsThree] = r ({
	loop {
		~restoreOhm[\boy].page.put(three, \yellow);
		~ohm.turnYellow(three).yield;

		~restoreOhm[\boy].page.put(three, \red);
		~ohm.turnRed(three).yield;
	};
});

~boyOhmMidi[\noiseChords] = { };
~boyOhmMidi[\noiseChords].addUniqueMethod(\make, {
	MIDIdef.noteOn(\noiseChordsOne, { ~scLang.sendMsg(\noiseChords, \one) }, one);
	MIDIdef.noteOn(\noiseChordsTwo, { ~scLang.sendMsg(\noiseChords, \two) }, two);
	MIDIdef.noteOn(\noiseChordsThree, { ~scLang.sendMsg(\noiseChords, \three) }, three);
	MIDIdef.cc(\noiseChordsVolume, { | val |
			var amp = val.linlin(0, 127, 0, 0.6);
			~scLang.sendMsg(\noiseChords, \volume, amp) }, vol);
});
~boyOhmMidi[\noiseChords].addUniqueMethod(\kill, {
	MIDIdef(\noiseChordsOne).free;
	MIDIdef(\noiseChordsTwo).free;
	MIDIdef(\noiseChordsThree).free;
	MIDIdef(\noiseChordsVolume).free;
});
