/*
Tuesday, October 16th 2012
cascades.scd
prm
*/

~connections[\cascade] = {

	var env, attack, sustain, release;

	env = Env(#[0, 0.4, 0, 0], #[6.4, 6.4, 12.8], 4);
	attack = 0.025;
	sustain = 0.2;
	release = 0.025;

	~connectBus[\cascade] = Bus.audio;

	~connectSynth[\cascade] = (
		\shelf: Synth(\hiShelf, [\in, ~connectBus[\cascade], \out, ~connectBus[\cascade],
			\freq, 2500, \gain, -7], ~connectSynth[\inlet].verb, \addBefore),
		\pan: Synth(\pan, [\in, ~connectBus[\cascade], \out, ~connectBus[\inlet].verb,
			\pan, -0.35], ~connectSynth[\inlet].verb, \addBefore)
	);

	Pbindef(\highCSharp,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\note].at(0),
		\out, ~connectBus[\cascade],
		\group, ~connectSynth[\cascade].shelf,
		\addAction, \addBefore,
		\dur, 0.25,
		\amp, Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\startPos, s.sampleRate * 0.1);

	Pbindef(\gSharp,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\note].at(1),
		\out, ~connectBus[\cascade],
		\group, ~connectSynth[\cascade].shelf,
		\addAction, \addBefore,
		\dur, 0.25,
		\amp, Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\startPos, s.sampleRate * 0.1);

	Pbindef(\lowFSharp,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\note].at(2),
		\out, ~connectBus[\cascade],
		\group, ~connectSynth[\cascade].shelf,
		\addAction, \addBefore,
		\dur, 0.25,
		\amp, Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\startPos, s.sampleRate * 0.1);

	Pbindef(\b,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\note].at(4),
		\out, ~connectBus[\cascade],
		\group, ~connectSynth[\cascade].shelf,
		\addAction, \addBefore,
		\dur, 0.25,
		\amp, Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\startPos, s.sampleRate * 0.1);

	Pbindef(\highE,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\cascade].at(0),
		\out, ~connectBus[\cascade],
		\group, ~connectSynth[\cascade].shelf,
		\addAction, \addBefore,
		\dur, 0.25,
		\amp, Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\startPos, s.sampleRate * 0.1);

	Pbindef(\a,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\note].at(3),
		\out, ~connectBus[\cascade],
		\group, ~connectSynth[\cascade].shelf,
		\addAction, \addBefore,
		\dur, 0.25,
		\amp, Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\startPos, s.sampleRate * 0.1);

	Pbindef(\lowCSharp,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\cascade].at(1),
		\out, ~connectBus[\cascade],
		\group, ~connectSynth[\cascade].shelf,
		\addAction, \addBefore,
		\dur, 0.25,
		\amp, Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\startPos, s.sampleRate * 0.1);

	Pbindef(\highFSharp,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\cascade].at(2),
		\out, ~connectBus[\cascade],
		\group, ~connectSynth[\cascade].shelf,
		\addAction, \addBefore,
		\dur, 0.25,
		\amp, Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack, attack,
		\sustain, sustain,
		\release, release,
		\startPos, s.sampleRate * 0.1);

};
~connections[\cascade].addUniqueMethod(\kill, {
	~connectBus[\cascade].free;
	~connectSynth[\cascade].do({ | i | i.free; });

	Pbindef(\highCSharp).stop;
	Pbindef(\gSharp).stop;
	Pbindef(\lowFSharp).stop;
	Pbindef(\b).stop;
	Pbindef(\highE).stop;
	Pbindef(\a).stop;
	Pbindef(\lowCSharp).stop;
	Pbindef(\highFSharp).stop;

	Pbindef(\highCSharp).clear;
	Pbindef(\gSharp).clear;
	Pbindef(\lowFSharp).clear;
	Pbindef(\b).clear;
	Pbindef(\highE).clear;
	Pbindef(\a).clear;
	Pbindef(\lowCSharp).clear;
	Pbindef(\highFSharp).clear;
});

~connections[\cascade].addUniqueMethod(\playCascade, {
	~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid, {Pbindef(\highCSharp).play});
	~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid + 4, {Pbindef(\gSharp).play});
	~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid + 8, {Pbindef(\lowFSharp).play});
	~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid + 12, {Pbindef(\b).play});
	~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid + 16, {Pbindef(\highE).play});
	~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid + 20, {Pbindef(\a).play});
	~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid + 24, {Pbindef(\lowCSharp).play});
	~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid + 28, {Pbindef(\highFSharp).play});
});

~connections[\cascade].addUniqueMethod(\stopCascade, {
	Pbindef(\highCSharp).stop;
	Pbindef(\gSharp).stop;
	Pbindef(\lowFSharp).stop;
	Pbindef(\b).stop;
	Pbindef(\highE).stop;
	Pbindef(\a).stop;
	Pbindef(\lowCSharp).stop;
	Pbindef(\highFSharp).stop;
});

~connectMake[\cascade] = r { | main |
	var val, toggle, vol;
	val = main.at(0);
	toggle = main.at(1);
	vol = main.at(2);
	loop {
		~connections[\cascade].value;
		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\cascadeToggle, { ~scLang.sendMsg(\cascade, \toggle, toggle)}, toggle);
		MIDIdef.cc(\cascadeVolume, { | amp | ~scLang.sendMsg(\cascade, \volume, amp)}, vol);
		["cascade synths created"].postln;
		~ohm.turnLavender(val).yield;

		~connections[\cascade].kill;
		MIDIdef(\cascadeVolume).free;
		MIDIdef(\cascadeToggle).free;
		~ohm.turnOff(toggle);
		["cascade synths freed"].postln;
		~ohm.turnRed(val).yield;
	};
};

~connectMake[\cascadeToggle] = r { | val |
	loop {
		~connections[\cascade].playCascade;
		["cascade synths playing"].postln;
		~ohm.turnPink(val).yield;

		~connections[\cascade].stopCascade;
		["cascade synths stopped"].postln;
		~ohm.turnRed(val).yield;
	};
};


/*
~cascades = {
	var env, attack, sustain, release;

	env = Env(#[0, 0.4, 0, 0], #[6.4, 6.4, 12.8], 4);
	attack = 0.025;
	sustain = 0.2;
	release = 0.025;
	~cascadeBus = Bus.audio;
	~cascade = (
		\shelf:		Synth(\hiShelf, [\in, ~cascadeBus, \out, ~cascadeBus, \freq, 2500,
						\gain, -7], ~inlets.at(\verb), \addBefore),
		\pan:		Synth(\pan, [\in, ~cascadeBus, \out, ~inletBus.at(\verb), \pan, -0.35],
						~inlets.at(\verb), \addBefore));
	Pbindef(\highCSharp,
		\instrument,		\playBuf,
		\bufName,			~noteBuffers.at(0),
		\out, 			~cascadeBus,
		\group,			~cascade.at(\shelf),
		\addAction,		\addBefore,
		\dur, 			0.25,
		\amp,			Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack,			attack,
		\sustain,			sustain,
		\release,			release,
		\startPos,		s.sampleRate * 0.1);

	Pbindef(\gSharp,
		\instrument,		\playBuf,
		\bufName,			~noteBuffers.at(1),
		\out, 			~cascadeBus,
		\group,			~cascade.at(\shelf),
		\addAction,		\addBefore,
		\dur, 			0.25,
		\amp,			Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack,			attack,
		\sustain,			sustain,
		\release,			release,
		\startPos,		s.sampleRate * 0.1);

	Pbindef(\lowFSharp,
		\instrument,		\playBuf,
		\bufName,			~noteBuffers.at(2),
		\out, 			~cascadeBus,
		\group,			~cascade.at(\shelf),
		\addAction,		\addBefore,
		\dur, 			0.25,
		\amp,			Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack,			attack,
		\sustain,			sustain,
		\release,			release,
		\startPos,		s.sampleRate * 0.1);

	Pbindef(\b,
		\instrument,		\playBuf,
		\bufName,			~noteBuffers.at(4),
		\out, 			~cascadeBus,
		\group,			~cascade.at(\shelf),
		\addAction,		\addBefore,
		\dur, 			0.25,
		\amp,			Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack,			attack,
		\sustain,			sustain,
		\release,			release,
		\startPos,		s.sampleRate * 0.1);

	Pbindef(\highE,
		\instrument,		\playBuf,
		\bufName,			~cascadeBuffers.at(0),
		\out, 			~cascadeBus,
		\group,			~cascade.at(\shelf),
		\addAction,		\addBefore,
		\dur, 			0.25,
		\amp,			Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack,			attack,
		\sustain,			sustain,
		\release,			release,
		\startPos,		s.sampleRate * 0.05);

	Pbindef(\a,
		\instrument,		\playBuf,
		\bufName,			~noteBuffers.at(3),
		\out, 			~cascadeBus,
		\group,			~cascade.at(\shelf),
		\addAction,		\addBefore,
		\dur, 			0.25,
		\amp,			Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack,			attack,
		\sustain,			sustain,
		\release,			release,
		\startPos,		s.sampleRate * 0.1);

	Pbindef(\lowCSharp,
		\instrument,		\playBuf,
		\bufName,			~cascadeBuffers.at(1),
		\out, 			~cascadeBus,
		\group,			~cascade.at(\shelf),
		\addAction,		\addBefore,
		\dur, 			0.25,
		\amp,			Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack,			attack,
		\sustain,			sustain,
		\release,			release,
		\startPos,		s.sampleRate * 0.05);

	Pbindef(\highFSharp,
		\instrument,		\playBuf,
		\bufName,			~cascadeBuffers.at(2),
		\out, 			~cascadeBus,
		\group,			~cascade.at(\shelf),
		\addAction,		\addBefore,
		\dur, 			0.25,
		\amp,			Pn(Pif(Ptime(inf) <= 25.6, env), inf),
		\attack,			attack,
		\sustain,			sustain,
		\release,			release,
		\startPos,		s.sampleRate * 0.05);
};

~cascadesFree = { ~cascadeBus.free; ~cascade.do({ | i | i.free }); };
);
*/