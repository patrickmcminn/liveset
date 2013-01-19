/*
Tuesday, October 16th 2012
edited 12/12/2012
- reflects changes to control surface structure
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
			\buffer, ~impulse[\cathedral1], \mix, 0.5], ~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~connectBus[\inlet].gran, \out, ~connectBus[\inlet].fader,
				\grainDur, 0.2, \grainDurOffset, 0.1, \trigRate, 40
			],
			~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~connectBus[\inlet].fader, \out, ~mixer[\s2],
			\amp, 1], ~group[\fx], \addToTail)
	);
};


~connections[\inlet].addUniqueMethod(\kill, {
	~connectBus[\inlet].do({ | i | i.free });
	~connectSynth[\inlet].do({ | i | i.free });
});

~connectMake[\inlet] = r {
	loop {
		~connections[\inlet].value;
		~scLang.sendMsg(\control, \inlet);
		["inlet created"].postln.yield;

		~connections[\inlet].kill;
		~scLang.sendMsg(\control, \inlet);
		["inlet freed"].postln.yield;
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
