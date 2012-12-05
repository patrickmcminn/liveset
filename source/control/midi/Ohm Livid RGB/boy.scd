/*
Tuesday, November 27th
boy.scd
prm
*/

~page[\boy] = {

	~ohm.clearAll;
	~ohm.addEssential;

	// main bell
	~ohm.turnGreen(0);
	MIDIdef.noteOn(\mainBell, { | vel, note, chn, time, toggle = 8, vol = 21 |
		~scLang.sendMsg(\mainBell, \main, note, toggle, vol);}, 0);

	// row fuzz
	~ohm.turnGreen(1);
	MIDIdef.noteOn(\rowFuzz, { | vel, note, chn, time, mainToggle = 9, lowToggle = 17, vol = 23 |
		~scLang.sendMsg(\rowFuzz, \main, note, mainToggle, lowToggle, vol); }, 1);

	// rand bells
	~ohm.turnGreen(2);
	MIDIdef.noteOn(\randBell, { | vel, note, chn, time, toggle = 10, vol = 19, end = 72 |
		~scLang.sendMsg(\randBell, \main, note, toggle, vol, end); }, 2);

	// bassline
	~ohm.turnGreen(3);
	MIDIdef.noteOn(\boyBassline, { | vel, note, chn, time, one = 4, two = 12, three = 20, vol = 22, cutoff = 20 |
		~scLang.sendMsg(\boyBassline, \main, note, one, two, three, vol, cutoff); }, 3);

	// noise chords
	~ohm.turnGreen(5);
	MIDIdef.noteOn(\boyNoiseChords, { | vel, note, chn, time, one = 6, two = 14, three = 22, vol = 15 |
		~scLang.sendMsg(\noiseChords, \main, note, one, two, three, vol); }, 5);

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