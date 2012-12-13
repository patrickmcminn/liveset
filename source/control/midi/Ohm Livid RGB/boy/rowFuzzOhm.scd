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

~boyOhm[\rowFuzz] = r ({
	loop {
		~ohm.turnPurple(mainToggle);
		MIDIdef.noteOn(\rowFuzzMainToggle, { ~scLang.sendMsg(\rowFuzz, \mainToggle); }, mainToggle);

		~ohm.turnLavender(lowToggle);
		MIDIdef.noteOn(\rowFuzzLowToggle, { ~scLang.sendMsg(\rowFuzz, \lowToggle); }, lowToggle);

		MIDIdef.cc(\rowFuzzVolume, { | val |
			var amp = val.linlin(0, 127, 0, -3.dbamp);
			~scLang.sendMsg(\rowFuzz, \volume, amp); }, vol);

		~ohm.turnBlue(val).yield;


		~ohm.turnOff(mainToggle);
		MIDIdef(\rowFuzzMainToggle).free;
		~ohm.turnOff(lowToggle);
		MIDIdef(\rowFuzzLowToggle).free;
		MIDIdef(\rowFuzzVolume).free;

		~ohm.turnRed(val).yield;

	};
});

~boyOhm[\rowFuzzMainToggle] = r ({
	loop{
		~ohm.turnPink(mainToggle).yield;

		~ohm.turnRed(mainToggle).yield;
	};
});

~boyOhm[\rowFuzzLowToggle] = r ({ | val |
	loop {
		~ohm.turnLavender(lowToggle).yield;

		~ohm.turnRed(lowToggle).yield;
	};
});

		