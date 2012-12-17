/*
Thursday, November 8th 2012
birdsPage.scd
prm
*/

~page[\birds] = {

	~ohm.clearAll;
	~ohm.addEssential;

	~ohm.turnGreen(0);
	MIDIdef.noteOn(\bed, { ~scLang.sendMsg(\bed, \main);}, 0);


	~ohm.turnGreen(1);
	MIDIdef.noteOn(\eqgtr, { ~scLang.sendMsg(\eqgtr, \main); }, 1);

	~ohm.turnGreen(2);
	MIDIdef.noteOn(\tremgtr, { ~scLang.sendMsg(\tremgtr, \main); }, 2);

	~ohm.turnGreen(3);
	MIDIdef.noteOn(\noiseSynth, { ~scLang.sendMsg(\noiseSynth, \main); }, 3);

	~ohm.turnGreen(4);
	MIDIdef.noteOn(\wobble, { ~scLang.sendMsg(\wobble, \main); }, 4);

	~ohm.turnGreen(5);
	MIDIdef.noteOn(\birdsMicVerb, { ~scLang.sendMsg(\birdsMicVerb, \main); }, 5);

	~ohm.turnGreen(69);
	MIDIdef.noteOn(\birdsTransport, { ~scLang.sendMsg(\birdsTransport, \main); }, 69);


}