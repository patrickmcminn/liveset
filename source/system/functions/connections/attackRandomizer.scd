/*
Tuesday, October 16th 2012
edited 12/12/2012
-reflects change in control surface structure
attackRandomizer.scd
prm
*/


~connections[\attackRandomizer] = {
	~connectBus[\attackRandomizer] = (
		\audio: Bus.audio,
		\pan: Bus.control
	);
	~connectSynth[\attackRandomizer] = (

		\panSine: Synth(\lfSin, [\out, ~connectBus[\attackRandomizer].pan, \freq, 0.09,
			\rangeLo, -1, \rangeHi, 1], ~group[\control], \addToTail),

		\hiShelf: Synth(\hiShelf, [\in, ~connectBus[\attackRandomizer].audio, \out, ~connectBus[\attackRandomizer].audio,
			\freq, 2500, \grain, -7], ~connectSynth[\inlet].verb, \addBefore),

		\pan: Synth(\pan, [\in, ~connectBus[\attackRandomizer].audio, \out, ~connectBus[\inlet].verb, \amp, -6.dbamp,
			\pan, ~connectBus[\attackRandomizer].at(\pan).asMap], ~connectSynth[\inlet].verb, \addBefore)
	);

	Pbindef(\atkRandCSharp,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\note].at(0),
		\out, ~connectBus[\attackRandomizer].audio,
		\note, Pif( Pfunc( { 12.rand > 8 }), 1, \r),
		\group, ~connectSynth[\attackRandomizer].hiShelf,
		\addAction, \addBefore,
		\dur, 2,
		\attack, 3,
		\sustain, 0.15,
		\release, 0.05,
		\amp, 0.35
	);

	Pbindef(\atkRandGSharp,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\note].at(1),
		\out, ~connectBus[\attackRandomizer].audio,
		\note, Pif( Pfunc( { 12.rand > 9 }), 1, \r),
		\group, ~connectSynth[\attackRandomizer].hiShelf,
		\addAction, \addBefore,
		\dur, 2,
		\attack, 3,
		\sustain, 0.15,
		\release, 0.05,
		\amp, 0.35
	);

	Pbindef(\atkRandFSharp,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\note].at(2),
		\out, ~connectBus[\attackRandomizer].audio,
		\note, Pif( Pfunc( { 16.rand > 12 }), 1, \r),
		\group, ~connectSynth[\attackRandomizer].hiShelf,
		\addAction, \addBefore,
		\dur, 2,
		\attack, 3,
		\sustain, 0.15,
		\release, 0.05,
		\amp, 0.35
	);

	Pbindef(\atkRandA,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\note].at(3),
		\out, ~connectBus[\attackRandomizer].audio,
		\note, Pif( Pfunc( { 8.rand > 6 }), 1, \r),
		\group, ~connectSynth[\attackRandomizer].hiShelf,
		\addAction, \addBefore,
		\dur, 2,
		\attack, 3,
		\sustain, 0.15,
		\release, 0.05,
		\amp, 0.35
	);
};


~connections[\attackRandomizer].addUniqueMethod(\kill, {

	~connectBus[\attackRandomizer].do({ | i | i.free; });
	~connectSynth[\attackRandomizer].do({ | i | i.free; });

	Pbindef(\atkRandCSharp).stop;
	Pbindef(\atkRandGSharp).stop;
	Pbindef(\atkRandFSharp).stop;
	Pbindef(\atkRandA).stop;

	Pbindef(\atkRandCSharp).clear;
	Pbindef(\atkRandGSharp).clear;
	Pbindef(\atkRandFSharp).clear;
	Pbindef(\atkRandA).clear;
});

~connections[\attackRandomizer].addUniqueMethod(\playAtk, {
	Pbindef(\atkRandCSharp).play;
	Pbindef(\atkRandGSharp).play;
	Pbindef(\atkRandFSharp).play;
	Pbindef(\atkRandA).play;
});

~connections[\attackRandomizer].addUniqueMethod(\stopAtk, {
	Pbindef(\atkRandCSharp).stop;
	Pbindef(\atkRandGSharp).stop;
	Pbindef(\atkRandFSharp).stop;
	Pbindef(\atkRandA).stop;
});

~connectMake[\attackRandomizer] = r {
	loop {
		~connections[\attackRandomizer].value;
		~scLang.sendMsg(\control, \attackRandomizer);
		["attack randomizers created"].postln.yield;

		~connections[\attackRandomizer].kill;
		~scLang.sendMsg(\control, \attackRandomizer);
		["attack randomizers freed"].postln.yield;
	};
};

~connectMake[\attackRandomizerToggle] = r { | val |
	loop {
		~connections[\attackRandomizer].playAtk;
		~scLang.sendMsg(\control, \attackRandomizerToggle);
		["attack randomizers playing"].postln.yield;

		~connections[\attackRandomizer].stopAtk;
		~scLang.sendMsg(\control, \attackRandomizerToggle);
		["attack randomizers stopped"].postln.yield;
	};
};




/*
(
~attackRandomizer = {
	~atkRndBus = (
		\audio:	Bus.audio,
		\pan:	Bus.control);
	~atkRnd = (
		\panSine:		Synth(\lfSin, [\out, ~atkRndBus.at(\pan), \freq, 0.09, \rangeLo, -1,
						\rangeHi, 1], ~controlGroup, \addToTail),
		\hiShelf:		Synth(\hiShelf, [\in, ~atkRndBus.at(\audio), \out, ~atkRndBus.at(\audio), 						\freq, 2500, \gain, -7], ~inlets.at(\verb), \addBefore),
		\pan:		Synth(\pan, [\in, ~atkRndBus.at(\audio), \out, ~inletBus.at(\verb),
						\pan, ~atkRndBus.at(\pan).asMap], ~inlets.at(\verb), \addBefore));
	Pbindef(\attackRandomizerCSharp,
		\instrument, 		\playBuf,
		\bufName,			~noteBuffers.at(0),
		\out,			~atkRndBus.at(\audio),
		\note,			Pif( Pfunc({12.rand > 8}), 1, \r),
		\group, 			~atkRnd.at(\hiShelf),
		\addAction,		\addBefore,
		\dur,			2,
		\attack,			3,
		\sustain,			0.15,
		\release,			0.05,
		\amp,			0.35);

	Pbindef(\attackRandomizerGSharp,
		\instrument, 		\playBuf,
		\bufName,			~noteBuffers.at(1),
		\out,			~atkRndBus.at(\audio),
		\note,			Pif(Pfunc({ 12.rand > 9 }), 1, \r),
		\group, 			~atkRnd.at(\hiShelf),
		\addAction,		\addBefore,
		\dur,			4,
		\attack,			3,
		\sustain,			0.15,
		\release,			0.05,
		\amp,			0.35);

	Pbindef(\attackRandomizerFSharp,
		\instrument,		\playBuf,
		\bufName,			~noteBuffers.at(2),
		\out,			~atkRndBus.at(\audio),
		\note,			Pif(Pfunc({ 16.rand > 12 }), 1, \r),
		\group, 			~atkRnd.at(\hiShelf),
		\addAction,		\addBefore,
		\dur, 			3.5,
		\attack,			3,
		\sustain,			0.15,
		\release,			0.05,
		\amp,			0.35);

	Pbindef(\attackRandomizerA,
		\instrument,		\playBuf,
		\bufName,			~noteBuffers.at(3),
		\out,			~atkRndBus.at(\audio),
		\note, 			Pif(Pfunc({ 8.rand > 6 }), 1, \r),
		\group, 			~atkRnd.at(\hiShelf),
		\addAction,		\addBefore,
		\dur, 			4.5,
		\attack,			3,
		\sustain,			0.15,
		\release,			0.05,
		\amp,			0.35);
};

~attackRandomizerFree = { ~atkRndBus.do({ | i | i.free }); ~atkRnd.do({ | i | i.free }); };
);
*/
