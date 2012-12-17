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


~birdsOhm[\noiseSynth] = r ({
	loop {
		~ohm.turnBlue(play);
		MIDIdef.noteOn(\noiseSynthPlay, { ~scLang.sendMsg(\noiseSynth, \play) }, play);

		~ohm.turnBlue(shift);
		MIDIdef.noteOn(\noiseSynthShift, { ~scLang.sendMsg(\noiseSynth, \shift) }, shift);

		MIDIdef.cc(\noiseSynthVolume, { | val |
			var amp = val.linlin(0, 127, 0, -12.dbamp);
			~scLang.sendMsg(\noiseSynth, \volume, amp) }, vol);

		~ohm.turnPink(val).yield;


		~ohm.turnOff(play);
		MIDIdef(\noiseSynthPlay).free;
		~ohm.turnOff(shift);
		MIDIdef(\noiseSynthShift).free;
		~ohm.turnRed(val).yield;
	}
});

~birdsOhm[\noiseSynthPlay] = r({
	loop {
		~ohm.turnYellow(play).yield;

		~ohm.turnLavender(play).yield;

		~ohm.turnPurple(play).yield;

		~ohm.turnPink(play).yield;

		~ohm.turnRed(play).yield;
	}
});

~birdsOhm[\noiseSynthShift] = r ({
	loop {
		~ohm.turnLavender(shift).yield;

		~ohm.turnPurple(shift).yield;

		~ohm.turnPink(shift).yield;
	}
});