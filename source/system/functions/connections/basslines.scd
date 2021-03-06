/*
Tuesday, October 16th 2012
Somewhere in New Mexico, traveling from Palo Duro Canyon, TX to Santa Fe NM
edited 12/12/2012
- reflects control surface structure change
basslines.scd
prm
*/

~connections[\basslines] = {
	var noteCount = Pseq([8, 6, 16, 9, 4], inf);
	~connectBus[\basslines] = (
		\bassline: Bus.audio,
		\gran: Bus.audio,
		\fader: Bus.audio(s, 2)
	);
	~connectSynth[\basslines] = (

		\loShelf: Synth(\lowShelf, [\in, ~connectBus[\basslines].bassline, \out, ~connectBus[\basslines].bassline,
			\freq, 300, \gain, 15], ~group[\fx], \addToTail),

		\hiShelf: Synth(\hiShelf, [\in, ~connectBus[\basslines].bassline, \out, ~connectBus[\basslines].bassline,
			\freq, 1770, \gain, -10], ~group[\fx], \addToTail),

		\verb: Synth(\reverb1, [\in, ~connectBus[\basslines].bassline, \out, ~connectBus[\basslines].gran,
			\mix, 0.8, \room, 0.8, \damp, 0.45], ~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~connectBus[\basslines].gran, \out, ~connectBus[\basslines].fader,
				\mix, 0, \bufLength, 8, \panOffset, 0, \grainDur, 0.3,
				\grainDurOffset, 0.1, \env, -1, \trigRate, 40
			],
			~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~connectBus[\basslines].fader, \out, ~mixer[\s2], \amp, 2.dbamp],
			~group[\fx], \addToTail)
	);

	Pbindef(\basslineOne,
		\instrument, \playBuf,
		\out, ~connectBus[\basslines].bassline,
		\bufName, Pseq([~connectBuf[\note].at(0), ~connectBuf[\note].at(4), ~connectBuf[\note].at(2),
			~connectBuf[\note].at(3), ~connectBuf[\note].at(1)], inf),
		\rate, 0.25,
		\attack, Pseq([0.05, 0.05, 0.05, 0.05, 0.05], inf),
		\sustain, Pseq([7.9, 7.9, 7.9, 3.9, 3.9], inf) * (1/~connections[\transport].tempo),
		\release, Pseq([0.05, 0.05, 0.05, 0.05, 0.05], inf),
		\startPos, s.sampleRate*0.1,
		\group, ~connectSynth[\basslines].loShelf,
		\addAction, \addBefore,
		\dur, Pseq([8, 8, 8, 4, 4], inf),
		\legato, 1,
		\amp, 0.3
	).quant_(1);

	Pbindef(\basslineTwo,
		\instrument, \playBuf,
		\out, ~connectBus[\basslines].bassline,
		\bufName, Pstutter(
			Pseq([8, 6, 16, 9, 4], inf),
			Pseq([~connectBuf[\note].at(2), ~connectBuf[\note].at(3), ~connectBuf[\note].at(0),
				~connectBuf[\note].at(1), ~connectBuf[\note].at(4)], inf)),
		\group, ~connectSynth[\basslines].loShelf,
		\addAction, \addBefore,
		\rate, 0.5,
		\amp, 0.2,
		\dur, Pstutter(
			noteCount,
			Pseq([0.5, 2/3, 0.25, 1/3, 0.25], inf)),
		\attack, Pstutter(
			noteCount,
			Pseq([0.05, 1/30, 0.025, 1/30, 0.025], inf)),
		\sustain, Pstutter(
			noteCount,
			Pseq([0.4, 0.59, 0.2, 0.27, 0.2], inf)) * (1/~connections[\transport].tempo),
		\release, Pstutter(
			noteCount,
			Pseq([0.05, 1/30, 0.025, 1/30, 0.025], inf)),
		\startPos, s.sampleRate * 0.1,
		\legato, 1
	);
};

~connections[\basslines].addUniqueMethod(\kill, {

	~connectBus[\basslines].do({ | i | i.free; });
	~connectSynth[\basslines].do({ | i | i.free; });

	Pbindef(\basslineOne).stop;
	Pbindef(\basslineTwo).stop;

	Pbindef(\basslineOne).clear;
	Pbindef(\basslineTwo).clear;
});



~connectMake[\basslines] = r {
	loop {
		~connections[\basslines].value;
		~scLang.sendMsg(\control, \basslines);
		["bassline routing created"].postln.yield;

		~connections[\basslines].kill;
		~scLang.sendMsg(\control, \basslines);
		["bassline routing freed"].postln.yield;
	};
};


~connectMake[\basslineOne] = r { | val |
	loop{
		~connections[\transport].playNextBar({
			Pbindef(\basslineOne).play(~connections[\transport]); });
		~scLang.sendMsg(\control, \basslineOne);
		["Bassline One Playing"].postln.yield;

		Pbindef(\basslineOne).stop;
		~scLang.sendMsg(\control, \basslineOne);
		["Bassline One Stopped"].postln.yield;
	};
};

~connectMake[\basslineTwo] = r { | val |
	loop {
		~connections[\transport].playNextBar({
			Pbindef(\basslineTwo).play(~connections[\transport]);});
		~scLang.sendMsg(\control, \basslineTwo);
		["Bassline Two Playing"].postln.yield;

		Pbindef(\basslineTwo).stop;
		~scLang.sendMsg(\control, \basslineTwo);
		["Bassline Two Stopped"].postln.yield;
	};
};






/*

(
~bassline = {
	var noteCount = Pseq([8, 6, 16, 9, 4], inf);
	~basslineBus = (
		\bL:		Bus.audio,
		\gran:	Bus.audio,
		\fader:	Bus.audio);
	~bL = (
		\loShelf:		Synth(\lowShelf, [\in, ~basslineBus.at(\bL), \out, ~basslineBus.at(\bL),
						\freq, 300, \gain, 15], ~fx, \addToTail),
		\hiShelf:		Synth(\hiShelf, [\in, ~basslineBus.at(\bL), \out, ~basslineBus.at(\bL), 						\freq, 1770, \gain, -10], ~fx, \addToTail),
		\verb:		Synth(\reverb1, [\in, ~basslineBus.at(\bL), \out, ~basslineBus.at(\gran),
						\mix, 0.5, \room, 0.8, \damp, 0.45], ~fx, \addToTail),
		\gran:		Synth(\granulator, [
						\in, ~basslineBus.at(\gran), \out, ~basslineBus.at(\fader),
						\mix, 0, \bufLength, 8, \panOffset, 0, \grainDur, 0.3,
						\grainDurOffset, 0.1,\env, -1, \trigRate, 40], ~fx, \addToTail),
		\fader:		Synth(\stereoFader, [\in, ~basslineBus.at(\fader), \out, ~outBusTwo,
						\amp, 7],~fx, \addToTail));
	Pbindef(\basslineOne,
		\instrument, 		\playBuf,
		\out,			~basslineBus.at(\bL),
		\bufName,			Pseq([~noteBuffers.at(0), ~noteBuffers.at(4), ~noteBuffers.at(2),
							~noteBuffers.at(3), ~noteBuffers.at(1)], inf),
		\rate,			0.25,
		\attack,			Pseq([0.01, 0.01, 0.01, 0.01, 0.01], inf),
		\sustain,			Pseq([6.2, 6.2, 6.2, 3.1, 3.1], inf),
		\release,			Pseq([0.01, 0.01, 0.01, 0.01, 0.01], inf),
		\startPos,		s.sampleRate*0.1,
		\group,			~bL.at(\loShelf),
		\addAction,		\addBefore,
		\dur, 			Pseq([8, 8, 8, 4, 4], inf)).quant_(1);

	Pbindef(\basslineTwo,
		\instrument,		\playBuf,
		\out,			~basslineBus.at(\bL),
		\bufName,			Pstutter(
							Pseq([8, 6, 16, 9, 4], inf),
							Pseq([~noteBuffers.at(2), ~noteBuffers.at(3), ~noteBuffers.at(0), 								~noteBuffers.at(1), ~noteBuffers.at(4)], inf)),
		\group,			~bL.at(\loShelf),
		\addAction,		\addBefore,
		\rate,			0.5,
		\amp, 			0.2,
		\dur, 			Pstutter(
							noteCount,
							Pseq([0.5, 2/3, 0.25, 1/3, 0.25], inf)),
		\attack,			Pstutter(
							noteCount,
							Pseq([0.05, 1/30, 0.025, 1/30, 0.025], inf)),
		\sustain,			Pstutter(
							noteCount,
							Pseq([0.3, 7/15, 0.15, 6/30, 0.15], inf)),
		\release,			Pstutter(
							noteCount,
							Pseq([0.05, 1/30, 0.025, 1/30, 0.025], inf)),
		\startPos, 		s.sampleRate*0.1);
};

~basslineFree = {~basslineBus.do({ | i | i.free; }); ~bL.do({ | i | i.free }); };
);

*/