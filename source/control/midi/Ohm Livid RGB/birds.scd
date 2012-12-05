/*
Thursday, November 8th 2012
birds.scd
prm
*/

~page[\birds] = {

	~ohm.clearAll;
	~ohm.addEssential;

	~ohm.turnGreen(0);
	MIDIdef.noteOn(\bed, { | vel, note, chn, time, play = 8, toggle = 16, vol = 23 |
		~scLang.sendMsg(\bed, \main, note, play, toggle, vol);}, 0);


	~ohm.turnGreen(1);
	MIDIdef.noteOn(\eqgtr, { | vel, note, chn, time, toggle = 9, shift = 55, vol = 22 |
		~scLang.sendMsg(\eqgtr, \main, note, toggle, shift, vol); }, 1);

	~ohm.turnGreen(2);
	MIDIdef.noteOn(\tremgtr, { | vel, note, chn, time, toggle = 10, shift = 47, vol = 15 |
		~scLang.sendMsg(\tremgtr, \main, note, toggle, shift, vol); }, 2);

	~ohm.turnGreen(3);
	MIDIdef.noteOn(\noiseSynth, { | vel, note, chn, time, play = 11, shift = 19, vol = 14, end = 72|
		~scLang.sendMsg(\noiseSynth, \main, note, play, shift, vol, end); }, 3);

	~ohm.turnGreen(4);
	MIDIdef.noteOn(\wobble, { | vel, note, chn, time, toggle = 12, vol = 12 |
		~scLang.sendMsg(\wobble, \main, note, toggle, vol); }, 4);

	~ohm.turnGreen(5);
	MIDIdef.noteOn(\birdsMicVerb, { | vel, note, chn, time, toggle = 13, vol = 21 |
		~scLang.sendMsg(\birdsMicVerb, \main, note, toggle, vol); }, 5);

	~ohm.turnGreen(69);
	MIDIdef.noteOn(\birdsTransport, { | vel, note |
		~scLang.sendMsg(\transport, \main, note); }, 69);


}