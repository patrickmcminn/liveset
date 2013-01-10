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

~boyOhm[\noiseChords] = r({
	loop {

		~ohm.turnGreen(one);
		MIDIdef.noteOn(\noiseChordsOne, { ~scLang.sendMsg(\noiseChords, \one) }, one);
		~ohm.turnBlue(two);
		MIDIdef.noteOn(\noiseChordsTwo, { ~scLang.sendMsg(\noiseChords, \two) }, two);
		~ohm.turnPink(three);
		MIDIdef.noteOn(\noiseChordsThree, { ~scLang.sendMsg(\noiseChords, \three) }, three);
		MIDIdef.cc(\noiseChordsVolume, { | val |
			var amp = val.linlin(0, 127, 0, 0.35);
			~scLang.sendMsg(\noiseChords, \volume, amp) }, vol);

		~ohm.turnLavender(val).yield;


		~ohm.turnOff(one);
		MIDIdef(\noiseChordsOne).free;
		~ohm.turnOff(two);
		MIDIdef(\noiseChordsTwo).free;
		~ohm.turnOff(three);
		MIDIdef(\noiseChordsThree).free;
		MIDIdef(\noiseChordsVolume).free;

		~ohm.turnRed(val).yield;

	};
});

~boyOhm[\noiseChordsOne] = r ({
	loop{
		~ohm.turnPink(one).yield;

		~ohm.turnRed(one).yield;
	};
});

~boyOhm[\noiseChordsTwo] = r ({
	loop {
		~ohm.turnPurple(two).yield;

		~ohm.turnRed(two).yield;
	};
});

~boyOhm[\noiseChordsThree] = r ({
	loop {
		~ohm.turnYellow(three).yield;

		~ohm.turnRed(three).yield;
	};
});