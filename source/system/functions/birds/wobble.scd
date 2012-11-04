/*
Friday, November 2nd 2012
wobble.scd
prm
*/

~birds[\wobble] = {

	~birdsBus[\wobble] = (
		\mod: Bus.control,
		\modmod: Bus.control,
		\filter: Bus.audio,
		\fader: Bus.audio
	);

	~birdsSynth[\wobble] = (

		\modmod: Synth(\lfSin, [\out, ~birdsBus[\wobble].modmod, \freq, 0.05,
			\rangeLo, 1, \rangeHi, 20], ~group[\control], \addToTail),

		\mod: Synth(\lfSin, [\out, ~birdsBus[\wobble].mod, \freq, ~birdsBus[\wobble].modmod.asMap,
			\rangeLo, 20, \rangeHi, 8000], ~group[\control], \addToTail),

		\noiseSynth: Synth(\playBuf, [\out, ~birdsBus[\wobble].filter, \bufName, ~birdsBuf[\noiseSynth].at(42-32), \loop, 1,
			\sustain, 300, \amp, 0.6], ~group[\synths], \addToTail),

		\lowSynth: Synth(\ratioSaw, [\out, ~birdsBus[\wobble].fader, \freq, 30.midicps, \filterMul, 4, \sus, 300,
			\amp, 0.9], ~group[\synths], \addToTail),

		\filter: Synth(\lowPassFilter, [\in, ~birdsBus[\wobble].filter, \out, ~birdsBus[\wobble].filter,
			\cutoff, ~birdsBus[\wobble].mod.asMap], ~group[\fx], \addToTail),

		\eq3: Synth(\eq3, [\in, ~birdsBus[\wobble].filter, \out, ~birdsBus[\wobble].fader,
			\loGain, 4], ~group[\fx], \addToTail),

		\fader: Synth(\pan, [\in, ~birdsBus[\wobble].fader, \out, ~mixer[\s3], \amp, 0.6], ~group[\fx], \addToTail)
	);

};

~birds[\wobble].addUniqueMethod(\kill, {
	~birdsBus[\wobble].do({ | i | i.free; });
	~birdsSynth[\wobble].do({ | i | i.free; });
});

