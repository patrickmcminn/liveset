/*
Wednesday, October 16th 2012
stabs.scd
prm
*/

~connections[\stabs] = {

	~connectBus[\stabs] = (
		\shelf: Bus.audio,
		\gran: Bus.audio,
		\verb: Bus.audio,
		\fader: Bus.audio
	);

	~connectSynth[\stabs] = (

		\hiShelf: Synth(\hiShelf, [\in, ~connectBus[\stabs].shelf, \out, ~connectBus[\stabs].gran,
			\freq, 2500, \gain, -6], ~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~connectBus[\stabs].gran, \out, ~connectBus[\stabs].verb,
				\bufLength, 3, \mix, 0.25, \sync, 0.85, \panOffset, 0, \grainDur, 0.2,
				\grainDurOffset, 0.1, \env, ~grainBufs[\gabor], \trigRate, 25
			],
			~group[\fx], \addToTail),

		\verb: Synth(\reverb2, [\in, ~connectBus[\stabs].verb, \out, ~connectBus[\stabs].fader,
			\room, 0.8, \mix, 0.6, \damp, 0.7], ~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~connectBus[\stabs].fader, \out, ~mixer[\s1], \amp, -16.dbamp],
			~group[\fx], \addToTail)
	);

	Pbindef(\stabs,
		\instrument, \holder,
		\bufName, Pseq([~connectBuf[\chordSum].at(0), ~connectBuf[\chordSum].at(1), ~connectBuf[\chordSum].at(2),
			~connectBuf[\chordSum].at(3)], inf),
		\out, ~connectBus[\stabs].shelf,
		\group, ~connectSynth[\stabs].hiShelf,
		\addAction, \addBefore,
		\attack, 0.005,
		\sustain, 0.25,
		\release, 0.45,
		\amp, 1,
		\dur, 4
	);
};

~connections[\stabs].addUniqueMethod(\kill, {
	~connectBus[\stabs].do({ | i | i.free });
	~connectSynth[\stabs].do({ | i | i.free });
	Pbindef(\stabs).stop;
	Pbindef(\stabs).clear;
});

~connections[\stabs].addUniqueMethod(\playStabs, {
	Pbindef(\stabs).play;
});

~connections[\stabs].addUniqueMethod(\stopStabs, {
	Pbindef(\stabs).stop;
});


~connectMake[\stabs] = r {
	loop {

		~connections[\stabs].value;
		~scLang.sendMsg(\control, \stabs);
		["stabs synths created"].postln.yield;


		~connections[\stabs].kill;
		~scLang.sendMsg(\control, \stabs);
		["stabs synths freed"].postln.yield;

	};
};

~connectMake[\stabsToggle] = r {
	loop {
		~connections[\transport].playNextBar({
			~connections[\stabs].playStabs;
			["stabs synths playing"].postln;
		}).yield;

		~connections[\transport].playNextBar({
			~connections[\stabs].stopStabs;
			["stabs synths stopped"].postln;
		}).yield;
	};
};





/*
~stabs = {
	~stabBus = (
		\shelf:		Bus.audio,
		\gran:		Bus.audio,
		\verb:		Bus.audio,
		\fader:		Bus.audio);
	~stab = (
		\hiShelf:		Synth(\hiShelf, [\in, ~stabBus.at(\shelf), \out, ~stabBus.at(\gran),
						\freq, 2500, \gain, -6], ~fx, \addToTail),
		\gran:		Synth(\granulator, [\in, ~stabBus.at(\gran), \out, ~stabBus.at(\verb),
						\bufLength, 3, \mix, 0.25, \sync, 0.85, \panOffset, 0, \grainDur, 0.2,
						\grainDurOffset, 0.1, \env, ~grainBufs.at(\gabor), \trigRate, 25],
						~fx, \addToTail),
		\verb:		Synth(\reverb2, [\in, ~stabBus.at(\verb), \out, ~stabBus.at(\fader),
						\room, 0.8, \mix, 0.6, \damp, 0.7], ~fx, \addToTail),
		\fader:		Synth(\stereoFader, [\in, ~stabBus.at(\fader), \out, ~outBusOne,
						\amp, 1], ~fx, \addToTail));
	Pbindef(\stabs,
		\instrument,		\holder,
		\bufName,			Pseq([~chordBufs.at(0), ~chordBufs.at(1), ~chordBufs.at(2),
							~chordBufs.at(3)], inf),
		\out,			~stabBus.at(\shelf),
		\group,			~stab.at(\hiShelf),
		\addAction,		\addBefore,
		\attack,			0.005,
		\sustain,			0.25,
		\release,			0.45,
		\dur,			4);
};

~stabsFree = { ~stabBus.do({ | i | i.free }); ~stab.do({ | i | i.free }); };
);
*/