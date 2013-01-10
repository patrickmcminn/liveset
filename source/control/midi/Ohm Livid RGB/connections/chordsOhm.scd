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

~connectOhm[\chords] = r {
	loop{
		~ohm.turnGreen(sum);
		MIDIdef.noteOn(\chordSum, { ~scLang.sendMsg(\chords, \sum) }, sum);

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\chordToggle, { ~scLang.sendMsg(\chords, \toggle) }, toggle);

		MIDIdef.cc(\chordVolume, { | val |
			var amp = val.linlin(0, 127, 0, -10.dbamp);
			~scLang.sendMsg(\chords, \volume, amp) }, vol);

		~ohm.turnPurple(val).yield;


		~ohm.turnOff(sum);
		~ohm.turnOff(toggle);
		MIDIdef(\chordVolume).free;
		MIDIdef(\chordSum).free;
		MIDIdef(\chordToggle).free;
		~ohm.turnRed(val).yield;
	};
};

~connectOhm[\chordSum] = r {
	loop {
		~ohm.turnPurple(sum).yield;
	};
};

~connectOhm[\chordsToggle] = r {
	loop{

		~ohm.turnYellow(toggle).yield;

		~ohm.turnLavender(toggle).yield;

		~ohm.turnRed(toggle).yield;
	};
};
