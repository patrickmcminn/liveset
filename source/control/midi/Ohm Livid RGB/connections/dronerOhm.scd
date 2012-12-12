/*
Tuesday, December 11th 2012
dronerOhm.scd
prm
*/

var val, toggle, erode, rater, granMix, vol, loShelf, hiShelf, erodeControl;
val = 1;
toggle = 9;
erode = 2;
rater = 10;
granMix = 17;
vol = 22;
loShelf = 9;
hiShelf = 16;
erodeControl = 24;

OSCdef(\dronerOhm, { | msg |
	var id;
	id = msg.at(1);
	case
	{ id == \droner } { ~connectOhm[\droner].value;}
	{ id == \dronerToggle } { ~connectOhm[\dronerToggle].value; }
	{ id == \dronerRater } { ~connectOhm[\dronerRater].value; }
	{ id == \dronerErodeOn } { ~ohm.turnRed(erode); }
	{ id == \dronerErodeOff } { ~ohm.turnYellow(erode); }
}, \control, ~scLang);


~connectOhm[\droner] = r {
	loop {
		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\dronerToggle, { ~scLang.sendMsg(\droner, \toggle, toggle) }, toggle);

		~ohm.turnYellow(erode);
		MIDIdef.noteOn(\dronerErode, { ~scLang.sendMsg(\droner, \erodeOn, erode)}, erode);
		MIDIdef.noteOff(\dronerErodeOff, { ~scLang.sendMsg(\droner, \erodeOff, erode) }, erode);

		~ohm.turnGreen(rater);
		MIDIdef.noteOn(\dronerRater, { ~scLang.sendMsg(\droner, \rater, rater)}, rater);

		MIDIdef.cc(\dronerGran, { | val |
			var mix = val.linlin(0, 127, 0, 1);
			~scLang.sendMsg(\droner, \granMix, mix)}, granMix
		);

		MIDIdef.cc(\dronerVolume, { | val |
			var amp = val.linlin(0, 127, 0, -4.dbamp);
			~scLang.sendMsg(\droner, \volume, amp)}, vol
		);

		MIDIdef.cc(\dronerLoShelf, { | val |
			var gain = val.linlin(0, 127, -6.0, 6.0);
			~scLang.sendMsg(\droner, \loShelf, gain)}, loShelf
		);

		MIDIdef.cc(\dronerHiShelf, { | val |
			var gain = val.linlin(0, 127, -3.0, 4.0);
			~scLang.sendMsg(\droner, \hiShelf, gain)}, hiShelf
		);

		MIDIdef.cc(\dronerErodeControl, { | val |
			var amt = val.linlin(0, 127, 0, 0.15);
			~scLang.sendMsg(\droner, \erodeControl, amt)}, erodeControl
		);

		~ohm.turnBlue(val).yield;


		MIDIdef.cc(\dronerVolume).free;
		MIDIdef.cc(\dronerGran).free;
		MIDIdef.cc(\dronerHiShelf).free;
		MIDIdef.cc(\dronerLoShelf).free;
		MIDIdef(\dronerErodeControl).free;
		~ohm.turnOff(toggle);
		MIDIdef(\dronerToggle).free;
		~ohm.turnOff(erode);
		MIDIdef(\dronerErode).free;
		MIDIdef(\dronerErode).free;
		~ohm.turnOff(rater);
		MIDIdef(\dronerRater).free;
		~ohm.turnRed(val).yield;
	};
};

~connectOhm[\dronerToggle] = r {
	loop {
		~ohm.turnRed(toggle).yield;

		~ohm.turnBlue(toggle).yield;
	};
};

~connectOhm[\dronerRater] = r { | val |
	loop {
		~ohm.turnPink(rater).yield;

		~ohm.turnPurple(rater).yield;

		~ohm.turnLavender(rater).yield;
	}
};