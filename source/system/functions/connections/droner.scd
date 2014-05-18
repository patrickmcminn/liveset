/*
Wednesday, October 12th 2012
droner.scd
prm
*/


~connections[\droner] = {
	~connectBus[\droner] = (
		\rate:    Bus.control,
		\drone:   Bus.audio,
		\verb:    Bus.audio(s, 2),
		\filter:  Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);

	~connectSynth[\droner] = (

		\rate:    Synth(\demandRand7, [\out, ~connectBus[\droner].rate, \freq, 12, \d1, 0.5, \d2, 0.5, \d3, 0.5,
			\d4, 0.5, \d5, 0.5, \d6, 0.25, \d7, 0.25],
			~group[\control], \addToTail),

		\inFader: Synth(\fader, [\in, ~inst[\mute], \out, ~connectBus[\droner].drone], ~group[\fx], \addToTail),

		\del:     Synth(\droneDelay, [\in, ~connectBus[\droner].drone, \out, ~connectBus[\droner].drone,
			\delayTime, 1.1305, \decayTime, 200, \mix, 1], ~group[\fx], \addToTail),

		\erosion: Synth(\erosion, [\in, ~connectBus[\droner].drone, \out, ~connectBus[\droner].drone, \freq, 500,
			\rangeLo, 0.002, \rangeHi, 0.009, \mix, 0.02], ~group[\fx], \addToTail),

		\gran:    Synth(\granulator,
			[
				\mix, 0, \in, ~connectBus[\droner].drone,
				\out, ~connectBus[\droner].verb,
				\bufLength, 5, \panOffset, 0.03, \grainDur, 0.13, \grainDurOffset, 0.1,
				\rate, ~connectBus[\droner].at(\rate).asMap, \env, ~grainBufs[\gabor], \trigRate, 15, \amp, 3
		], ~group[\fx], \addToTail),

		\verb:    Synth(\reverb2, [\in, ~connectBus[\droner].verb, \out, ~connectBus[\droner].filter,
			\mix, 0.75, \room, 1, \damp, 0.9], ~group[\fx], \addToTail),

    \hiShelf: Synth(\hiShelfStereo, [\in, ~connectBus[\droner].filter, \out, ~connectBus[\droner].filter, \freq, 2637,
			\gain, -3], ~group[\fx], \addToTail),

		\loShelf: Synth(\lowShelfStereo, [\in, ~connectBus[\droner].filter, \out, ~connectBus[\droner].fader,
			\freq, 250, \gain, 0], ~group[\fx], \addToTail),

		\fader:   Synth(\stereoFader, [\in, ~connectBus[\droner].fader, \out, ~mixer[\s1], \amp, -6.dbamp],
			~group[\fx], \addToTail)
	);


};

~connections[\droner].addUniqueMethod(\kill, {
	~connectBus[\droner].do({ | i | i.free; });
	~connectSynth[\droner].do({ | i | i.free; });
});

~connectMake[\droner] = r {
	loop {

		~connections[\droner].value;
		~connectSynth[\droner].at(\rate).set(\out, ~connectBus[\droner].at(\rate));
		~scLang.sendMsg(\control, \droner);
		["Droner Active"].postln.yield;


		~connections[\droner].kill;
		~connectMake[\dronerToggle].reset;
		~scLang.sendMsg(\control, \droner);
		["Droner Freed"].postln.yield;
	};


};

~connectMake[\dronerToggle] = r { | val |
	loop {
		~connectSynth[\droner].inFader.set(\mute, 0);
		~scLang.sendMsg(\control, \dronerToggle);
		["droner input muted"].postln.yield;


		~connectSynth[\droner].inFader.set(\mute, 1);
		~scLang.sendMsg(\control, \dronerToggle);
		["droner input active"].postln.yield;
	};
};

~connectMake[\dronerRater] = r { | val |
	loop {
		~connectSynth[\droner].at(\rate).set(\d1, 1, \d2, 1);
		~scLang.sendMsg(\control, \dronerRater);
		["droner rates of 1 added"].postln.yield;

		~connectSynth[\droner].at(\gran).set(\rate, 0.5);
		~scLang.sendMsg(\control, \dronerRater);
		["droner rates to 0.5"].postln.yield;


		~connectSynth[\droner].at(\rate).set(\d1, 0.5, \d2, 0.5, \d3, 0.5, \d4, 0.5, \d5, 0.5, \d6, 0.25, \d7, 0.25);
		~connectSynth[\droner].at(\gran).set(\rate, ~connectBus[\droner].at(\rate).asMap);
		~scLang.sendMsg(\control, \dronerRater);
		["droner rates reset"].postln.yield;
	}
};





/*
(
droner = {
	~droneBus = (
		\drone:		Bus.audio,
		\verb:		Bus.audio(s, 2),
		\filter:		Bus.audio(s, 2),
		\rate:		Bus.control);
	~drone = (
		\rate:		Synth(\demandRand7, [\out, ~droneBus.at(\rate), \freq, 12, \d1, 0.5,
						\d2, 0.5, \d3, 0.5, \d4, 0.5, \d5, 0.5, \d6, 0.25, \d7, 0.25],
						~controlGroup, \addToTail),
		\inFader:		Synth(\fader, [\in, ~muteBus, \out, ~droneBus.at(\drone)], ~fx, \addToTail),
		\hiShelf:		Synth(\hiShelf, [\in, ~droneBus.at(\drone), \out, ~droneBus.at(\drone), 						\freq, 2637, \gain, -3], ~fx, \addToTail),
		\del:		Synth(\droneDelay, [\in, ~droneBus.at(\drone), \out, ~droneBus.at(\drone),
						\delayTime, 1.1305, \decayTime, 200, \mix, 1], ~fx, \addToTail),
		\erosion:		Synth(\erosion, [\in, ~droneBus.at(\drone), \out, ~droneBus.at(\drone), 						\freq, 500, \rangeLo, 0.002,\rangeHi, 0.009, \mix, 0.02],
						~fx, \addToTail),
		\gran:		Synth(\granulator, [
						\mix,			0,
						\in, 			~droneBus.at(\drone),
						\out,			~droneBus.at(\verb),
						\bufLength,		5,
						\panOffset,		0.03,
						\grainDur, 		0.13,
						\grainDurOffset,	0.1,
						\rate,			~droneBus.at(\rate).asMap,
						\env,			~grainBufs.at(\gabor),
						\trigRate,		15,
						\amp,			3],
						~fx, \addToTail),
		\verb:		Synth(\convReverbStereo, [\in, ~droneBus.at(\verb), \out,
						~droneBus.at(\filter), \buffer, ~cathedralOne, \mix, 0.6,
							\inputScale, 0.5], ~fx, \addToTail),
		\loShelf:		Synth(\lowShelfStereo, [\in, ~droneBus.at(\filter),
						\out, ~droneBus.at(\filter), \freq, 250, \gain, -6], ~fx, \addToTail),
		\fader:		Synth(\stereoFader, [\in, ~droneBus.at(\filter), \out, ~outBusOne,
						\amp, 0.6],~fx, \addToTail));
};
~dronerFree = { ~droneBus.do({ | i | i.free }); ~drone.do({ | i | i.free }); };
);

*/

