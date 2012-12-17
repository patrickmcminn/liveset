/*
Thursday, October 18th 2012
connectionsPage.scd
prm
*/

~page[\connections] = {
	~ohm.clearAll;
	~ohm.addEssential;

	~ohm.turnGreen(0);
	MIDIdef.noteOn(\airSputters, { ~scLang.sendMsg(\airSputters, \main)}, 0);

	~ohm.turnGreen(1);
	MIDIdef.noteOn(\droner, { ~scLang.sendMsg(\droner, \main)}, 1);


	~ohm.turnGreen(3);
	MIDIdef.noteOn(\noteRecord, { ~scLang.sendMsg(\noteRecord, \main)}, 3);
	~ohm.turnGreen(11);
	MIDIdef.noteOn(\cascadeRecord, { ~scLang.sendMsg(\cascade, \record)}, 11);
	~ohm.turnGreen(19);
	MIDIdef.noteOn(\chordRecord, { ~scLang.sendMsg(\chords, \record)}, 19);


	~ohm.turnGreen(4);
	MIDIdef.noteOn(\bassline, { ~scLang.sendMsg(\bassline, \main)}, 4);


	~ohm.turnGreen(5);
	MIDIdef.noteOn(\granDelay, { ~scLang.sendMsg(\granDelay, \main)}, 5);


	~ohm.turnGreen(64);
	MIDIdef.noteOn(\inlet, { ~scLang.sendMsg(\inlet, \main)}, 64);

	~ohm.turnGreen(6);
	MIDIdef.noteOn(\attackRandomizer, { ~scLang.sendMsg(\attackRandomizer, \main)}, 6);

	~ohm.turnGreen(7);
	MIDIdef.noteOn(\cascade, { ~scLang.sendMsg(\cascade, \main)}, 7);

	~ohm.turnGreen(32);
	MIDIdef.noteOn(\chords, { ~scLang.sendMsg(\chords, \main)}, 32);

	~ohm.turnGreen(33);
	MIDIdef.noteOn(\stabs, {
		~scLang.sendMsg(\stabs, \main)}, 33);

	~ohm.turnGreen(34);
	MIDIdef.noteOn(\micVerb, { ~scLang.sendMsg(\micVerb, \main) }, 34);

	~ohm.turnGreen(77);
	MIDIdef.noteOn(\transport, { ~scLang.sendMsg(\connectionsTransport, \main) }, 77);


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