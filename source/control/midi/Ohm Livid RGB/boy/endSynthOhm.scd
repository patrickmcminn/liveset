/*
Wednesday, November 28th 2012
back in the basement
2330 N. Charles St.
Baltimore, MD 21218
endSynth.scd
prm
*/

~boy[\endSynth] = {

	~boyBus[\endSynth] =  (
		\gran: Bus.audio,
		\eq: Bus.audio(s, 2),
		\verb: Bus.audio(s, 2),
		\broken: Bus.audio(s, 2),
		\del: Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);

	~boySynth[\endSynth] = (

		\gran: Synth(\granulator,
			[
				\in, ~boyBus[\endSynth].gran, \out, ~boyBus[\endSynth].eq,
				\bufLength, 0.7, \grainDur, 0.0659, \grainDurOffset, 0.02,
				\trigRate, 15, \panOffset, 0.4, \mix, 0.9
			],
			~group[\fx], \addToTail),

		\eq: Synth(\eq3, [\in, ~boyBus[\endSynth].eq, \out, ~boyBus[\endSynth].verb,
			\gainLo, -12.1], ~group[\fx], \addToTail),

		\verb: Synth(\reverb2, [\in, ~boyBus[\endSynth].verb, \out, ~boyBus[\endSynth].broken, \mix, 0.3, \room, 0.75,
			\damp, 0.21], ~group[\fx], \addToTail),

		\broken: Synth(\brokenAntenna, [\in, ~boyBus[\endSynth].broken, \out, ~boyBus[\endSynth].del, \mix, 0.8,
			\outputGain, 6.dbamp], ~group[\fx], \addToTail),

		\del: Synth(\pingPongDelayStereo, [\in, ~boyBus[\endSynth].del, \out, ~boyBus[\endSynth].fader, \delay, 0.549,
			\mix, 0.3, \decay, 8], ~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~boyBus[\endSynth].fader, \out, ~mixer[\s3], \amp, 1], ~group[\fx], \addToTail)
	);

	Pbindef(\endSynthLoop,
	\instrument, \hammond,
	\out, ~boyBus[\endSynth].gran,
	\group, ~boySynth[\endSynth].gran,
	\addAction, \addBefore,
	\subAmp, 0.7,
	\bassAmp, 0,
	\partial2Amp, 0.1,
	\partial3Amp, 0.01,
	\partial4Amp, 0,
	\partial5Amp, 0,
	\partial6Amp, 0.001,
	\partial8Amp, 0.005,
	\dur, 6,
	\dist, 0.65,
	\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
	\root, 7,
	\octave, 6,
	\note, Pseq([[-1, 0, 4], [-3, 1, 4]], inf),
	\amp, Pseq([0.15, 0.13], inf)
	);

	Pbindef(\endSynthD,
		\instrument, \hammond,
		\out, ~boyBus[\endSynth].gran,
		\group, ~boySynth[\endSynth].gran,
		\addAction, \addBefore,
		\subAmp, 0.7,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.01,
		\partial4Amp, 0,
		\partial5Amp, 0,
		\partial6Amp, 0.001,
		\partial8Amp, 0.005,
		\dist, 0.65,
		\octave, 6,
		\root, 7,
		\dur, 4,
		\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
		\note, Pseq([-5], 1),
		\amp, 0.15
	);

	Pbindef(\endSynthDSharp,
		\instrument, \hammond,
		\out, ~boyBus[\endSynth].gran,
		\group, ~boySynth[\endSynth].gran,
		\addAction, \addBefore,
		\subAmp, 0.7,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.01,
		\partial4Amp, 0,
		\partial5Amp, 0,
		\partial6Amp, 0.001,
		\partial8Amp, 0.005,
		\dist, 0.65,
		\octave, 6,
		\root, 7,
		\dur, 6,
		\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
		\note, Pseq([-4], 1),
		\amp, 0.15
	);

	Pbindef(\endSynthAMajorOne,
		\instrument, \hammond,
		\out, ~boyBus[\endSynth].gran,
		\group, ~boySynth[\endSynth].gran,
		\addAction, \addBefore,
		\subAmp, 0.7,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.01,
		\partial4Amp, 0,
		\partial5Amp, 0,
		\partial6Amp, 0.001,
		\partial8Amp, 0.005,
		\dist, 0.65,
		\octave, 6,
		\root, 7,
		\dur, Pseq([3, 3], 1),
		\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
		\note, Pseq([[-3, 2], [-3, 2, 6]], 1),
		\amp, Pseq([0.12, 0.14], 1)
	);

	Pbindef(\endSynthCSharpMinorOne,
		\instrument, \hammond,
		\out, ~boyBus[\endSynth].gran,
		\group, ~boySynth[\endSynth].gran,
		\addAction, \addBefore,
		\subAmp, 0.7,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.01,
		\partial4Amp, 0,
		\partial5Amp, 0,
		\partial6Amp, 0.001,
		\partial8Amp, 0.005,
		\dist, 0.65,
		\octave, 6,
		\root, 7,
		\dur, 6,
		\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
		\note, Pseq([[-3, 1, 6, 9]], 1),
		\amp, 0.15
	);

	Pbindef(\endSynthGSharpMinor,
		\instrument, \hammond,
		\out, ~boyBus[\endSynth].gran,
		\group, ~boySynth[\endSynth].gran,
		\addAction, \addBefore,
		\subAmp, 0.7,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.01,
		\partial4Amp, 0,
		\partial5Amp, 0,
		\partial6Amp, 0.001,
		\partial8Amp, 0.005,
		\dist, 0.65,
		\octave, 6,
		\root, 7,
		\dur, 8,
		\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
		\note, Pseq([[-4, 1, 4, 8]], 1),
		\amp, 0.13
	);

	Pbindef(\endSynthAMajorTwo,
		\instrument, \hammond,
		\out, ~boyBus[\endSynth].gran,
		\group, ~boySynth[\endSynth].gran,
		\addAction, \addBefore,
		\subAmp, 0.7,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.01,
		\partial4Amp, 0,
		\partial5Amp, 0,
		\partial6Amp, 0.001,
		\partial8Amp, 0.005,
		\dist, 0.65,
		\octave, 6,
		\root, 7,
		\dur, 6,
		\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
		\note, Pseq([[-3, 2, 6]], 1),
		\amp, 0.1
	);

	Pbindef(\endSynthCSharpMinorTwo,
		\instrument, \hammond,
		\out, ~boyBus[\endSynth].gran,
		\group, ~boySynth[\endSynth].gran,
		\addAction, \addBefore,
		\subAmp, 0.7,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.01,
		\partial4Amp, 0,
		\partial5Amp, 0,
		\partial6Amp, 0.001,
		\partial8Amp, 0.005,
		\dist, 0.65,
		\octave, 6,
		\root, 7,
		\dur, 6,
		\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
		\note, Pseq([[1, 6, 9]], 1),
		\amp, 0.12
	);

	Pbindef(\endSynthAMajorSix,
		\instrument, \hammond,
		\out, ~boyBus[\endSynth].gran,
		\group, ~boySynth[\endSynth].gran,
		\addAction, \addBefore,
		\subAmp, 0.7,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.01,
		\partial4Amp, 0,
		\partial5Amp, 0,
		\partial6Amp, 0.001,
		\partial8Amp, 0.005,
		\dist, 0.65,
		\octave, 6,
		\root, 7,
		\dur, Pseq([6, 6], 1),
		\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
		\note, Pseq([[2, 6, 9, 11], [2, 6, 9, 11, 13]], 1),
		\amp, 0.14
	);

	Pbindef(\endSynthBMajor,
		\instrument, \hammond,
		\out, ~boyBus[\endSynth].gran,
		\group, ~boySynth[\endSynth].gran,
		\addAction, \addBefore,
		\subAmp, 0.7,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.01,
		\partial4Amp, 0,
		\partial5Amp, 0,
		\partial6Amp, 0.001,
		\partial8Amp, 0.005,
		\dist, 0.65,
		\octave, 6,
		\root, 7,
		\dur, 12,
		\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
		\note, Pseq([[4, 8, 11, 16]], inf),
		\amp, 0.11
	);

	Pbindef(\endSynthCSharp,
		\instrument, \hammond,
		\out, ~boyBus[\endSynth].gran,
		\group, ~boySynth[\endSynth].gran,
		\addAction, \addBefore,
		\subAmp, 0.7,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.01,
		\partial4Amp, 0,
		\partial5Amp, 0,
		\partial6Amp, 0.001,
		\partial8Amp, 0.005,
		\dist, 0.65,
		\octave, 6,
		\root, 7,
		\dur, 6,
		\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
		\note, Pseq([6], inf),
		\amp, 0.12
	);

};

~boy[\endSynth].addUniqueMethod(\kill, {
	~boyBus[\endSynth].do({ | i | i.free; });
	~boySynth[\endSynth].do({ | i | i.free; });
	Pbindef(\endSynthLoop).clear;
	Pbindef(\endSynthD).clear;
	Pbindef(\endSynthDSharp).clear;
	Pbindef(\endSynthAMajorOne).clear;
	Pbindef(\endSynthCSharpMinorOne).clear;
	Pbindef(\endSynthGSharpMinor).clear;
	Pbindef(\endSynthAMajorTwo).clear;
	Pbindef(\endSynthCSharpMinorTwo).clear;
	Pbindef(\endSynthAMajorSix).clear;
	Pbindef(\endSynthBMajor).clear;
	Pbindef(\endSynthCSharp).clear
});

~boyMake[\endSynth] = r({ | main |

	var val, loop, d, dSharp, aOne, cSharpOne, gSharp, aTwo, cSharpTwo, aSix, bMajor, cSharp, vol;
	val = main.at(0);
	loop = main.at(1);
	d = main.at(2);
	dSharp = main.at(3);
	aOne = main.at(4);
	cSharpOne = main.at(5);
	gSharp = main.at(6);
	aTwo = main.at(7);
	cSharpTwo = main.at(8);
	aSix = main.at(9);
	bMajor = main.at(10);
	cSharp = main.at(11);
	vol = main.at(12);

	loop {
		~boy[\endSynth].value;

		~ohm.turnYellow(loop);
		MIDIdef.noteOn(\endSynthLoop, { ~scLang.sendMsg(\endSynth, \loop, loop); }, loop);
		~ohm.turnYellow(d);
		MIDIdef.noteOn(\endSynthD, { ~scLang.sendMsg(\endSynth, \d, d); }, d);
		~ohm.turnYellow(dSharp);
		MIDIdef.noteOn(\endSynthDSharp, { ~scLang.sendMsg(\endSynth, \dSharp, dSharp); }, dSharp);
		~ohm.turnYellow(aOne);
		MIDIdef.noteOn(\endSynthAOne, { ~scLang.sendMsg(\endSynth, \aOne, aOne); }, aOne);
		~ohm.turnYellow(cSharpOne);
		MIDIdef.noteOn(\endSynthCSharpOne, { ~scLang.sendMsg(\endSynth, \cSharpOne, cSharpOne); }, cSharpOne);
		~ohm.turnYellow(gSharp);
		MIDIdef.noteOn(\endSynthGSharp, { ~scLang.sendMsg(\endSynth, \gSharp, gSharp); }, gSharp);
		~ohm.turnYellow(aTwo);
		MIDIdef.noteOn(\endSynthATwo, { ~scLang.sendMsg(\endSynth, \aTwo, aTwo); }, aTwo);
		~ohm.turnYellow(cSharpTwo);
		MIDIdef.noteOn(\endSynthCSharpTwo, { ~scLang.sendMsg(\endSynth, \cSharpTwo, cSharpTwo); }, cSharpTwo);
		~ohm.turnYellow(aSix);
		MIDIdef.noteOn(\endSynthASix, { ~scLang.sendMsg(\endSynth, \aSix, aSix); }, aSix);
		~ohm.turnYellow(bMajor);
		MIDIdef.noteOn(\endSynthBMajor, { ~scLang.sendMsg(\endSynth, \bMajor, bMajor); }, bMajor);
		~ohm.turnYellow(cSharp);
		MIDIdef.noteOn(\endSynthCSharp, { ~scLang.sendMsg(\endSynth, \cSharp, cSharp); }, cSharp);

		MIDIdef.cc(\endSynthVolume, { | amp | ~scLang.sendMsg(\endSynth, \volume, amp); }, vol);

		["endSynth Synths Active"].postln;
		~ohm.turnPink(val).yield;

		~boy[\endSynth].kill;
		MIDIdef(\endSynthLoop).free;
		MIDIdef(\endSynthD).free;
		MIDIdef(\endSynthDSharp).free;
		MIDIdef(\endSynthAOne).free;
		MIDIdef(\endSynthCSharpOne).free;
		MIDIdef(\endSynthGSharp).free;
		MIDIdef(\endSynthATwo).free;
		MIDIdef(\endSynthCSharpTwo).free;
		MIDIdef(\endSynthASix).free;
		MIDIdef(\endSynthBMajor).free;
		MIDIdef(\endSynthCSharp).free;
		MIDIdef(\endSynthVolume).free;
		~ohm.turnOff(loop);
		~ohm.turnOff(d);
		~ohm.turnOff(dSharp);
		~ohm.turnOff(aOne);
		~ohm.turnOff(cSharpOne);
		~ohm.turnOff(gSharp);
		~ohm.turnOff(aTwo);
		~ohm.turnOff(cSharpTwo);
		~ohm.turnOff(aSix);
		~ohm.turnOff(bMajor);
		~ohm.turnOff(cSharp);
		["endSynth Synths Freed"].postln;
		~ohm.turnRed(val).yield;
	};
});

~boyMake[\endSynthLoop] = r({ | val |
	loop {
		Pbindef(\endSynthLoop).play(~boy[\transport]);
		["end synth loop playing"].postln;
		~ohm.turnBlue(val).yield;

		Pbindef(\endSynthLoop).stop;
		["end synth loop stopped"].postln;
		~ohm.turnRed(val).yield;
	};
});

~boyMake[\endSynthD] = r({ | val |
	loop {
		Pbindef(\endSynthD).play(~boy[\transport]);
		["D"].postln;
		~ohm.turnPink(val);
		{ ~ohm.turnYellow(val) }.defer(4).yield;
	};
});

~boyMake[\endSynthDSharp] = r({ | val |
	loop {
		Pbindef(\endSynthDSharp).play(~boy[\transport]);
		["d sharp"].postln;
		~ohm.turnPink(val);
		{ ~ohm.turnYellow(val); }.defer(6).yield;
	};
});

~boyMake[\endSynthAMajorOne] = r({ | val |
	loop {
		Pbindef(\endSynthAMajorOne).play(~boy[\transport]);
		["a major"].postln;
		~ohm.turnPink(val);
		{ ~ohm.turnYellow(val); }.defer(6).yield;
	};
});

~boyMake[\endSynthCSharpMinorOne] = r({ | val |
	loop {
		Pbindef(\endSynthCSharpMinorOne).play(~boy[\transport]);
		["c sharp minor"].postln;
		~ohm.turnPink(val);
		{ ~ohm.turnYellow(val); }.defer(6).yield;
	}
});

~boyMake[\endSynthGSharpMinor] = r({ | val |
	loop {
		Pbindef(\endSynthGSharpMinor).play(~boy[\transport]);
		["g sharp minor"].postln;
		~ohm.turnPink(val);
		{ ~ohm.turnYellow(val); }.defer(8).yield;
	};
});

~boyMake[\endSynthAMajorTwo] = r({ | val |
	loop{
		Pbindef(\endSynthAMajorTwo).play(~boy[\transport]);
		["a major"].postln;
		~ohm.turnPink(val);
		{ ~ohm.turnYellow(val); }.defer(6).yield;
	};
});

~boyMake[\endSynthCSharpMinorTwo] = r({ | val |
	loop {
		Pbindef(\endSynthCSharpMinorTwo).play(~boy[\transport]);
		["c sharp minor"].postln;
		~ohm.turnPink(val);
		{ ~ohm.turnYellow(val); }.defer(6).yield;
	};
});

~boyMake[\endSynthAMajorSix] = r({ | val |
	loop {
		Pbindef(\endSynthAMajorSix).play(~boy[\transport]);
		["a major 6 then 7th added"].postln;
		~ohm.turnPink(val);
		{ ~ohm.turnYellow(val); }.defer(12).yield;
	};
});

~boyMake[\endSynthBMajor] = r({ | val |
	loop {
		Pbindef(\endSynthBMajor).play(~boy[\transport]);
		["b major"].postln;
		~ohm.turnPink(val).yield;

		Pbindef(\endSynthBMajor).stop;
		["b major stopped"].postln;
		~ohm.turnYellow(val).yield;
	};
});

~boyMake[\endSynthCSharp] = r({ | val |
	loop {
		Pbindef(\endSynthCSharp).play(~boy[\transport]);
		["C sharp"].postln;
		~ohm.turnPink(val).yield;

		Pbindef(\endSynthCSharp).stop;
		["C Sharp Stopped"].postln;
		~ohm.turnYellow(val).yield;
	};
});






/*

Pbindef(\endSynth).play(~boy[\transport]);
Pbindef(\endSynth).stop;
~boySynth[\endSynth].gran.set(\mix, 0.9, \trigRate, 15)
~boySynth[\endSynth].del.set(\decay, 8, \mix, 0.3)
~boySynth[\endSynth].verb.set(\out, ~boyBus[\endSynth].broken, \mix, 0.3)
~boySynth[\endSynth].broken.set(\outputGain, 6.dbamp, \mix, 0.8)


Pbindef(\endSynthD).play(~boy[\transport])
Pbindef(\endSynthDSharp).play(~boy[\transport])
Pbindef(\endSynthAMajorOne).play(~boy[\transport])
Pbindef(\endSynthCSharpMinorOne).play(~boy[\transport])
Pbindef(\endSynthGSharpMinor).play(~boy[\transport])
Pbindef(\endSynthAMajorTwo).play(~boy[\transport])
Pbindef(\endSynthCSharpMinorTwo).play(~boy[\transport])
Pbindef(\endSynthAMajorSix).play(~boy[\transport])
Pbindef(\endSynthBMajor).play(~boy[\transport])
Pbindef(\endSynthCSharp).play(~boy[\transport])

Pbindef(\endSynthBMajor).stop
Pbindef(\endSynthCSharp).stop

Pbindef(\endSynthLoop).stop
Pbindef(\endSynth).stop

s.meter





Pbindef.removeAll
*/
