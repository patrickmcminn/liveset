/*
Tuesday, November 27th
Baltimore, MD
boy.scd
prm
*/




OSCdef(\accompSynth, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~boyMake[\accompSynth].value; }
	{ id == \one } { ~boyMake[\accompSynthPhraseOne].value; }
	{ id == \two } { ~boyMake[\accompSynthPhraseTwo].value; }
	{ id == \three } { ~boyMake[\accompSynthPhraseThree].value; }
	{ id == \volume } { ~boySynth[\accompSynth].fader.set(\amp, val); }
}, \accompSynth);


OSCdef(\boyBassline, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~boyMake[\bassline].value; }
	{ id == \one } { ~boyMake[\basslineOne].value; }
	{ id == \two } { ~boyMake[\basslineTwo].value; }
	{ id == \three } { ~boyMake[\basslineThree].value; }
	{ id == \volume } { ~boySynth[\bassline].fader.set(\amp, val); }
	{ id == \cutoff } { ~boySynth[\bassline].eq.set(\hiFreq, val); }
}, \boyBassline);


OSCdef(\endSynth, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~boyMake[\endSynth].value; }
	{ id == \loop } { ~boyMake[\endSynthLoop].value; }
	{ id == \d } { ~boyMake[\endSynthD].value; }
	{ id == \dSharp } { ~boyMake[\endSynthDSharp].value; }
	{ id == \aOne } { ~boyMake[\endSynthAMajorOne].value; }
	{ id == \cSharpOne } { ~boyMake[\endSynthCSharpMinorOne].value; }
	{ id == \gSharp } { ~boyMake[\endSynthGSharpMinor].value; }
	{ id == \aTwo } { ~boyMake[\endSynthAMajorTwo].value; }
	{ id == \cSharpTwo } { ~boyMake[\endSynthCSharpMinorTwo].value; }
	{ id == \aSix } { ~boyMake[\endSynthAMajorSix].value; }
	{ id == \bMajor } { ~boyMake[\endSynthBMajor].value; }
	{ id == \cSharp } { ~boyMake[\endSynthCSharp].value; }
	{ id == \volume } { ~boySynth[\endSynth].fader.set(\amp, val); }
}, \endSynth);


OSCdef(\mainBell, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~boyMake[\mainBell].value; }
	{ id == \toggle } { ~boyMake[\mainBellToggle].value; }
	{ id == \volume } { ~boySynth[\mainBell].fader.set(\amp, val); }
}, \mainBell);



OSCdef(\noiseChords, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~boyMake[\noiseChords].value; }
	{ id == \one } { ~boyMake[\noiseChordsOne].value; }
	{ id == \two } { ~boyMake[\noiseChordsTwo].value; }
	{ id == \three } { ~boyMake[\noiseChordsThree].value; }
	{ id == \volume } { ~boySynth[\noiseChords].fader.set(\amp, val); }
}, \noiseChords);



OSCdef(\randBell, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~boyMake[\randBell].value; }
	{ id == \toggle } { ~boyMake[\randBellToggle].value; }
	{ id == \volume } { ~boySynth[\randBell].fader.set(\amp, val); }
}, \randBell);


OSCdef(\rowFuzz, { | msg |

	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~boyMake[\rowFuzz].value; }
	{ id == \mainToggle } { ~boyMake[\rowFuzzMainToggle].value; }
	{ id == \lowToggle } { ~boyMake[\rowFuzzLowToggle].value; }
	{ id == \volume } { ~boySynth[\rowFuzz].fader.set(\amp, val); }
}, \rowFuzz);



OSCdef(\boyTrumpet, { | msg |

	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~boyMake[\trumpet].value; }
	{ id == \toggle } { ~boyMake[\trumpetToggle].value; }
	{ id == \minorThird } { ~boySynth[\trumpet].pitchShift.set(\interval, -3); }
	{ id == \majorThird } { ~boySynth[\trumpet].pitchShift.set(\interval, -4); }
	{ id == \unison } { ~boySynth[\trumpet].pitchShift.set(\interval, 0); }
	{ id == \octave } { ~boyMake[\trumpetOctaveToggle].value; }
	{ id == \volume } { ~boySynth[\trumpet].fader.set(\amp, val); }
}, \boyTrumpet);

OSCdef(\boyTransport, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~boyMake[\seeTransport].value; }
}, \boyTransport, ~scLang);


