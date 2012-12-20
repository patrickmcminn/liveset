/*
Wednesday, October 10th 2012
micVerb.scd
prm
*/


~connections[\micVerb] = {

	~connectBus[\micVerb] = (
		\rate: Bus.control,
		\inVerb: Bus.audio,
		\gran: Bus.audio,
		\verb: Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);

	~connectSynth[\micVerb] = (

		\rate: Synth(\demandRand7, [\out, ~connectBus[\micVerb].rate, \freq, 17, \d1, 0.5, \d2, 0.5,
			\d3, 0.5, \d4, 0.5, \d5, 1, \d6, 1, \d7, 1], ~group[\control], \addToTail),

		\inFader: Synth(\fader, [\in, ~inst[\mic], \out, ~connectBus[\micVerb].inVerb], ~group[\fx], \addToTail),

		\verb: Synth(\reverb1, [\in, ~connectBus[\micVerb].inVerb, \out, ~connectBus[\micVerb].gran,
			\room, 0.9, \damp, 0.2, \mix, 0.6, \amp, 1], ~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~connectBus[\micVerb].gran, \out, ~connectBus[\micVerb].verb,
				\mix, 0.2, \bufLength, 3, \pan, 0.15, \panOffset, 0.3,
				\env, ~grainBufs[\rexpodec], \rate, ~connectBus[\micVerb].at(\rate).asMap,
				\grainDur, 0.2, \grainDurOffset, 0.05, \trigRate, 35, \sync, 0.5
			],
			~group[\fx], \addToTail),

		\verb2: Synth(\convReverbStereo, [\in, ~connectBus[\micVerb].verb, \out, ~connectBus[\micVerb].fader,
			\buffer, ~impulse[\cathedral1], \mix, 0.5], ~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~connectBus[\micVerb].fader, \out, ~mixer[\s3], \amp, 1], ~group[\fx], \addToTail)
	);

};

~connections[\micVerb].addUniqueMethod(\kill, {
	~connectBus[\micVerb].do({ | i | i.free });
	~connectSynth[\micVerb].do({ | i | i.free });
});

~connectMake[\micVerb] = r {
	loop{
		~connections[\micVerb].value;
		~connectSynth[\micVerb].gran.set(\rate, ~connectBus[\micVerb].at(\rate).asMap);
		~scLang.sendMsg(\control, \micVerb);
		"Mic Verb Active".postln.yield;


		~connections[\micVerb].kill;
		~scLang.sendMsg(\control, \micVerb);
		"Mic Verb Freed".postln.yield;

	};
};

~connectMake[\micVerbToggle] = r { | val |
	loop{
		~connectSynth[\micVerb].inFader.set(\mute, 0);
		~scLang.sendMsg(\control, \micVerbToggle);
		["input for mic verb muted"].postln.yield;


		~connectSynth[\micVerb].inFader.set(\mute, 1);
		~scLang.sendMsg(\control, \micVerbToggle);
		["input for mic verb active"].postln.yield;

	};
};


/*
(
~micEnd = {
	~micEndBus = (
		\rate:	Bus.control,
		\inVerb:	Bus.audio,
		\gran:	Bus.audio,
		\verb:	Bus.audio,
		\fader:	Bus.audio);
	~mics = (
		\rate:	Synth(\demandRand7, [\out, ~micEndBus.at(\rate), \freq, \17, \d1, 0.5, \d2, 0.5,
					\d3, 0.5, \d4, 0.5, \d5, 1, \d6, 1, \d7, 1], ~controlGroup, \addToTail),
		\inFader:	Synth(\fader, [\in, ~micBus, \out, ~micEndBus.at(\inVerb)], ~fx, \addToTail),
		\verb1:	Synth(\reverb1, [\in, ~micEndBus.at(\inVerb), \out, ~micEndBus.at(\gran),
					\room, 0.9, \damp, 0.2, \mix, 0.6, \amp, 0.8], ~fx, \addToTail),
		\gran:	Synth(\granulator, [\in, ~micEndBus.at(\gran), \out, ~micEndBus.at(\verb),
					\mix, 0.2, \bufLength, 3, \pan, 0.15, \panOffset, 0.3,
					\env, ~grainBufs.at(\rexpodec), \rate, ~micEndBus.at(\rate).asMap,
					\grainDur, 0.2, \grainDurOffset, 0.05, \trigRate, 35, \sync, 0.5],
					~fx, \addToTail),
		\verb2:	Synth(\convReverbStereo, [\in, ~micEndBus.at(\verb), \out, ~micEndBus.at(\fader),
					\buffer, ~cathedralTwo, \mix, 0.3], ~fx, \addToTail),
		\fader:	Synth(\stereoFader, [\in, ~micEndBus.at(\fader), \out, ~outBusThree],
					~fx, \addToTail));
};

~micEndFree = { ~micEndBus.do({ | i | i.free }); ~mics.do({ | i | i.free }); };
);
*/