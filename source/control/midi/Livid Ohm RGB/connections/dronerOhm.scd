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

OSCdef(\dronerOhmRestoer, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \droner } {
		if( val == 1, { ~connectOhmMidi[\droner].make; } );
	}
}, \restoreOhm);


~connectOhm[\droner] = r {
	loop {
		~restoreOhm[\connections].droner = 1;
		~connectOhmMidi[\droner].make;
		~connectOhm[\dronerToggle].reset;
		~connectOhm[\dronerRater].reset;
		~restoreOhm[\connections].page.put(toggle, \green);
		~ohm.turnGreen(toggle);
		~restoreOhm[\connections].page.put(erode, \yellow);
		~ohm.turnYellow(erode);
		~restoreOhm[\connections].page.put(rater, \green);
		~ohm.turnGreen(rater);
		~restoreOhm[\connections].page.put(val, \blue);
		~ohm.turnBlue(val).yield;

		~restoreOhm[\connections].droner = 0;
		~connectOhmMidi[\droner].kill;
		~restoreOhm[\connections].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\connections].page.put(erode, \off);
		~ohm.turnOff(erode);
		~restoreOhm[\connections].page.put(rater, \off);
		~ohm.turnOff(rater);
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
};



~connectOhm[\dronerToggle] = r {
	loop {
		~restoreOhm[\connections].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;

		~restoreOhm[\connections].page.put(toggle, \blue);
		~ohm.turnBlue(toggle).yield;
	};
};

~connectOhm[\dronerRater] = r {
	loop {
		~restoreOhm[\connections].page.put(rater, \pink);
		~ohm.turnPink(rater).yield;

		~restoreOhm[\connections].page.put(rater, \purple);
		~ohm.turnPurple(rater).yield;

		~restoreOhm[\connections].page.put(rater, \lavender);
		~ohm.turnLavender(rater).yield;
	}
};

~connectOhmMidi[\droner] = { };
~connectOhmMidi[\droner].addUniqueMethod(\make, {
	MIDIdef.noteOn(\dronerToggle, { ~scLang.sendMsg(\droner, \toggle, toggle) }, toggle);
	MIDIdef.noteOn(\dronerErode, { ~scLang.sendMsg(\droner, \erodeOn, erode)}, erode);
	MIDIdef.noteOff(\dronerErodeOff, { ~scLang.sendMsg(\droner, \erodeOff, erode) }, erode);
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
});
~connectOhmMidi[\droner].addUniqueMethod(\kill, {
	MIDIdef.cc(\dronerVolume).free;
	MIDIdef.cc(\dronerGran).free;
	MIDIdef.cc(\dronerHiShelf).free;
	MIDIdef.cc(\dronerLoShelf).free;
	MIDIdef(\dronerErodeControl).free;
	MIDIdef(\dronerToggle).free;
	MIDIdef(\dronerErode).free;
	MIDIdef(\dronerErode).free;
	MIDIdef(\dronerRater).free;
});