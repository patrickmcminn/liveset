/*
Wednesday, December 12th 2012
attackRandomizerOhm.scd
prm
*/

var val, toggle, vol;
val = 6;
toggle = 14;
vol = 2;

OSCdef(\attackRandomizerOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \attackRandomizer } { ~connectOhm[\attackRandomizer].value; }
	{ id == \attackRandomizerToggle } { ~connectOhm[\attackRandomizerToggle].value; }
}, \control, ~scLang);

~connectOhm[\attackRandomizer] = r {
	loop {

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\attackRandomizerToggle, { ~scLang.sendMsg(\attackRandomizer, \toggle) }, toggle);

		MIDIdef.cc(\attackRandomizerVolume, { | val |
			var amp = val.linlin(0, 127, 0, -4.dbamp);
			~scLang.sendMsg(\attackRandomizer, \volume, amp) }, vol);

		~ohm.turnPurple(val).yield;

		MIDIdef(\attackRandomizerToggle).free;
		MIDIdef(\attackRandomizerVolume).free;
		~ohm.turnOff(toggle);


		~ohm.turnRed(val).yield;
	};
};

~connectOhm[\attackRandomizerToggle] = r {
	loop {
		~ohm.turnPink(toggle).yield;

		~ohm.turnRed(toggle).yield;
	};
};
