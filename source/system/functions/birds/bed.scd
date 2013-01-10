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

		\eq: Synth(\eq3, [\in, ~birdsBus[\bed].eq, \out, ~birdsBus[\bed].gran, \hiFreq, 8000, \hiGain, -70],
			~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~birdsBus[\bed].gran, \out, ~birdsBus[\bed].verb2, \mix, 0.6, \bufLength, 5, \trigRate, 32,
				\grainDur, 1, \grainDurOffset, 0.5
			],
			~group[\fx], \addToTail),

		\verb2: Synth(\convReverbStereo, [\in, ~birdsBus[\bed].verb2, \out, ~birdsBus[\bed].fader,
			\buffer, ~impulse[\cathedral1], \mix, 0.7, \inputScale, 0.1], ~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~birdsBus[\bed].fader, \out, ~mixer[\s1], \amp, 1], ~group[\fx], \addToTail),

		\onset: Synth(\onsetDetectorTrig, [\in, ~inst[\guitar], \id, 0, \thresh, 0.01, \fastMul, 0.6],
			~group[\fx], \addToTail)
	);

	Pbindef(\bedCSharp,
		\instrument, \playBuf,
		\bufName, ~birdsBuf[\bed].at(0),
		\out, ~birdsBus[\bed].verb1,
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
		\out, ~birdsBus[\bed].verb1,
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
		\out, ~birdsBus[\bed].verb1,
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
		\out, ~birdsBus[\bed].verb1,
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
		\out, ~birdsBus[\bed].verb1,
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
		\out, ~birdsBus[\bed].verb1,
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
		~scLang.sendMsg(\control, \bedTrigger);
		["C# Recorded"].yield;

		Synth(\recordBuf, [\in, ~inst[\guitar], \bufName, ~birdsBuf[\bed].at(1)],
			~group[\fx], \addToTail);
		~scLang.sendMsg(\control, \bedTrigger);
		["G# Recorded"].yield;

		Synth(\recordBuf, [\in, ~inst[\guitar], \bufName, ~birdsBuf[\bed].at(2)],
			~group[\fx], \addToTail);
		~scLang.sendMsg(\control, \bedTrigger);
		["F# Recorded"].yield;


		Synth(\recordBuf, [\in, ~inst[\guitar], \bufName, ~birdsBuf[\bed].at(3)],
			~group[\fx], \addToTail);
		~scLang.sendMsg(\control, \bedTrigger);
		["A Recorded"].yield;


		Synth(\recordBuf, [\in, ~inst[\guitar], \bufName, ~birdsBuf[\bed].at(4)],
			~group[\fx], \addToTail);
		~scLang.sendMsg(\control, \bedTrigger);
		["B Recorded"].yield;


		Synth(\recordBuf, [\in, ~inst[\guitar], \bufName, ~birdsBuf[\bed].at(5)],
			~group[\fx], \addToTail);
		~scLang.sendMsg(\control, \bedTrigger);
		["E Recorded"].yield;


		OSCdef(\bedRespond).free;
		["done with recording bed buffers"].postln.yield;

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



~birdsMake[\bed] = Routine({
	loop{
		~birds[\bed].value;
		~scLang.sendMsg(\control, \bed);
		["bed Synths created, Onset Detection Active"].postln.yield;

		~birds[\bed].kill;
		~birdsMake[\bedPlay].reset;
		~scLang.sendMsg(\control, \bed);
		["bed Synths killed, patterns stopped"].postln.yield;
	}
});



~birdsMake[\bedPlay] = r ({

	Pbindef(\bedCSharp).play;
	~scLang.sendMsg(\control, \bedPlay);
	["C# bed playing"].postln.yield;


	Pbindef(\bedGSharp).play;
	~scLang.sendMsg(\control, \bedPlay);
	["G# bed playing"].postln.yield;


	Pbindef(\bedFSharp).play;
	~scLang.sendMsg(\control, \bedPlay);
	["F# bed playing"].postln.yield;


	Pbindef(\bedA).play;
	~scLang.sendMsg(\control, \bedPlay);
	["A bed playing"].postln.yield;


	Pbindef(\bedB).play;
	~scLang.sendMsg(\control, \bedPlay);
	["B bed playing"].postln.yield;


	Pbindef(\bedE).play;
	~scLang.sendMsg(\control, \bedPlay);
	["E bed playing"].postln.yield;


	loop {
		~scLang.sendMsg(\control, \bedPlay);
		["all beds playing"].postln.yield;
	};
});



~birdsMake[\bedToggle] = r ({
	loop{
		~birds[\bed].stopBed;
		~scLang.sendMsg(\control, \bedToggle);
		["all beds off"].postln.yield;

		~birds[\bed].playBed;
		~scLang.sendMsg(\control, \bedToggle);
		["all beds on"].postln.yield;


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