/*
Tuesday, November 27th
Baltimore, MD
boy.scd
prm
*/



OSCdef(\accompSynth, { | msg |
	var id, val, one, two, three, vol;
	id = msg.at(1);
	val = msg.at(2);
	one = msg.at(3);
	two = msg.at(4);
	three = msg.at(5);
	vol = msg.at(6);

	case
	{ id == \main } { ~boyMake[\accompSynth].value([val, one, two, three, vol]); }
	{ id == \one } { ~boyMake[\accompSynthPhraseOne].value(val); }
	{ id == \two } { ~boyMake[\accompSynthPhraseTwo].value(val); }
	{ id == \three } { ~boyMake[\accompSynthPhraseThree].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, -2.dbamp);
		~boySynth[\accompSynth].fader.set(\amp, amp); }
}, \accompSynth);


OSCdef(\boyBassline, { | msg |

	var id, val, one, two, three, vol, cutoff;
	id = msg.at(1);
	val = msg.at(2);
	one = msg.at(3);
	two = msg.at(4);
	three = msg.at(5);
	vol = msg.at(6);
	cutoff = msg.at(7);

	case
	{ id == \main } { ~boyMake[\bassline].value([val, one, two, three, vol, cutoff]) ; }
	{ id == \one } { ~boyMake[\basslineOne].value(val); }
	{ id == \two } { ~boyMake[\basslineTwo].value(val); }
	{ id == \three } { ~boyMake[\basslineThree].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, 1);
		~boySynth[\bassline].fader.set(\amp, amp); }
	{ id == \cutoff } {
		var cutoff = val.linexp(0, 127, 1, 7000);
		~boySynth[\bassline].eq.set(\hiFreq, cutoff); }
}, \boyBassline);


OSCdef(\endSynth, { | msg |

	var id, val, loop, d, dSharp, aOne, cSharpOne, gSharp, aTwo, cSharpTwo, aSix, bMajor, cSharp, vol;
	id = msg.at(1);
	val = msg.at(2);
	loop = msg.at(3);
	d = msg.at(4);
	dSharp = msg.at(5);
	aOne = msg.at(6);
	cSharpOne = msg.at(7);
	gSharp = msg.at(8);
	aTwo = msg.at(9);
	cSharpTwo = msg.at(10);
	aSix = msg.at(11);
	bMajor = msg.at(12);
	cSharp = msg.at(13);
	vol = msg.at(14);

	case
	{ id == \main } {
		~boyMake[\endSynth].value([val, loop, d, dSharp, aOne, cSharpOne, gSharp, aTwo, cSharpTwo, aSix, bMajor, cSharp, vol]); }

	{ id == \loop } { ~boyMake[\endSynthLoop].value(val); }
	{ id == \d } { ~boyMake[\endSynthD].value(val); }
	{ id == \dSharp } { ~boyMake[\endSynthDSharp].value(val); }
	{ id == \aOne } { ~boyMake[\endSynthAMajorOne].value(val); }
	{ id == \cSharpOne } { ~boyMake[\endSynthCSharpMinorOne].value(val); }
	{ id == \gSharp } { ~boyMake[\endSynthGSharpMinor].value(val); }
	{ id == \aTwo } { ~boyMake[\endSynthAMajorTwo].value(val); }
	{ id == \cSharpTwo } { ~boyMake[\endSynthCSharpMinorTwo].value(val); }
	{ id == \aSix } { ~boyMake[\endSynthAMajorSix].value(val); }
	{ id == \bMajor } { ~boyMake[\endSynthBMajor].value(val); }
	{ id == \cSharp } { ~boyMake[\endSynthCSharp].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, 1);
		~boySynth[\endSynth].fader.set(\amp, amp); }
}, \endSynth);


OSCdef(\mainBell, { | msg |

	var id, val, toggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	vol = msg.at(4);

	case
	{ id == \main } { ~boyMake[\mainBell].value([val, toggle, vol]); }
	{ id == \toggle } { ~boyMake[\mainBellToggle].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, 1);
		~boySynth[\mainBell].fader.set(\amp, amp); }
}, \mainBell);



OSCdef(\noiseChords, { | msg |

	var id, val, one, two, three, vol;
	id = msg.at(1);
	val = msg.at(2);
	one = msg.at(3);
	two = msg.at(4);
	three = msg.at(5);
	vol = msg.at(6);

	case
	{ id == \main } { ~boyMake[\noiseChords].value([val, one, two, three, vol]); }
	{ id == \one } { ~boyMake[\noiseChordsOne].value(val); }
	{ id == \two } { ~boyMake[\noiseChordsTwo].value(val); }
	{ id == \three } { ~boyMake[\noiseChordsThree].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, 0.35);
		~boySynth[\noiseChords].fader.set(\amp, amp); }
}, \noiseChords);



OSCdef(\randBell, { | msg |

	var id, val, toggle, vol, end;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	vol = msg.at(4);
	end = msg.at(5);

	case
	{ id == \main } { ~boyMake[\randBell].value([val, toggle, vol, end]); }
	{ id == \toggle } { ~boyMake[\randBellToggle].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~boySynth[\randBell].fader.set(\amp, amp); }
	{ id == \end } { ~boyMake[\endFade].value(val); }
}, \randBell);


OSCdef(\rowFuzz, { | msg |

	var id, val, mainToggle, lowToggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	mainToggle = msg.at(3);
	lowToggle = msg.at(4);
	vol = msg.at(5);

	case
	{ id == \main } { ~boyMake[\rowFuzz].value([val, mainToggle, lowToggle, vol]); }
	{ id == \mainToggle } { ~boyMake[\rowFuzzMainToggle].value(val); }
	{ id == \lowToggle } { ~boyMake[\rowFuzzLowToggle].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, -3.dbamp);
		~boySynth[\rowFuzz].fader.set(\amp, amp); }
}, \rowFuzz);



OSCdef(\boyTrumpet, { | msg |

	var id, val, toggle, minorThird, majorThird, unison, octave, vol;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	minorThird = msg.at(4);
	majorThird = msg.at(5);
	octave  = msg.at(8);
	vol = msg.at(9);
	case
	{ id == \main } { ~boyMake[\trumpet].value([val, toggle, minorThird, majorThird, minorThird, majorThird, octave, vol]); }
	{ id == \toggle } { ~boyMake[\trumpetToggle].value(val); }
	{ id == \minorThird } { ~boySynth[\trumpet].pitchShift.set(\interval, -3); }
	{ id == \majorThird } { ~boySynth[\trumpet].pitchShift.set(\interval, -4); }
	{ id == \unison } { ~boySynth[\trumpet].pitchShift.set(\interval, 0); }
	{ id == \octave } { ~boyMake[\trumpetOctaveToggle].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, -4.dbamp);
		~boySynth[\trumpet].fader.set(\amp, amp); }
}, \boyTrumpet);

OSCdef(\boyTransport, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~boyMake[\seeTransport].value(val); }
}, \boyTransport, ~scLang);


