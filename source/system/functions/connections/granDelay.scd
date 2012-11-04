/*
Wednesday, October 10th 2012
granDelay.scd
prm
*/

~connections[\granDelay] = {
	~connectBus[\granDelay] = (
		\shelf: Bus.audio,
		\gran: Bus.audio,
		\del: Bus.audio(s, 2),
		\verb: Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);
	~connectSynth[\granDelay] = (

		\inFader: Synth(\fader, [\in, ~inst[\mute], \out, ~connectBus[\granDelay].shelf], ~group[\fx], \addToTail),

		\hiShelf: Synth(\hiShelf, [\in, ~connectBus[\granDelay].shelf, \out, ~connectBus[\granDelay].gran,
			\freq, 2500, \gain, -6], ~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~connectBus[\granDelay].gran, \out, ~connectBus[\granDelay].del,
				\bufLength, 1, \panOffset, 0, \grainDur, 0.05,
				\grainDurOffset, 0.01, \trigRate, 70, \amp, 1.5, \posOffset, 0.1
			],
			~group[\fx], \addToTail),

		\del: Synth(\delayStereo, [\in, ~connectBus[\granDelay].del, \out, ~connectBus[\granDelay].verb,
			\delayTime, 0.8, \decayTime, 7], ~group[\fx], \addToTail),

		\verb: Synth(\reverb2, [\in, ~connectBus[\granDelay].verb, \out, ~connectBus[\granDelay].fader, \mix, 0.55,
			\room, 0.75, \damp, 0.3], ~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~connectBus[\granDelay].fader, \out, ~mixer[\s2], \amp, 0.6],
			~group[\fx], \addToTail)
	);
};

~connections[\granDelay].addUniqueMethod(\kill, {
	~connectBus[\granDelay].do({ | i | i.free });
	~connectSynth[\granDelay].do({ | i | i.free });
});

~connectMake[\granDelay] = r { | main |
	var val, toggle, hiShelf, decay;
	val = main.at(0);
	toggle = main.at(1);
	hiShelf = main.at(2);
	decay = main.at(3);
	loop{

		~connections[\granDelay].value;
		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\granDelayToggle, { ~scLang.sendMsg(\granDelay, \toggle, toggle)}, toggle);
		MIDIdef.cc(\granDelayHiShelf, { | gain | ~scLang.sendMsg(\granDelay, \hiShelf, gain)}, hiShelf);
		MIDIdef.cc(\granDelayDecay, { | decay | ~scLang.sendMsg(\granDelay, \decay, decay)}, decay);
		"GranDelay Active".postln;
		~ohm.turnBlue(val).yield;

		MIDIdef(\granDelayToggle).free;
		MIDIdef(\granDelayHiShelf).free;
		MIDIdef(\granDelayDecay).free;
		~ohm.turnOff(toggle);
		~connections[\granDelay].kill;
		"GranDelay Freed".postln;
		~ohm.turnRed(val).yield;
	};
};

~connectMake[\granDelayToggle] = r { | val |
	loop {
		~connectSynth[\granDelay].inFader.set(\mute, 0);
		["input to gran delay muted"].postln;
		~ohm.turnRed(val).yield;

		~connectSynth[\granDelay].inFader.set(\mute, 1);
		["input to gran delay active"].postln;
		~ohm.turnBlue(val).yield;
	};
};

/*
(
~liveFeed = {
	~liveFeedBus = (
		\shelf:	Bus.audio,
		\gran:	Bus.audio,
		\del:	Bus.audio(s, 2),
		\verb:	Bus.audio(s, 2),
		\fader:	Bus.audio(s, 2));
	~lF = (
		\inFader:		Synth(\fader, [\in, ~muteBus, \out, ~liveFeedBus.at(\shelf)],
						~fx, \addToTail),
		\hiShelf:		Synth(\hiShelf, [\in, ~liveFeedBus.at(\shelf), \out, ~liveFeedBus.at(\gran),
						\freq, 2500, \gain, -6], ~fx, \addToTail),
		\gran:		Synth(\granulator, [\in, ~liveFeedBus.at(\gran),
						\out, ~liveFeedBus.at(\del),
						\bufLength, 1, \panOffset, 0, \grainDur, 0.05,
						\grainDurOffset, 0.01, \trigRate, 70, \amp, 1.5, \posOffset, 0.1],
						~fx, \addToTail),
		\del:		Synth(\delayStereo, [\in, ~liveFeedBus.at(\del),
						\out, ~liveFeedBus.at(\verb), \delayTime, 0.8, \decayTime, 7],
						~fx, \addToTail),
		\verb:		Synth(\reverb2, [\in, ~liveFeedBus.at(\verb), \out, ~liveFeedBus.at(\fader),
						\mix, 0.55, \room, 0.75, \damp, 0.3], ~fx, \addToTail),
		\fader:		Synth(\stereoFader, [\in, ~liveFeedBus.at(\fader), \out, ~outBusOne,
						\amp, 0.6], ~fx, \addToTail));
};

~liveFeedFree = { ~liveFeedBus.do({ | i | i.free }); ~lF.do({ | i | i.free }); };
);
*/