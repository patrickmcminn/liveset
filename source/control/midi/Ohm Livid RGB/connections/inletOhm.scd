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

OSCdef(\inletOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \inlet } {
		if (val == 1, {~connectOhmMidi[\inlet].make; } );
	}
}, \restoreOhm);


~connectOhm[\inlet] = r {
	loop {
		~restoreOhm[\connections].inlet = 1;
		~connectOhmMidi[\inlet].make;
		~restoreOhm[\connections].page.put(val, \purple);
		~ohm.turnPurple(val).yield;

		~restoreOhm[\connections].inlet = 0;
		~connectOhmMidi[\inlet].kill;
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
};

~connectOhmMidi[\inlet] = { };
~connectOhmMidi[\inlet].addUniqueMethod(\make, {
	MIDIdef.cc(\inletGran, { | val |
			var mix = val.linlin(0, 127, 0.0, 1.0);
			~scLang.sendMsg(\inlet, \gran, mix); }, gran);
});
~connectOhmMidi[\inlet].addUniqueMethod(\kill, {
	MIDIdef(\inletGran).free;
});
	