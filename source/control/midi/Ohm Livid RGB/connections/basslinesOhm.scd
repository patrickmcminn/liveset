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


~connectOhm[\basslines] = r {
	loop {

		MIDIdef.cc(\basslineVolume, { | val |
			var amp = val.linlin(0, 127, 0, 4.dbamp);
			~scLang.sendMsg(\bassline, \volume, amp)}, vol);

		MIDIdef.cc(\basslineGran, { | val |
			var mix = val.linlin(0, 127, 0, 1.0);
			var amp = val.linlin(0, 127, 1.0, 0.7);
			~scLang.sendMsg(\bassline, \gran, mix, amp);
		}, gran);

		~ohm.turnGreen(toggleOne);
		MIDIdef.noteOn(\basslineOne, { ~scLang.sendMsg(\bassline, \one)}, toggleOne);
		~ohm.turnGreen(toggleTwo);
		MIDIdef.noteOn(\basslineTwo, { ~scLang.sendMsg(\bassline, \two)}, toggleTwo);

		~ohm.turnLavender(val).yield;


		~ohm.turnOff(toggleOne);
		MIDIdef(\basslineGran).free;
		MIDIdef(\basslineVolume).free;
		MIDIdef(\basslineOne).free;
		MIDIdef(\basslineTwo).free;
		~ohm.turnOff(toggleTwo);
		~ohm.turnRed(val).yield;
	};
};


~connectOhm[\basslineOne] = r {
	loop{
		~ohm.turnPink(toggleOne).yield;

		~ohm.turnRed(toggleOn).yield;
	};
};

~connectOhm[\basslineTwo] = r { | val |
	loop {
		~ohm.turnPink(toggleTwo).yield;

		~ohm.turnRed(toggleTwo).yield;
	};
};


