/*
Tuesday, December 12th 2012
granDelayOhm.scd
prm
*/

var val, toggle, hiShelf, decay, vol;
val = 5;
toggle = 13;
hiShelf = 18;
decay = 11;
vol = 21;

OSCdef(\granDelayOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \granDelay } { ~connectOhm[\granDelay].value; }
	{ id == \granDelayToggle } { ~connectOhm[\granDelayToggle].value }
}, \control, ~scLang);

~connectOhm[\granDelay] = r {
	loop{

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\granDelayToggle, { ~scLang.sendMsg(\granDelay, \toggle)}, toggle);

		MIDIdef.cc(\granDelayHiShelf, { | val |
			var gain = val.linlin(0, 127, -6.0, 2);
			~scLang.sendMsg(\granDelay, \hiShelf, gain)}, hiShelf);
		MIDIdef.cc(\granDelayDecay, { | val |
			var decay = val.linlin(0, 127, 7.0, 45.0);
			~scLang.sendMsg(\granDelay, \decay, decay)}, decay);
		MIDIdef.cc(\granDelayVolume, { | val |
			var amp = val.linlin(0, 127, 0, -4.dbamp);
			~scLang.sendMsg(\granDelay, \volume, amp)}, vol);

		~ohm.turnBlue(val).yield;

		MIDIdef(\granDelayToggle).free;
		MIDIdef(\granDelayHiShelf).free;
		MIDIdef(\granDelayDecay).free;
		MIDIdef(\granDelayVolume).free;
		~ohm.turnOff(toggle);
		~ohm.turnRed(val).yield;
	};
};

~connectOhm[\granDelayToggle] = r {
	loop {
		~ohm.turnRed(toggle).yield;

		~ohm.turnBlue(toggle).yield;
	};
};

