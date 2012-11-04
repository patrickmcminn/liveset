/*
Thursday, November 1st 2012
Between Denver, Colorado and Lawrence, Kansas
bed.scd
prm
*/

~birds[\bed] = { | val |

	var attack, sustain, release;
	attack = 0.262;
	sustain = 1.576;
	release = 0.162;

	~birdsBuf[\bed] = Buffer.allocConsecutive(6, s, s.sampleRate * 2, 1);

	~birdsBus[\bed] = (
		\verb1: Bus.audio,
		\eq: Bus.audio,
		\gran: Bus.audio,
		\verb2: Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);

	~birdsSynth[\bed] = (

		\verb1: Synth(\reverb1, [\in, ~birdsBus[\bed].verb1, \out, ~birdsBus[\bed].eq,
			\mix, 0.7, \room, 0.5, \damp, 0.1], ~group[\fx], \addToTail),

		\eq: Synth(\eq3, [\in, ~birdsBus[\bed].eq, \out, ~birdsBus[\bed].gran, \hiFreq, 34800, \hiGain, -70],
			~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~birdsBus[\bed].gran, \out, ~birdsBus[\bed].verb2
			],
			~group[\fx], \addToTail),

		\verb2: Synth(\convReverbStereo, [\in, ~birdsBus[\bed].verb2, \out, ~birdsBus[\bed].fader,
			\buffer, ~impulse[\cathedral1], \mix, 0.7], ~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~birdsBus[\bed].fader, \out, ~mixer[\s1], \amp, 0.8], ~group[\fx], \addToTail),

		\onset: Synth(\onsetDetectorTrig, [\in, ~inst[\guitar], \id, 0, \thresh, 0.1, \fastMul, 0.65],
			~group[\fx], \addToTail)
	);

	Pbindef(\bedCSharp,
		\instrument, \playBuf,
		\bufName, ~birdsBuf[\bed].at(0),
		\out, ~birdsBuf[\bed].verb1,
		\group, ~birdsSynth[\bed].verb1,
		\addAction, \addBefore,
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\amp, 1,
		\dur, 7
	);

	Pbindef(\bedGSharp,
		\instrument, \playBuf,
		\bufName, ~birdsBuf[\bed].at(1),
		\out, ~birdsBuf[\bed].verb1,
		\group, ~birdsSynth[\bed].verb1,
		\addAction, \addBefore,
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\amp, 1,
		\dur, 5.5
	);

	Pbindef(\bedFSharp,
		\instrument, \playBuf,
		\bufName, ~birdsBuf[\bed].at(2),
		\out, ~birdsBuf[\bed].verb1,
		\group, ~birdsSynth[\bed].verb1,
		\addAction, \addBefore,
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\amp, 1,
		\dur, 7.5
	);

	Pbindef(\bedA,
		\instrument, \playBuf,
		\bufName, ~birdsBuf[\bed].at(3),
		\out, ~birdsBuf[\bed].verb1,
		\group, ~birdsSynth[\bed].verb1,
		\addAction, \addBefore,
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\amp, 1,
		\dur, 7.4
	);

	Pbindef(\bedB,
		\instrument, \playBuf,
		\bufName, ~birdsBuf[\bed].at(4),
		\out, ~birdsBuf[\bed].verb1,
		\group, ~birdsSynth[\bed].verb1,
		\addAction, \addBefore,
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\amp, 1,
		\dur, 6
	);

	Pbindef(\bedE,
		\instrument, \playBuf,
		\bufName, ~birdsBuf[\bed].at(5),
		\out, ~birdsBuf[\bed].verb1,
		\group, ~birdsSynth[\bed].verb1,
		\addAction, \addBefore,
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\amp, 1,
		\dur, 9
	);

	~birds[\bedMake] = Routine({

		Synth(\recordBuf, [\in, ~inst[\guitar], \bufName, ~birdsBuf[\bed].at(0)],
			~group[\fx], \addToTail);
		["C# Recorded"].postln;
		~ohm.turnLavender(val).yield;

		Synth(\recordBuf, [\in, ~inst[\guitar], \bufName, ~birdsBuf[\bed].at(1)],
			~group[\fx], \addToTail);
		["G# Recorded"].postln;
		~ohm.turnPink(val).yield;

		Synth(\recordBuf, [\in, ~inst[\guitar], \bufName, ~birdsBuf[\bed].at(2)],
			~group[\fx], \addToTail);
		["F# Recorded"].postln;
		~ohm.turnPurple(val).yield;

		Synth(\recordBuf, [\in, ~inst[\guitar], \bufName, ~birdsBuf[\bed].at(3)],
			~group[\fx], \addToTail);
		["A Recorded"].postln;
		~ohm.turnYellow(val).yield;

		Synth(\recordBuf, [\in, ~inst[\guitar], \bufName, ~birdsBuf[\bed].at(4)],
			~group[\fx], \addToTail);
		["B Recorded"].postln;
		~ohm.turnBlue(val).yield;

		Synth(\recordBuf, [\in, ~inst[\guitar], \bufName, ~birdsBuf[\bed].at(5)],
			~group[\fx], \addToTail);
		["E Recorded"].postln;
		~ohm.turnLavender(val).yield;

		OSCdef(\bedRespond).free;
		["done with recording bed buffers"].postln;
		~ohm.turnBlue(val).yield;
	});

	OSCdef(\bedRespond, { ~birds[\bedMake].next.postln; }, '/tr' );

};

~birds[\bed].addUniqueMethod(\kill, {
	~birdsBus[\bed].do({ | i | i.free });
	~birdsSynth[\bed].do({ | i | i.free });

	Pbindef(\bedCSharp).stop;
	Pbindef(\bedGSharp).stop;
	Pbindef(\bedFSharp).stop;
	Pbindef(\bedA).stop;
	Pbindef(\bedB).stop;
	Pbindef(\bedE).stop;

	Pbindef(\bedCSharp).free;
	Pbindef(\bedGSharp).free;
	Pbindef(\bedFSharp).free;
	Pbindef(\bedA).free;
	Pbindef(\bedB).free;
	Pbindef(\bedE).free;

	~birds[\bedMake].reset;
});

~birds[\bed].addUniqueMethod(\playBed, {
	Pbindef(\bedCSharp).play;
	Pbindef(\bedGSharp).play;
	Pbindef(\bedFSharp).play;
	Pbindef(\bedA).play;
	Pbindef(\bedB).play;
	Pbindef(\bedE).play;
});

~birds[\bed].addUniqueMethod(\stopBed, {
	Pbindef(\bedCSharp).stop;
	Pbindef(\bedGSharp).stop;
	Pbindef(\bedFSharp).stop;
	Pbindef(\bedA).stop;
	Pbindef(\bedB).stop;
	Pbindef(\bedE).stop;
});


~birdsMake[\bed] = Routine({ | main |

	var val, play, toggle, vol;
	val = main.at(0);
	play = main.at(1);
	toggle = main.at(2);
	vol = main.at(3);

	loop{
		~birds[\bed].value(val);

		~ohm.turnBlue(play);
		MIDIdef.noteOn(\bedPlay, { ~scLang.sendMsg(\bed, \play, play)}, play);

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\bedToggle, { ~scLang.sendMsg(\bed, \toggle, toggle)}, toggle);

		MIDIdef.cc(\bedVolume, { | amp | ~scLang.sendMsg(\bed, \volume, amp)}, vol);

		["bed Synths created, Onset Detection Active"].postln;
		~ohm.turnPink(val).yield;

		~birds[\bed].kill;
		~ohm.turnOff(play);
		MIDIdef(\bedPlay).free;
		~ohm.turnOff(toggle);
		MIDIdef(\bedToggle).free;
		MIDIdef(\bedVolume).free;
		["bed Synths killed, patterns stopped"].postln;
		~ohm.turnRed(val).yield;
	}
});



~birdsMake[\bedPlay] = r ({ | val |

	Pbindef(\bedCSharp).play;
	["C# bed playing"].postln;
	~ohm.turnYellow(val).yield;

	Pbindef(\bedGSharp).play;
	["G# bed playing"].postln;
	~ohm.turnBlue(val).yield;

	Pbindef(\bedFSharp).play;
	["F# bed playing"].postln;
	~ohm.turnLavender(val).yield;

	Pbindef(\bedA).play;
	["A bed playing"].postln;
	~ohm.turnPurple(val).yield;

	Pbindef(\bedB).play;
	["B bed playing"].postln;
	~ohm.turnPink(val).yield;

	Pbindef(\bedE).play;
	["E bed playing"].postln;
	~ohm.turnYellow(val).yield;

	loop {
		["all beds playing"].postln;
		~ohm.turnBlue(val).yield;
	};
});



~birdsMake[\bedToggle] = r ({ | val |
	loop{
		~birds[\bed].playBed;
		~ohm.turnPink(val).yield;

		~birds[\bed].stopBed;
		~ohm.turnRed(val).yield;
	}
});



/*
signal flow:
recorded buffers
lots of reverb
Hi-Cut
more verb
granulation
*/