/*
Monday, December 17th 2012
noiseSynthOhm.scd
prm
*/

var val, play, shift, vol;
val = 3;
play = 11;
shift = 19;
vol = 14;

OSCdef(\noiseSynthOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \noiseSynth } { ~birdsOhm[\noiseSynth].value; }
	{ id == \noiseSynthPlay } { ~birdsOhm[\noiseSynthPlay].value; }
	{ id == \noiseSynthShift } { ~birdsOhm[\noiseSynthShift].value; }
}, \control, ~scLang);

OSCdef(\noiseSynthOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \noiseSynth } {
		if ( val == 1, { ~birdsOhmMidi[\noiseSynth].make; } );
	}
}, \restoreOhm);



~birdsOhm[\noiseSynth] = r ({
	loop {
		~restoreOhm[\birds].noiseSynth = 1;
		~birdsOhmMidi[\noiseSynth].make;
		~restoreOhm[\birds].page.put(play, \blue);
		~ohm.turnBlue(play);
		~restoreOhm[\birds].page.put(shift, \blue);
		~ohm.turnBlue(shift);
		~restoreOhm[\birds].page.put(val, \pink);
		~ohm.turnPink(val).yield;

		~restoreOhm[\birds].noiseSynth = 0;
		~birdsOhmMidi[\noiseSynth].kill;
		~restoreOhm[\birds].page.put(play, \off);
		~ohm.turnOff(play);
		~restoreOhm[\birds].page.put(shift, \off);
		~ohm.turnOff(shift);
		~restoreOhm[\birds].page.put(val, \red);
		~ohm.turnRed(val).yield;
	}
});

~birdsOhm[\noiseSynthPlay] = r({
	loop {
		~restoreOhm[\birds].page.put(play, \yellow);
		~ohm.turnYellow(play).yield;

		~restoreOhm[\birds].page.put(play, \lavender);
		~ohm.turnLavender(play).yield;

		~restoreOhm[\birds].page.put(play, \purple);
		~ohm.turnPurple(play).yield;

		~restoreOhm[\birds].page.put(play, \pink);
		~ohm.turnPink(play).yield;

		~restoreOhm[\birds].page.put(play, \red);
		~ohm.turnRed(play).yield;
	}
});

~birdsOhm[\noiseSynthShift] = r ({
	loop {
		~restoreOhm[\birds].page.put(shift, \lavender);
		~ohm.turnLavender(shift).yield;

		~restoreOhm[\birds].page.put(shift, \purple);
		~ohm.turnPurple(shift).yield;

		~restoreOhm[\birds].page.put(shift, \pink);
		~ohm.turnPink(shift).yield;
	}
});

~birdsOhmMidi[\noiseSynth] = { };
~birdsOhmMidi[\noiseSynth].addUniqueMethod(\make, {
	MIDIdef.noteOn(\noiseSynthPlay, { ~scLang.sendMsg(\noiseSynth, \play) }, play);
	MIDIdef.noteOn(\noiseSynthShift, { ~scLang.sendMsg(\noiseSynth, \shift) }, shift);
	MIDIdef.cc(\noiseSynthVolume, { | val |
			var amp = val.linlin(0, 127, 0, -12.dbamp);
			~scLang.sendMsg(\noiseSynth, \volume, amp) }, vol);
});
~birdsOhmMidi[\noiseSynth].addUniqueMethod(\kill, {
	MIDIdef(\noiseSynthPlay).free;
	MIDIdef(\noiseSynthShift).free;
	MIDIdef(\noiseSynthVolume).free;
});
