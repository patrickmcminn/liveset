/*
Thursday, October 18th 2012
connections.scd
prm
*/

~page[\connections] = {
	~ohm.clearAll;
	~ohm.addEssential;

	~ohm.turnGreen(0);
	MIDIdef.noteOn(\airSputters, { | vel, note, chn, time, toggle = 8 |
		~scLang.sendMsg(\airSputters, \main, note, toggle)}, 0);


	~ohm.turnGreen(1);
	MIDIdef.noteOn(\droner, { | vel, note, chn, time, toggle = 9, erode = 2, rater = 10 |
		~scLang.sendMsg(\droner, \main, note, toggle, erode, rater)}, 1);

	~ohm.turnGreen(3);
	MIDIdef.noteOn(\noteRecord, { | vel, note |
		~scLang.sendMsg(\noteRecord, \main, note)}, 3);
	~ohm.turnGreen(11);
	MIDIdef.noteOn(\cascadeRecord, { | vel, note |
		~scLang.sendMsg(\cascade, \record, note)}, 11);
	~ohm.turnGreen(19);
	MIDIdef.noteOn(\chordRecord, { | vel, note |
		~scLang.sendMsg(\chords, \record, note)}, 19);

	~ohm.turnGreen(4);
	MIDIdef.noteOn(\bassline, { | val, note, chn, time, toggleOne = 12, toggleTwo = 20 |
		~scLang.sendMsg(\bassline, \main, note, toggleOne, toggleTwo)}, 4);



	/*
	~ohm.turnGreen(3);
	MIDIdef.noteOn(\basslines, { | vel, note |
		~scLang.sendMsg(\bassline, \main, note)}, 3);
	~ohm.turnBlue(11);
	MIDIdef.noteOn(\basslineOne, { | vel, note |
		~scLang.sendMsg(\bassline, \one, note)}, 11);
	~ohm.turnBlue(19);
	MIDIdef.noteOn(\basslineTwo, { | vel, note |
		~scLang.sendMsg(\bassline, \two, note)}, 19);

	~ohm.turnGreen(4);
	MIDIdef.noteOn(\granDelay, { | vel, note |
		~scLang.sendMsg(\granDelay, \main, note)}, 4);
	~ohm.turnBlue(12);
	MIDIdef.noteOn(\granDelayToggle, { | vel, note |
		~scLang.sendMsg(\granDelay, \togle, note)}, 12);

	~ohm.turnGreen(5);
	MIDIdef.noteOn(\inlet, { | vel, note |
		~scLang.sendMsg(\inlet, \main, note)}, 5);

	~ohm.turnGreen(6);
	MIDIdef.noteOn(\attackRandomizer, { | vel, note|
		~scLang.sendMsg(\attackRandomizer, \main, note)}, 6);
	~ohm.turnBlue(14);
	MIDIdef.noteOn(\attackRandomizerToggle, { | vel, note |
		~scLang.sendMsg(\attackRandomizer, \toggle, note)}, 14);

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