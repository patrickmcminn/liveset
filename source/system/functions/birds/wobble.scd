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

		//\noiseSynth: Synth(\playBuf, [\out, ~birdsBus[\wobble].filter, \bufName, ~birdsBuf[\noiseSynth].at(42-32), \loop, 1,
			//\sustain, 10, \amp, 0.6], ~group[\synths], \addToTail),

		//\lowSynth: Synth(\ratioSaw, [\out, ~birdsBus[\wobble].fader, \freq, 30.midicps, \filterMul, 4, \sus, 300,
			//\amp, 0.9], ~group[\synths], \addToTail),

		\filter: Synth(\lowPassFilter, [\in, ~birdsBus[\wobble].filter, \out, ~birdsBus[\wobble].filter,
			\cutoff, ~birdsBus[\wobble].mod.asMap], ~group[\fx], \addToTail),

		\eq3: Synth(\eq3, [\in, ~birdsBus[\wobble].filter, \out, ~birdsBus[\wobble].fader,
			\loGain, 4], ~group[\fx], \addToTail),

		\fader: Synth(\pan, [\in, ~birdsBus[\wobble].fader, \out, ~mixer[\s3], \amp, 0], ~group[\fx], \addToTail)
	);

	Pbindef(\wobble,
		\instrument, \playBuf,
		\out, ~birdsBus[\wobble].filter,
		\group, ~birdsSynth[\wobble].filter,
		\loop, 1,
		\addAction, \addBefore,
		\attack, 0.05,
		\sustain, 8,
		\release, 0.05,
		\legato, 1,
		\amp, 0.6,
		\dur, 8,
		\degree, 0,
		\octave, 3,
		\root, 6,
		\freq, Pfunc { | ev | ev.use(ev[\freq]) },
		\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32)})
	);


	Pbindef(\lowDrone,
		\instrument, \ratioSaw,
		\out, ~birdsBus[\wobble].fader,
		\group, ~birdsSynth[\wobble].fader,
		\addAction, \addBefore,
		\root, 6,
		\legato, 1,
		\sus, 8,
		\amp, 0.9,
		\filterMul, 7,
		\dur, 8,
		\degree, 0,
		\octave, 2
	);

};

~birds[\wobble].addUniqueMethod(\kill, {
	~birdsBus[\wobble].do({ | i | i.free; });
	~birdsSynth[\wobble].do({ | i | i.free; });
});

~birdsMake[\wobble] = r ({
	loop {
		~birds[\wobble].value;
		~scLang.sendMsg(\control, \wobble);
		["wobble synths created"].postln.yield;


		~birds[\wobble].kill;
		~scLang.sendMsg(\control, \wobble);
		["wobble synths freed"].postln.yield;
	};
});

~birdsMake[\wobbleToggle] = r({
	loop{
		Pbindef(\wobble).play;
		Pbindef(\lowDrone).play;
		~scLang.sendMsg(\control, \wobbleToggle);
		["wobble and low drone playing"].postln.yield;

		Pbindef(\wobble).stop;
		Pbindef(\lowDrone).stop;
		~scLang.sendMsg(\control, \wobbleToggle);
		["wobble and low drone stopped"].postln.yield;
	};
});
