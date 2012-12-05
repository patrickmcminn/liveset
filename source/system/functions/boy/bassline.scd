/*
Friday, November 23rd 2012
bassline.scd
prm
*/

~boy[\bassline] = {
	var gMajor7, eMajor7, dMajor7, aMajor;
	gMajor7 = [0, 12, 16, 19, 23];
	eMajor7 = [-3, 9, 13, 16, 20];
	dMajor7 = [-5, 7, 11, 14, 18];
	aMajor = [-10, 2, 9, 14, 18];

	~boyBus[\bassline] = (
		\inFader: Bus.audio,
		\eq: Bus.audio,
		\verb: Bus.audio,
		\fader: Bus.audio
	);

	~boySynth[\bassline] = (

		\inFader: Synth(\fader, [\in, ~boyBus[\bassline].inFader, \out, ~boyBus[\bassline].eq], ~group[\fx], \addToTail),

		\eq: Synth(\eq3, [\in, ~boyBus[\bassline].eq, \out, ~boyBus[\bassline].verb,
			\loGain, 2, \hiFreq, 7000, \hiGain, -70], ~group[\fx], \addToTail),

		\verb: Synth(\reverb1, [\in, ~boyBus[\bassline].verb, \out, ~boyBus[\bassline].fader, \mix, 0.4, \room, 0.6],
			~group[\fx], \addToTail),

		\fader: Synth(\pan, [\in, ~boyBus[\bassline].fader, \out, ~mixer[\s2]], ~group[\fx], \addToTail)
	);

	Pbindef(\boyBasslineOne,
		\instrument, \pianoFade,
		\group, ~boySynth[\bassline].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\bassline].inFader,
		\amp, 1,
		\cutoff, 1000,
		\loGain, 6,
		\legato, 1,
		\root, 7,
		\note, Pstutter(
			Pseq([16, 14, 12, 9], inf),
			Pseq([gMajor7, eMajor7, dMajor7, aMajor], inf)
		),
		\dur, Pstutter(
			Pseq([16, 14, 12, 9], inf),
			Pseq([0.25, 0.25, 1/3, 0.5], inf)
		),
		\atk, 0.12,
		\sus, Pkey(\dur) * 4.5,
		\octave, 3
	);

	Pbindef(\boyBasslineTwo,
		\instrument, \pianoFade,
		\group, ~boySynth[\bassline].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\bassline].inFader,
		\amp, 1.2,
		\cutoff, 1000,
		\loGain, 6,
		\legato, 1,
		\root, 7,
		\note, Pstutter(
			Pseq([16, 14, 18, 7, 12, 9, 5, 1, 8], inf),
			Pseq([gMajor7, eMajor7, gMajor7, eMajor7, dMajor7, aMajor, gMajor7, gMajor7, dMajor7], inf)
		),
		\dur, Pstutter(
			Pseq([16, 14, 18, 7, 12, 9, 5, 1, 8], inf),
			Pseq([0.25, 0.25, 0.25, 0.5, 1/3, 0.5, 0.75, 0.25, 0.5], inf)
		),
		\atk, 0.07,
		\sus, Pkey(\dur) * 5,
		\octave, 3
	);

	Pbindef(\boyBasslineTwoLow,
		\instrument, \ratioSaw,
		\group, ~boySynth[\bassline].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\bassline].inFader,
		\filterMul, 6,
		\root, 7,
		\note, Pseq([12, 9, 12, 9, 7, 5, 12, 7], inf),
		\dur, Pseq([4, 3.5, 4.5, 3.5, 4, 4.5, 4, 4], inf),
		\atk, 0.01,
		\rel, 0.01,
		\sus, Pkey(\dur)*0.732,
		\octave, 1,
		\amp, 1,
	);

	Pbindef(\boyBasslineThree,
		\instrument, \pianoFade,
		\group, ~boySynth[\bassline].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\bassline].inFader,
		\amp, 1,
		\cutoff, 800,
		\loGain, 6,
		\legato, 1,
		\root, 7,
		\note, Pstutter(
			Pseq([16, 14, 18, 7], inf),
			Pseq([gMajor7, eMajor7], inf)
		),
		\dur, Pstutter(
			Pseq([16, 14, 18, 17], inf),
			Pseq([0.25, 0.25, 0.25, 0.5], inf)
		),
		\atk, 0.12,
		\sus, Pkey(\dur) * 4.5,
		\octave, 3
	);

	Pbindef(\boyBasslineThreeLow,
		\instrument, \ratioSaw,
		\group, ~boySynth[\bassline].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\bassline].inFader,
		\filterMul, 6,
		\root, 7,
		\octave, 1,
		\note, Pseq([12, 9], inf),
		\dur, Pseq([4, 3.5, 4.5, 3.5], inf),
		\atk, 0.01,
		\rel, 0.01,
		\sus, Pkey(\dur)*0.732,
		\amp, 1
	);

};

~boy[\bassline].addUniqueMethod(\kill, {
	~boyBus[\bassline].do({ | i | i.free; });
	~boySynth[\bassline].do({ | i | i.free; });
	Pbindef(\boyBasslineOne).stop;
	Pbindef(\boyBasslineTwo).stop;
	Pbindef(\boyBasslineThree).stop;
	Pbindef(\boyBasslineTwoLow).stop;
	Pbindef(\boyBasslineThreeLow).stop;
	Pbindef(\boyBasslineOne).remove;
	Pbindef(\boyBasslineTwo).remove;
	Pbindef(\boyBasslineThree).remove;
	Pbindef(\boyBasslineTwoLow).remove;
	Pbindef(\boyBasslineThreeLow).remove;
});

~boy[\bassline].addUniqueMethod(\playOne, {
	~boy[\transport].playNextBar({
		Pbindef(\boyBasslineOne).play(~boy[\transport]);
	});
});

~boy[\bassline].addUniqueMethod(\playTwo, {
	~boy[\transport].playNextBar({
		Pbindef(\boyBasslineTwo).play(~boy[\transport]);
		Pbindef(\boyBasslineTwoLow).play(~boy[\transport]);
	});
});

~boy[\bassline].addUniqueMethod(\playThree, {
	~boy[\transport].playNextBar({
		Pbindef(\boyBasslineThree).play(~boy[\transport]);
		Pbindef(\boyBasslineThreeLow).play(~boy[\transport]);
	});
});

~boy[\bassline].addUniqueMethod(\stopOne, {
	Pbindef(\boyBasslineOne).stop;
});

~boy[\bassline].addUniqueMethod(\stopTwo, {
	Pbindef(\boyBasslineTwo).stop;
	Pbindef(\boyBasslineTwoLow).stop;
});

~boy[\bassline].addUniqueMethod(\stopThree, {
	Pbindef(\boyBasslineThree).stop;
	Pbindef(\boyBasslineThreeLow).stop;
});

~boyMake[\bassline] = r({ | main |
	var val, basslineOne, basslineTwo, basslineThree, vol, cutoff;
	val = main.at(0);
	basslineOne = main.at(1);
	basslineTwo = main.at(2);
	basslineThree = main.at(3);
	vol = main.at(4);
	cutoff = main.at(5);

	loop {
		~boy[\bassline].value;

		~ohm.turnPurple(basslineOne);
		MIDIdef.noteOn(\boyBasslineOne, { ~scLang.sendMsg(\boyBassline, \one, basslineOne); }, basslineOne);
		~ohm.turnLavender(basslineTwo);
		MIDIdef.noteOn(\boyBasslineTwo, { ~scLang.sendMsg(\boyBassline, \two, basslineTwo); }, basslineTwo);
		~ohm.turnPink(basslineThree);
		MIDIdef.noteOn(\boyBasslineThree, { ~scLang.sendMsg(\boyBassline, \three, basslineThree); }, basslineThree);
		MIDIdef.cc(\boyBasslineVolume, { | amp | ~scLang.sendMsg(\boyBassline, \volume, amp); }, vol);
		MIDIdef.cc(\boyBasslineCutoff, { | cutoff | ~scLang.sendMsg(\boyBassline, \cutoff, cutoff); }, cutoff);

		["bassline synths created"].postln;
		~ohm.turnPink(val).yield;

		~boy[\bassline].kill;
		~ohm.turnOff(basslineOne);
		~ohm.turnOff(basslineTwo);
		~ohm.turnOff(basslineThree);
		MIDIdef(\boyBasslineOne).free;
		MIDIdef(\boyBasslineTwo).free;
		MIDIdef(\boyBasslineThree).free;
		MIDIdef(\boyBasslineVolume).free;
		MIDIdef(\boyBasslineCutoff).free;
		["bassline synths freed"].postln;
		~ohm.turnRed(val).yield;
	};
});

~boyMake[\basslineOne] = r({ | val |
	loop {

		~boy[\bassline].playOne;
		["bassline one playing"].postln;
		~ohm.turnBlue(val).yield;

		~boy[\bassline].stopOne;
		["bassline one stopped"].postln;
		~ohm.turnRed(val).yield;
	};
});

~boyMake[\basslineTwo] = r ({ | val |
	loop {
		~boy[\bassline].playTwo;
		["bassline two playing"].postln;
		~ohm.turnYellow(val).yield;

		~boy[\bassline].stopTwo;
		["bassline two stopped"].postln;
		~ohm.turnRed(val).yield;
	};
});

~boyMake[\basslineThree] = r({ | val |
	loop {
		~boy[\bassline].playThree;
		["bassline three playing"].postln;
		~ohm.turnPink(val).yield;

		~boy[\bassline].stopThree;
		["bassline three playing"].postln;
		~ohm.turnRed(val).yield;
	};
});
