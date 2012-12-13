/*
Wednesday, October 10th 2012
micVerb.scd
prm
*/

var val, toggle, vol, gran;
val = 34;
toggle = 42;
vol = 14;
gran = 12;

OSCdef(\micVerbOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \micVerb } { ~connectOhm[\micVerb].value; }
	{ id == \micVerbToggle } { ~connectOhm[\micVerb].value; }
}, \control, ~scLang);

~connectOhm[\micVerb] = r {
	loop{

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\micVerbToggle, { ~scLang.sendMsg(\micVerb, \toggle) }, toggle);

		MIDIdef.cc(\micVerbVolume, { | val |
			var amp = val.linlin(0, 127, 0, 1);
			~scLang.sendMsg(\micVerb, \volume, amp) }, vol);

		MIDIdef.cc(\micVerbGran, { | val |
			var mix = val.linlin(0, 127, 0, 0.3);
			~scLang.sendMsg(\micVerb, \gran, mix) }, gran);

		~ohm.turnBlue(val).yield;


		~ohm.turnOff(toggle);
		MIDIdef(\micVerbVolume).free;
		MIDIdef(\micVerbToggle).free;
		MIDIdef(\micVerbGran).free;
		~ohm.turnRed(val).yield;
	};
};

~connectOhm[\micVerbToggle] = r {
	loop{

		~ohm.turnRed(toggle).yield;

		~ohm.turnBlue(toggle).yield;
	};
};
