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

		\verb: Synth(\reverb1, [\in, ~boyBus[\bassline].verb, \out, ~boyBus[\bassline].fader, \mix, 0.3, \room, 0.6],
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
			Pseq([16, 14, 18, 7], inf),
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

~boyMake[\bassline] = r({
	loop {
		~boy[\bassline].value;
		~scLang.sendMsg(\control, \boyBassline);
		["bassline synths created"].postln.yield;


		~boy[\bassline].kill;
		~scLang.sendMsg(\control, \boyBassline);
		["bassline synths freed"].postln.yield;
	};
});

~boyMake[\basslineOne] = r({
	loop {
		~boy[\bassline].playOne;
		~scLang.sendMsg(\control, \boyBasslineOne);
		["bassline one playing"].postln.yield;


		~boy[\bassline].stopOne;
		~scLang.sendMsg(\control, \boyBasslineOne);
		["bassline one stopped"].postln.yield;
	};
});

~boyMake[\basslineTwo] = r ({
	loop {
		~boy[\bassline].playTwo;
		~scLang.sendMsg(\control, \boyBasslineTwo);
		["bassline two playing"].postln.yield;

		~boy[\bassline].stopTwo;
		~scLang.sendMsg(\control, \boyBasslineTwo);
		["bassline two stopped"].postln.yield;
	};
});

~boyMake[\basslineThree] = r({
	loop {
		~boy[\bassline].playThree;
		~scLang.sendMsg(\control, \boyBasslineThree);
		["bassline three playing"].postln.yield;

		~boy[\bassline].stopThree;
		~scLang.sendMsg(\control, \boyBasslineThree);
		["bassline three playing"].postln.yield;
	};
});
