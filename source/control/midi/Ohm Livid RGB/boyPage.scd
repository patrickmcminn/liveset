/*
Tuesday, November 27th
boyPage.scd
prm
*/

~page[\boy] = {

	~ohm.clearAll;
	~ohm.addEssential;

	// main bell
	~ohm.turnGreen(0);
	MIDIdef.noteOn(\mainBell, { ~scLang.sendMsg(\mainBell, \main);}, 0);

	// row fuzz
	~ohm.turnGreen(1);
	MIDIdef.noteOn(\rowFuzz, { ~scLang.sendMsg(\rowFuzz, \main); }, 1);

	// rand bells
	~ohm.turnGreen(2);
	MIDIdef.noteOn(\randBell, { ~scLang.sendMsg(\randBell, \main); }, 2);

	// bassline
	~ohm.turnGreen(3);
	MIDIdef.noteOn(\boyBassline, { ~scLang.sendMsg(\boyBassline, \main); }, 3);

	// noise chords
	~ohm.turnGreen(5);
	MIDIdef.noteOn(\boyNoiseChords, { ~scLang.sendMsg(\noiseChords, \main); }, 5);

	// trumpet
	~ohm.turnGreen(32);
	MIDIdef.noteOn(\boyTrumpet, { ~scLang.sendMsg(\boyTrumpet, \main); }, 32);

	~ohm.turnGreen(34);
	MIDIdef.noteOn(\accompSynth, { ~scLang.sendMsg(\accompSynth, \main); }, 34);

	~ohm.turnGreen(35);
	MIDIdef.noteOn(\endSynth, { ~scLang.sendMsg(\endSynth, \main); }, 35);

	~ohm.turnGreen(77);
	MIDIdef.noteOn(\boyTransport, { ~scLang.sendMsg(\boyTransport, \main); }, 77);
};