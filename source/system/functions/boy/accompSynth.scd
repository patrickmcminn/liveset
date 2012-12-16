/*
Sunday, December 12th, 2012
accompSynth.scd
prm
*/

~boy[\accompSynth] = {

	~boyBus[\accompSynth] = (
		\eq: Bus.audio,
		\reverb: Bus.audio,
		\dist: Bus.audio,
		\nebula: Bus.audio,
		\del: Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);

	~boySynth[\accompSynth] = (
		\eq: Synth(\eq3, [\in, ~boyBus[\accompSynth].eq, \out, ~boyBus[\accompSynth].reverb, \hiGain, -3.84],
			~group[\fx], \addToTail),
		\reverb: Synth(\reverb1, [\in, ~boyBus[\accompSynth].reverb, \out, ~boyBus[\accompSynth].dist,
			\room: 0.7, \mix, 0.75], ~group[\fx], \addToTail),
		\dist: Synth(\digitalClip2, [\in, ~boyBus[\accompSynth].dist, \out, ~boyBus[\accompSynth].nebula,
			\amount, 25, \amp, 0.5], ~group[\fx], \addToTail),
		\nebula: Synth(\nebula8, [\in, ~boyBus[\accompSynth].nebula, \out, ~boyBus[\accompSynth].del, \activity, 100,
			\depth, 0.35], ~group[\fx], \addToTail),
		\del: Synth(\pingPongDelayStereo, [\in, ~boyBus[\accompSynth].del, \out, ~boyBus[\accompSynth].fader,
			\delay, 0.915, \mix, 0.36,\decay, 6, \centerFreq, 1000, \bw, 4], ~group[\fx], \addToTail),
		\fader: Synth(\stereoFader, [\in, ~boyBus[\accompSynth].fader, \out, ~mixer[\s1], \amp, -9.dbamp],
			~group[\fx], \addToTail)
	);

	~boyPatterns[\accompSynth] = (

		\one: Pbind(
			\instrument, \playBuf,
			\out, ~boyBus[\accompSynth].eq,
			\group, ~boySynth[\accompSynth].eq,
			\addAction, \addBefore,
			\root, 7,
			\octave, 5,
			\note, Pseq([7, 4, 2, 4], 1),
			\dur, Pseq([0.5, 3.5, 0.5, 4], 1),
			\atk, 0.05,
			\rel, 0.05,
			\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
			\freq, Pfunc { | ev | ev.use(ev[\freq]) },
			\bufName, Pfunc({ | ev | ~boyBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })
		),

		\two: Pbind(
			\instrument, \playBuf,
			\out, ~boyBus[\accompSynth].eq,
			\group, ~boySynth[\accompSynth].eq,
			\addAction, \addBefore,
			\root, 7,
			\octave, 5,
			\note, Pseq([7, 4, 2, 4], 1),
			\dur, Pseq([0.5, 3.5, 1.5, 2.5], 1),
			\atk, 0.05,
			\rel, 0.05,
			\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
			\freq, Pfunc { | ev | ev.use(ev[\freq]) },
			\bufName, Pfunc({ | ev | ~boyBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })
		),

		\three: Pbind(
			\instrument, \playBuf,
			\out, ~boyBus[\accompSynth].eq,
			\group, ~boySynth[\accompSynth].eq,
			\addAction, \addBefore,
			\root, 7,
			\octave, 5,
			\note, Pseq([7, 4, 2, 4], 1),
			\dur, Pseq([1, 3.5, 1, 2], 1),
			\atk, 0.05,
			\rel, 0.05,
			\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
			\freq, Pfunc { | ev | ev.use(ev[\freq]) },
			\bufName, Pfunc({ | ev | ~boyBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })
		),

		\four: Pbind(
			\instrument, \playBuf,
			\out, ~boyBus[\accompSynth].eq,
			\group, ~boySynth[\accompSynth].eq,
			\addAction, \addBefore,
			\root, 7,
			\octave, 5,
			\note, Pseq([7, 2], 1),
			\dur, Pseq([0.5, 4], 1),
			\atk, 0.05,
			\rel, 0.05,
			\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
			\freq, Pfunc { | ev | ev.use(ev[\freq]) },
			\bufName, Pfunc({ | ev | ~boyBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })
		),

		\five: Pbind(
			\instrument, \playBuf,
			\out, ~boyBus[\accompSynth].eq,
			\group, ~boySynth[\accompSynth].eq,
			\addAction, \addBefore,
			\root, 7,
			\octave, 5,
			\note, Pseq([7, 0], 1),
			\dur, Pseq([0.5, 4], 1),
			\atk, 0.05,
			\rel, 0.05,
			\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
			\freq, Pfunc { | ev | ev.use(ev[\freq]) },
			\bufName, Pfunc({ | ev | ~boyBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })
		),

		\six: Pbind(
			\instrument, \playBuf,
			\out, ~boyBus[\accompSynth].eq,
			\group, ~boySynth[\accompSynth].eq,
			\addAction, \addBefore,
			\root, 7,
			\octave, 5,
			\note, Pseq([7, 0, -1], 1),
			\dur, Pseq([1, 3, 4], 1),
			\atk, 0.05,
			\rel, 0.05,
			\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
			\freq, Pfunc { | ev | ev.use(ev[\freq]) },
			\bufName, Pfunc({ | ev | ~boyBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })
		),

		\seven: Pbind(
			\instrument, \playBuf,
			\out, ~boyBus[\accompSynth].eq,
			\group, ~boySynth[\accompSynth].eq,
			\addAction, \addBefore,
			\root, 7,
			\octave, 5,
			\note, Pseq([11, 12, 2], 1),
			\dur, Pseq([1, 1.5, 3.5], 1),
			\atk, 0.05,
			\rel, 0.05,
			\sus, Pkey(\dur) * (1/~boy[\transport].tempo),
			\freq, Pfunc { | ev | ev.use(ev[\freq]) },
			\bufName, Pfunc({ | ev | ~boyBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })
		);
	);
	Pdef(\phraseOne, Pdict(~boyPatterns[\accompSynth],
		Prand([\one, \two, \three], 1))
	);
	Pdef(\phraseTwo, Pdict(~boyPatterns[\accompSynth],
		Prand([\four, \five, \six], 1))
	);
	Pdef(\phraseThree, Pdict(~boyPatterns[\accompSynth],
		Pseq([\seven], 1))
	);
};

~boy[\accompSynth].addUniqueMethod(\kill, {
	~boyBus[\accompSynth].do({ | i | i.free });
	~boySynth[\accompSynth].do({ | i | i.free; });
});

~boyMake[\accompSynth] = r({
	loop {
		~boy[\accompSynth].value;
		~scLang.sendMsg(\control, \accompSynth);
		["accomp synths created"].postln.yield;

		~boy[\accompSynth].kill;
		~scLang.sendMsg(\control, \accompSynth);
		["accomp synths freed"].postln.yield;
	};
});

~boyMake[\accompSynthPhraseOne] = r({
	loop {
		Pdef(\phraseOne).play(~boy[\transport]);
		~scLang.sendMsg(\control, \accompSynthPhraseOne);
		["phrase one playing"].postln.yield;
	};
});

~boyMake[\accompSynthPhraseTwo] = r({
	loop {
		Pdef(\phraseTwo).play(~boy[\transport]);
		~scLang.sendMsg(\control, \accompSynthPhraseTwo);
		["phrase two playing"].postln.yield;
	};
});

~boyMake[\accompSynthPhraseThree] = r({
	loop {
		Pdef(\phraseThree).play(~boy[\transport]);
		~scLang.sendMsg(\control, \accompSynthPhraseThree);
		["phrase three playing"].postln.yield;
	};
});