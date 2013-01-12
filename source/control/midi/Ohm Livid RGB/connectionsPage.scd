/*
Thursday, October 18th 2012
edited 1/11/2013
connectionsPage.scd
prm
*/

~restoreOhm[\connections] = ( );
~restoreOhm[\connections].page = Array.fill(81, nil);


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

	~restoreOhm[\connections].page.do({ | color, note |
		case
		{ color == \off } { ~ohm.turnOff(note); }
		{ color == \lavender } { ~ohm.turnLavender(note); }
		{ color == \blue } { ~ohm.turnBlue(note); }
		{ color == \pink } { ~ohm.turnPink(note) ; }
		{ color == \red } { ~ohm.turnRed(note); }
		{ color == \purple } { ~ohm.turnPurple(note); }
		{ color == \green } { ~ohm.turnGreen(note); }
		{ color == \yellow } { ~ohm.turnYellow(note); }
	});

	~restoreOhm[\connections].keysValuesDo({ | name, state |  ~scLang.sendMsg(\restoreOhm, name, state); });


}






