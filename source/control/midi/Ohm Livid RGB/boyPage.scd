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
	MIDIdef.noteOn(\boyTrumpet, { | vel, note, chn, time, toggle = 40, minorThird = 48, majorThird = 56, octave = 57 vol = 14 |
		~scLang.sendMsg(\boyTrumpet, \main, note, toggle, minorThird, majorThird, minorThird, majorThird, octave, vol); }, 32);

	~ohm.turnGreen(34);
	MIDIdef.noteOn(\accompSynth, { | vel, note, chn, time, one = 42 , two = 50 , three = 58, vol = 12 |
		~scLang.sendMsg(\accompSynth, \main, note, one, two, three, vol); }, 34);

	~ohm.turnGreen(35);
	MIDIdef.noteOn(\endSynth, {
		| vel, note, chn, time, loop = 37, d = 45, dSharp = 53, aOne = 61, cSharpOne = 38, gSharp = 46,
		aTwo = 54, cSharpTwo = 62, aSix = 47, bMajor = 55, cSharp = 63, vol = 24 |
		~scLang.sendMsg(\endSynth, \main, note, loop, d, dSharp, aOne, cSharpOne, gSharp, aTwo, cSharpTwo, aSix, bMajor, cSharp, vol);
	}, 35);

	~ohm.turnGreen(77);
	MIDIdef.noteOn(\boyTransport, { | vel, note |
		~scLang.sendMsg(\boyTransport, \main, note); }, 77);

};