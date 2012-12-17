/*
Wednesday, December 12th 2012
inlet.scd
prm
*/

var val, gran;
val = 64;
gran = 10;

OSCdef(\inletOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \inlet } { ~connectOhm[\inlet].value; }
}, \control, ~scLang);


~connectOhm[\inlet] = r {
	loop {
		MIDIdef.cc(\inletGran, { | val |
			var mix = val.linlin(0, 127, 1.0, 0.0);
			~scLang.sendMsg(\inlet, \gran, mix); }, gran);
		~ohm.turnPurple(val).yield;

		MIDIdef(\inletGran).free;
		~ohm.turnRed(val).yield;
	};
};

