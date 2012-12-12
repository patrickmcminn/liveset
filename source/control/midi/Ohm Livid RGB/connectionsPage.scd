/*
Thursday, October 18th 2012
connectionsPage.scd
prm
*/

~page[\connections] = {
	~ohm.clearAll;
	~ohm.addEssential;

	~ohm.turnGreen(0);
	MIDIdef.noteOn(\airSputters, { ~scLang.sendMsg(\airSputters, \main, note, toggle, vol)}, 0);

	~ohm.turnGreen(1);
	MIDIdef.noteOn(\droner, { ~scLang.sendMsg(\droner, \main)}, 1);


	~ohm.turnGreen(3);
	MIDIdef.noteOn(\noteRecord, { ~scLang.sendMsg(\noteRecord, \main)}, 3);
	~ohm.turnGreen(11);
	MIDIdef.noteOn(\cascadeRecord, { ~scLang.sendMsg(\cascade, \record)}, 11);
	~ohm.turnGreen(19);
	MIDIdef.noteOn(\chordRecord, { | vel, note |
		~scLang.sendMsg(\chords, \record, note)}, 19);


	~ohm.turnGreen(4);
	MIDIdef.noteOn(\bassline, { | vel, note, chn, time, toggleOne = 12, toggleTwo = 20, vol = 15, gran = 19 |
		~scLang.sendMsg(\bassline, \main, note, toggleOne, toggleTwo, vol, gran)}, 4);


	~ohm.turnGreen(5);
	MIDIdef.noteOn(\granDelay, { | vel, note, chn, time, toggle = 13, hiShelf = 18, decay = 11, vol = 21 |
		~scLang.sendMsg(\granDelay, \main, note, toggle, hiShelf, decay, vol)}, 5);


	~ohm.turnGreen(64);
	MIDIdef.noteOn(\inlet, { | vel, note, chn, time, gran = 10 |
		~scLang.sendMsg(\inlet, \main, note, gran)}, 64);

	~ohm.turnGreen(6);
	MIDIdef.noteOn(\attackRandomizer, { | vel, note, chn, time, toggle = 14, vol = 2 |
		~scLang.sendMsg(\attackRandomizer, \main, note, toggle, vol)}, 6);

	~ohm.turnGreen(7);
	MIDIdef.noteOn(\cascade, { | vel, note, chn, time, toggle = 15, vol = 3 |
		~scLang.sendMsg(\cascade, \main, note, toggle, vol)}, 7);

	~ohm.turnGreen(32);
	MIDIdef.noteOn(\chords, { | vel, note, chn, time, sum = 40, toggle = 48, vol = 1 |
		~scLang.sendMsg(\chords, \main, note, sum, toggle, vol)}, 32);

	~ohm.turnGreen(33);
	MIDIdef.noteOn(\stabs, { | vel, note, chn, time, toggle = 41, vol = 0 |
		~scLang.sendMsg(\stabs, \main, note, toggle, vol)}, 33);

	~ohm.turnGreen(34);
	MIDIdef.noteOn(\micVerb, { | vel, note, chn, time, toggle = 42, vol = 14, gran = 12  |
		~scLang.sendMsg(\micVerb, \main, note, toggle, vol, gran) }, 34);

	~ohm.turnGreen(77);
	MIDIdef.noteOn(\transport, { | vel, note |
		~scLang.sendMsg(\transport, \main, note) }, 77);


	/*

	~ohm.turnGreen(7);
	MIDIdef.noteOn(\cascade, { | vel, note |
		~scLang.sendMsg(\cascade, \main, note)}, 7);
	~ohm.turnBlue(15);
	MIDIdef.noteOn(\cascadeToggle, { | vel, note |
		~scLang.sendMsg(\cascade, \toggle, note)}, 15);
	*/




}



/*
~page[\connections] = {
	~ohm.clearAll;
	~ohm.addEssential;

	~ohm.turnGreen(0);
	~toggler = Routine({ | val |
		loop{
			"Hey I work!".postln;
			~ohm.turnBlue(val).yield;

			"I am toggling!".postln;
			~ohm.turnRed(val).yield;
		};
		});
	MIDIdef.noteOn(\tester, { ~toggler.value(0); }, 0);
};
*/