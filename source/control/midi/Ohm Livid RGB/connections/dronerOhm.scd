/*
Wednesday, October 12th 2012
dronerOhm.scd
prm
*/


~connectMake[\droner] = r { | main |
	var val, toggle, erode, rater, granMix, vol, loShelf, hiShelf, erodeControl;
	val = main.at(0);
	toggle = main.at(1);
	erode = main.at(2);
	rater = main.at(3);
	granMix = main.at(4);
	vol = main.at(5);
	loShelf = main.at(6);
	hiShelf = main.at(7);
	erodeControl = main.at(8);
	loop {
		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\dronerToggle, { ~scLang.sendMsg(\droner, \toggle, toggle) }, toggle);
		~ohm.turnYellow(erode);
		MIDIdef.noteOn(\dronerErode, { ~scLang.sendMsg(\droner, \erodeOn, erode)}, erode);
		MIDIdef.noteOff(\dronerErodeOff, { ~scLang.sendMsg(\droner, \erodeOff, erode) }, erode);
		~ohm.turnGreen(rater);
		MIDIdef.noteOn(\dronerRater, { ~scLang.sendMsg(\droner, \rater, rater)}, rater);
		MIDIdef.cc(\dronerGran, { | mix | ~scLang.sendMsg(\droner, \granMix, mix)}, granMix);
		MIDIdef.cc(\dronerVolume, { | amp | ~scLang.sendMsg(\droner, \volume, amp)}, vol);
		MIDIdef.cc(\dronerLoShelf, { | gain | ~scLang.sendMsg(\droner, \loShelf, gain)}, loShelf);
		MIDIdef.cc(\dronerHiShelf, { | gain | ~scLang.sendMsg(\droner, \hiShelf, gain)}, hiShelf);
		MIDIdef.cc(\dronerErodeControl, { | amt | ~scLang.sendMsg(\droner, \erodeControl, amt)}, erodeControl);
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

~connectMake[\dronerToggle] = r { | val |
	loop {
		~connectSynth[\droner].inFader.set(\mute, 0);
		["droner input muted"].postln;
		~ohm.turnRed(val).yield;

		~connectSynth[\droner].inFader.set(\mute, 1);
		["droner input active"].postln;
		~ohm.turnBlue(val).yield;
	};
};

~connectMake[\dronerRater] = r { | val |
	loop {
		~connectSynth[\droner].at(\rate).set(\d1, 1, \d2, 1);
		["droner rates of 1 added"].postln;
		~ohm.turnPink(val).yield;

		~connectSynth[\droner].at(\gran).set(\rate, 0.5);
		["droner rates to 0.5"].postln;
		~ohm.turnPurple(val).yield;

		~connectSynth[\droner].at(\rate).set(\d1, 0.5, \d2, 0.5, \d3, 0.5, \d4, 0.5, \d5, 0.5, \d6, 0.25, \d7, 0.25);
		~connectSynth[\droner].at(\gran).set(\rate, ~connectBus[\droner].at(\rate).asMap);
		["droner rates reset"].postln;
		~ohm.turnLavender(val).yield;
	}
};