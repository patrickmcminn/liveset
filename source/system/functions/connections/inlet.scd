/*
Tuesday, October 16th 2012
inlet.scd
prm
*/

~connections[\inlet] = {
	~connectBus[\inlet] = (
		\verb: Bus.audio(s, 2),
		\gran: Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);
	~connectSynth[\inlet] = (
		\verb: Synth(\convReverbStereo, [\in, ~connectBus[\inlet].verb, \out, ~connectBus[\inlet].gran,
			\buffer, ~impulse[\cathedral1], \mix, 0.77], ~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~connectBus[\inlet].gran, \out, ~connectBus[\inlet].fader,
				\grainDur, 0.2, \grainDurOffset, 0.1, \trigRate, 40
			],
			~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~connectBus[\inlet].fader, \out, ~mixer[\s2],
			\amp, 1.2], ~group[\fx], \addToTail)
	);
};


~connections[\inlet].addUniqueMethod(\kill, {
	~connectBus[\inlet].do({ | i | i.free });
	~connectSynth[\inlet].do({ | i | i.free });
});

~connectMake[\inlet] = r { | main |
	var val, mix;
	val = main.at(0);
	mix = main.at(1);
	loop {
		~connections[\inlet].value;
		MIDIdef.cc(\inletGran, { | mix | ~scLang.sendMsg(\inlet, \gran, mix); }, mix);
		["inlet created"].postln;
		~ohm.turnPurple(val).yield;

		MIDIdef(\inletGran).free;
		~connections[\inlet].kill;
		["inlet feed"].postln;
		~ohm.turnRed(val).yield;
	};
};

/*
(
~inlet = {
	~inletBus = (
		\verb:	Bus.audio(s, 2),
		\gran:	Bus.audio(s, 2),
		\fader:	Bus.audio(s, 2));
	~inlets = (
		\verb:	Synth(\convReverbStereo, [\in, ~inletBus.at(\verb), \out, ~inletBus.at(\gran),
					\buffer, ~cathedralOne, \mix, 0.77], ~fx, \addToTail),
		\gran:	Synth(\granulator, [\in, ~inletBus.at(\gran), \out, ~inletBus.at(\fader), 					\bufLength, 5,\grainDur, 0.2, \grainDurOffset, 0.1, \trigRate, 40],
					~fx, \addToTail),
		\fader:	Synth(\stereoFader, [\in, ~inletBus.at(\fader), \out, ~outBusTwo,
					\amp, 1.2], ~fx, \addToTail));
};
~inletFree = { ~inletBus.do({ | i | i.free }); ~inlets.do({ | i | i.free }); };
);
*/
