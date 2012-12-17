/*
Friday, November 2nd, 2012
noiseSynth.scd
prm
*/


(
~birds[\noiseSynth] = {

	var attack, sustain, release;
	attack = 0.05;
	sustain = 0.5;
	release = 3;

	~birdsBus[\noiseSynth] = (
		\pan: Bus.control,
		\gran: Bus.audio,
		\delay: Bus.audio(s, 2),
		\verb: Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);

	~birdsSynth[\noiseSynth] = (

		\pan: Synth(\lfSin, [\out, ~birdsBus[\noiseSynth].pan, \freq, 0.14, \rangeLo, -0.7, \rangeHi, 0.7],
			~group[\control], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~birdsBus[\noiseSynth].gran, \out, ~birdsBus[\noiseSynth].delay,
				\bufLength, 4, \pan, ~birdsBus[\noiseSynth].pan.asMap, \panOffset, 0,
				\grainDur, 0.5, \grainDurOffset, 0.1, \trigRate, 45, \mix, 1
			],
			~group[\fx], \addToTail),

		\delay: Synth(\delayStereo, [\in, ~birdsBus[\noiseSynth].delay, \out, ~birdsBus[\noiseSynth].verb,
			\delayTime, 1, \decayTime, 5, \amp, 1, \mix, 0.3], ~group[\fx], \addToTail),

		\verb: Synth(\reverb2, [\in, ~birdsBus[\noiseSynth].verb, \out, ~birdsBus[\noiseSynth].fader,
			\mix, 0.1, \room, 0.5, \damp, 0.4, \amp, 1], ~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~birdsBus[\noiseSynth].fader, \out, ~mixer[\s3], \amp, -20.dbamp],
			~group[\fx], \addToTail)
	);


	~birdsPatterns[\noiseSynth] = (
		\phrase1: (
			\one: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.4, 0.7, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 4,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\loop, 1,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\two: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.4, 0.7, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 4,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\three: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.4, 0.7, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 4,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([6, 4], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\four: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.4, 0.7, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 4,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\five: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.4, 0.7, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 6,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\six: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.4, 0.7, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 4,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\seven: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.4, 0.7, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 4,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([6, 4], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\eight: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.4, 0.7, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 4,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\nine: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.4, 0.7, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 4,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([6, 6], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\ten: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.4, 0.7, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 4/3,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) }))
		),

		\phrase2: (
			\one: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.5, 0.75, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 2,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\loop, 1,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\two: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.5, 0.75, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 2,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\three: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.5, 0.75, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 2,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([6, 4], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\four: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.5, 0.75, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 2,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\five: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.5, 0.75, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 3,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\six: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.5, 0.75, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 4,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\seven: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.5, 0.75, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 2,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([6, 4], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\eight: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.5, 0.75, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 6,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\nine: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.5, 0.75, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 3,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([6, 6], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\ten: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.5, 0.75, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 2/3,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) }))
		),

		\phrase3: (
			\one: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.55, 0.8, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 1,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\loop, 1,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\two: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.55, 0.8, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 1,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\three: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.55, 0.8, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 1,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([6, 4], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\four: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.55, 0.8, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 1,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\five: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.55, 0.8, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 1.5,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\six: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.55, 0.8, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 2,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\seven: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.55, 0.8, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 1,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([6, 4], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\eight: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.55, 0.8, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 3,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\nine: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.55, 0.8, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 1.5,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([6, 6], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\ten: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.55, 0.8, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 1/3,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) }))
		),
		\phrase4: (
			\one: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.8, 0.85, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 0.5,
				\attack, attack,
				\sustain, sustain,
				\release, release/2,
				\loop, 1,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\two: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.8, 0.85, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 0.5,
				\attack, attack,
				\sustain, sustain,
				\release, release/2,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\three: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.8, 0.85, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 0.5,
				\attack, attack,
				\sustain, sustain,
				\release, release/2,
				\degree, Pseq([6, 4], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\four: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.8, 0.85, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 0.5,
				\attack, attack,
				\sustain, sustain,
				\release, release/2,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\five: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.8, 0.85, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 0.75,
				\attack, attack,
				\sustain, sustain,
				\release, release/2,
				\degree, Pseq([2, 1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\six: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.8, 0.85, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 1,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\seven: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.8, 0.85, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 0.5,
				\attack, attack,
				\sustain, sustain,
				\release, release/2,
				\degree, Pseq([6, 4], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\eight: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.8, 0.85, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 1.5,
				\attack, attack,
				\sustain, sustain,
				\release, release/2,
				\degree, Pseq([1], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\nine: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.8, 0.85, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 0.75,
				\attack, attack,
				\sustain, sustain,
				\release, release/2,
				\degree, Pseq([6, 6], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

			\ten: Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.8, 0.85, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 4,
				\dur, 1/6,
				\attack, attack,
				\sustain, sustain,
				\release, release/2,
				\degree, Pseq([7, 2], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) }))
		)
	);
	Pdef(\phrase1, Pdict(~birdsPatterns[\noiseSynth].phrase1,
		Prand([\one, \two, \three, \four, \five, \six, \seven, \eight, \nine, \ten], inf)));
	Pdef(\phrase2, Pdict(~birdsPatterns[\noiseSynth].phrase2,
		Prand([\one, \two, \three, \four, \five, \six, \seven, \eight, \nine, \ten], inf)));
	Pdef(\phrase3, Pdict(~birdsPatterns[\noiseSynth].phrase3,
		Prand([\one, \two, \three, \four, \five, \six, \seven, \eight, \nine, \ten], inf)));
	Pdef(\phrase4, Pdict(~birdsPatterns[\noiseSynth].phrase4,
		Prand([\one, \two, \three, \four, \five, \six, \seven, \eight, \nine, \ten], inf)));
	};

~birds[\noiseSynth].addUniqueMethod(\kill, {

	Pdef(\phrase1).stop;
	Pdef(\phrase2).stop;
	Pdef(\phrase3).stop;
	Pdef(\phrase4).stop;

	Pdef(\phrase1).clear;
	Pdef(\phrase2).clear;
	Pdef(\phrase3).clear;
	Pdef(\phrase4).clear;


	~birdsBus[\noiseSynth].do({ | i | i.free });
	~birdsSynth[\noiseSynth].do({ | i | i.free });
	~birdsPatterns[\noiseSynth].do({ | i | i.free });
	~birdsPatterns[\noiseSynth].do({ | i | i.clear });
});

~birds[\noiseSynth].addUniqueMethod(\granShift1, {
	~birdsBus[\noiseSynth].granControl = Bus.control;
	~birdsSynth[\noiseSynth].gran.set(\mix, ~birdsBus[\noiseSynth].granControl.asMap);
	Synth(\ctlLinLine, [\out, ~birdsBus[\noiseSynth].granControl, \start, 1, \end, 0.787, \dur, 15],
		~group[\control], \addToTail);
	{ ~birdsBus[\noiseSynth].granControl.free; }.defer(15);
});

~birds[\noiseSynth].addUniqueMethod(\granShift2, {
	~birdsBus[\noiseSynth].granControl = Bus.control;
	~birdsSynth[\noiseSynth].gran.set(\mix, ~birdsBus[\noiseSynth].granControl.asMap);
	Synth(\ctlLinLine, [\out, ~birdsBus[\noiseSynth].granControl, \start, 0.787, \end, 0, \dur, 30],
		~group[\control], \addToTail);
	{ ~birdsBus[\noiseSynth].granControl.free; }.defer(30);
});

~birds[\noiseSynth].addUniqueMethod(\volShift, {
	~birdsBus[\noiseSynth].volControl = Bus.control;
	~birdsSynth[\noiseSynth].fader.set(\amp, ~birdsBus[\noiseSynth].volControl.asMap);
	Synth(\ctlLinLine, [\out, ~birdsBus[\noiseSynth].volControl, \start, -20.dbamp, \end, -12.dbamp, \dur, 4],
		~group[\control], \addToTail);
	{ ~birdsBus[\noiseSynth].volControl.free; }.defer(4);
});


~birdsMake[\noiseSynth] = r ({
	loop {

		~birds[\noiseSynth].value;
		~scLang.sendMsg(\control, \noiseSynth);
		["noiseSynth Synths Active"].postln.yield;


		~birds[\noiseSynth].kill;
		~scLang.sendMsg(\control, \noisSynth);
		["noiseSynth Synths Freed"].postln.yield;
	}
});

~birdsMake[\noiseSynthPlay] = r({
	loop {

		Pdef(\phrase1).play;
		~scLang.sendMsg(\control, \noiseSynthPlay);
		["phrase 1 playing"].postln.yield;

		Pdef(\phrase2).play;
		Pdef(\phrase1).stop;
		~scLang.sendMsg(\control, \noiseSynthPlay);
		["phrase 2 playing"].postln.yield;

		Pdef(\phrase3).play;
		Pdef(\phrase2).stop;
		~scLang.sendMsg(\control, \noiseSynthPlay);
		["phrase 3 playing"].postln.yield;

		Pdef(\phrase4).play;
		Pdef(\phrase3).stop;
		~scLang.sendMsg(\control, \noiseSynthPlay);
		["phrase 4 playing"].postln.yield;

		Pdef(\phrase4).stop;
		~scLang.sendMsg(\control, \noiseSynthPlay);
		["all phrases stopped"].postln.yield;
	}
});

~birdsMake[\noiseSynthShift] = r ({
	loop {

		~birds[\noiseSynth].granShift1;
		~scLang.sendMsg(\control, \noiseSynthShift);
		["gran mix from 1 to 0.787 over 15 seconds"].postln.yield;

		~birds[\noiseSynth].granShift2;
		~scLang.sendMsg(\control, \noiseSynthShift);
		["gran mix ferom 0.787 to 0 over 30 seconds"].postln.yield;

		~birds[\noiseSynth].volShift;
		~scLang.sendMsg(\control, \noiseSynthShift);
		["volume from -20db to -12db over 4 seconds"].postln.yield;
	}
});

)


/*

~birds[\noiseSynth].granShift1;
~birds[\noiseSynth].granShift2;
~birds[\noiseSynth].volShift

s.meter

~birds[\noiseSynth].kill
Pdef(\phrase1).play;
Pdef(\phrase4).stop;
Pdef(\phrase3).stop;


~birdsSynth[\noiseSynth].gran.set(\mix, 1)
~birds[\noiseSynth].value
a = { Out.ar(~birdsBus[\noiseSynth].gran, Saw.ar(220)) }.play
a.free;
Pdef(\phrase1, Pdict(~birdsPatterns[\noiseSynth].phrase1,
	Prand([\one, \two, \three, \four, \five, \six, \seven, \eight, \nine, \ten], inf)));
~birdsSynth[\noiseSynth].gran.set(\mix, 0)
Pdef(\phrase1).stop;

*/








/*
~birdsBuf[\noiseSynthPath] = thisProcess.nowExecutingPath.dirname;

~birdsBuf[\noiseSynth] = [ ]



~birdsBuf[\noiseSynth] = Array.fill(53, { | i |
		Buffer.read(s,
			(~birdsBuf[\noiseSynthPath] ++ "/Noise Synth/" ++ (i + 32) ++ ".wav").postln; )
	});


a = Synth(\playBuf, [\amp, 0, \amp, 0.2, \sustain, 7, \bufName, ~birdsBuf[\noiseSynth].at(20), \loop, 1]);
b = Synth(\playBuf, [\amp, 0, \amp, 0.2, \sustain, 7, \bufName, ~birdsBuf[\noiseSynth].at(24), \loop, 1]);
c = Synth(\playBuf, [\amp, 0, \amp, 0.2, \sustain, 7, \bufName, ~birdsBuf[\noiseSynth].at(27), \loop, 1]);


(
var deg1, deg2, deg3, deg4, deg5, deg6, deg7, deg8;
deg1 = ~birdsBuf[\noiseSynth].at(66-32);
deg2 = ~birdsBuf[\noiseSynth].at(68-32);
deg3 = ~birdsBuf[\noiseSynth].at(69-32);
deg4 = ~birdsBuf[\noiseSynth].at(71-32);
deg5 = ~birdsBuf[\noiseSynth].at(73-32);
deg6 = ~birdsBuf[\noiseSynth].at(74-32);
deg7 = ~birdsBuf[\noiseSynth].at(76-32);
deg8 = ~birdsBuf[\noiseSynth].at(78-32);
Pbindef(\test3,
	\instrument, \playBuf,
	\note, Pseq([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, \r], inf),
	\bufName, Prand([deg1, deg2, deg3, deg4, deg5, deg6, deg7, deg8, deg7, deg6, deg5, deg4, deg3, deg2, deg1, deg1], inf),
	\legato, 2,
	\dur, 0.25
).play

Pbindef(\test2,
	\instrument, \default,
	\freq, 220).play


~midinotes =


Pbindef(\testPlayer,
	\instrument, \playBuf,
	\degree, Pseries(0, Prand(#[-2, -1, 1, 2], inf), inf).fold(-11, 11),
	\dur, Pwrand([0.25, Pn(0.125, 2)], #[0.8, 0.2], inf),
	\amp, 0.5,
	\freq, Pfunc { | ev | ev.use(ev[\freq]) },
	\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].indexInBetween(ev[\freq].cpsmidi) }).clip(0,
		~birdsBuf[\noiseSynth].size - 1.001)
	).play;

~birdsBuf[\noiseSynth]






~midinotes = [39, 46, 53, 60, 67, 74, 81, 88];

SynthDef(\multiSampler, { |out, bufnum, bufBase, baseFreqBuf, freq = 440, amp = 1|
� � var � �buf1 = bufnum.floor,
� � � � buf2 = buf1 + 1,
� � � � xfade = (bufnum - buf1).madd(2, -1),
� � � � basefreqs = Index.kr(baseFreqBuf, [buf1, buf2]),
� � � � playbufs = PlayBuf.ar(1, bufBase + [buf1, buf2], freq / basefreqs, loop: 0, doneAction: 2),
� � � � sig = XFade2.ar(playbufs[0], playbufs[1], xfade, amp);
� � Out.ar(out, sig ! 2)
}).add;

~baseBuf = Buffer.alloc(s, ~midinotes.size, 1, { |buf| buf.setnMsg(0,
	~midinotes.midicps) });
)

(
TempoClock.default.tempo = 1;
p = Pbind(
� � \instrument, \multiSampler,
� � \bufBase, ~birdsBuf[\noiseSynth].first,
� � \baseFreqBuf, ~baseBuf,
� � \degree, Pseries(0, Prand(#[-2, -1, 1, 2], inf), inf).fold(-11, 11),
� � \dur, 9,
� � \amp, Pexprand(0.1, 0.5, inf),
� � � � // some important conversions
� � � � // identify the buffer numbers to read
� � \freq, Pfunc { |ev| ev.use(ev[\freq]) },
� � \bufnum, Pfunc({ |ev| ~midinotes.indexInBetween(ev[\freq].cpsmidi) })
� � � � .clip(0, ~midinotes.size - 1.001)
).play;
)

p.stop;
b.do(_.free); ~baseBuf.free;

Synth(\playBuf, [\bufName, ~birdsBuf[\noiseSynth].at(4), \amp, 0.2])
Scale

// actually in the key of C!!!
{ SinOsc.ar(261.6255653006) }.play
Pbindef(\samplePlayer,
	\instrument, \playBuf,
	\scale, Pfunc({ ~birds[\mode]}, inf),
	\dur, Prand([0.5, 0.25, 0.75, 1], inf),
	\degree, Pseq([0, 1, 2, 3, 2, 1], inf),
	\octave, 2,
	\sustain, Pkey(\dur),
	\amp, 0.5,
	\freq, Pfunc { | ev | ev.use(ev[\freq]) },
	\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) }).poll
).play


// this one is the winner!!
Pbindef(\samplePlayer5,
	\instrument, \playBuf,
	\scale, Pfunc({ ~birds[\mode]}, inf),
	\dur, Pseq([1, 1, 0.5, 0.5, 1], inf),
	\degree, Pseq([0, 1, 2, 1, 0], inf),
	\octave, 4,
	\sustain, Pkey(\dur),
	\amp, 0.5,
	\freq, Pfunc { | ev | ev.use(ev[\freq]) },
	\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })
).play;


Patterns


Ppar
Ptpar

~phrase1 = Pseq([0, 1, 2, 3, 2, 1], 2);
~phrase2 = Prand([0, 1, 2, 3, 4, 5], 2);
~dur1 = 0.25;
~dur2 = 0.5;

Pbindef(\nester,
	\instrument, \default,
	\degree, Prand([~phrase1, ~phrase2], inf),
	\dur, 0.25);

Pbindef(\nester).play
Pbindef(\nest1,
	\instrument, \default,
	\degree, Pseq([0, 1, 2, 3, 2, 1], 7),
	\dur, 0.25);

Pbindef(\nest2,
	\instrument, \default,
	\degree, Prand([0, 1, 2, 3, 4, 5], 7),
	\dur, 0.25);



~dict = (
	\one: Pbind(
		\instrument, \default,
		\scale, Scale.aeolian,
		\legato, 1,
		\octave, 5,
		\dur, 4,
		\degree, Pseq([7, 2], 1)),

	\two: Pbind(
		\instrument, \default,
		\scale, Scale.aeolian,
		\legato, 1,
		\octave, 5,
		\dur, 4,
		\degree, Pseq([2, 1], 1)),

	\three: Pbind(
		\instrument, \default,
		\scale, Scale.aeolian,
		\legato, 1,
		\octave, 5,
		\dur, 4,
		\degree, Pseq([6, 4], 1)),

	\four: Pbind(
		\instrument, \default,
		\scale, Scale.aeolian,
		\legato, 1,
		\octave, 5,
		\dur, 4,
		\degree, Pseq([2, 1], 1)),

	\five: Pbind(
		\instrument, \default,
		\scale, Scale.aeolian,
		\legato, 1,
		\octave, 5,
		\dur, 6,
		\degree, Pseq([2, 1], 1)),

	\six: Pbind(
		\instrument, \default,
		\scale, Scale.aeolian,
		\legato, 1,
		\octave, 5,
		\dur, 4,
		\degree, Pseq([7, 2], 1)),

	\seven: Pbind(
		\instrument, \default,
		\scale, Scale.aeolian,
		\legato, 1,
		\octave, 5,
		\dur, 4,
		\degree, Pseq([6, 4], 1)),

	\eight: Pbind(
		\instrument, \default,
		\scale, Scale.aeolian,
		\legato, 1,
		\octave, 5,
		\dur, 4,
		\degree, Pseq([1], 1)),

	\nine: Pbind(
		\instrument, \default,
		\scale, Scale.aeolian,
		\legato, 1,
		\octave, 5,
		\dur, 4,
		\degree, Pseq([6, 6], 1)),

	\ten: Pbind(
		\instrument, \default,
		\scale, Scale.aeolian,
		\legato, 1,
		\octave, 5,
		\dur, 4/3,
		\degree, Pseq([7, 2], 1))
)

Pdef(\phrase1, Pdict(~dict, Prand([\one, \two, \three, \four, \five, \six, \seven, \eight, \nine, \ten], inf)));
Pdef(\phrase1).play;
Pdef(\phrase1).stop
*/




