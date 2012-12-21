/*
Thursday, November 13th 2012
mainBell.scd
prm
*/

~boy[\mainBell] = {

	~boyBus[\mainBell] = (
		\pan: Bus.control,
		\verb: Bus.audio,
		\fader: Bus.audio
	);

	~boySynth[\mainBell] = (

		\pan: Synth(\lfSin, [\out, ~boyBus[\mainBell].pan, \freq, 0.19, \rangeLo, -0.8, \rangeHi, 0.8],
			~group[\control], \addToTail),

		\verb: Synth(\reverb1, [\in, ~boyBus[\mainBell].verb, \out, ~boyBus[\mainBell].fader,
			\mix, 0.4, \room, 0.9, \damp, 0], ~group[\fx], \addToTail),

		\fader: Synth(\pan, [\in, ~boyBus[\mainBell].fader, \out, ~mixer[\s1], \pan, ~boyBus[\mainBell].pan.asMap],
			~group[\fx], \addToTail)
	);


	Pbindef(\mainBell,
		\instrument, \playBuf,
		\out, ~boyBus[\mainBell].verb,
		\group, ~boySynth[\mainBell].verb,
		\addAction, \addBefore,
		\amp, 0.7,
		\legato, 1,
		\dur, 8,
		\attack, 0.05,
		\sustain, 6,
		\release, 0.05,
		\note, Pseq([7], inf),
		\octave, 0,
		\freq, Pfunc{ | ev | ev.use(ev[\freq]) },
		\bufName, Pfunc({ | ev | ~boyBuf[\bells].at((ev[\freq].cpsmidi)) })
	);

};

~boy[\mainBell].addUniqueMethod(\kill, {
	~boyBus[\mainBell].do({ | i | i.free; });
	~boySynth[\mainBell].do({ | i | i.free; });
	Pbindef(\mainBell).stop;
	Pbindef(\mainBell).remove;
});

~boyMake[\mainBell] = r({
	loop {
		~boy[\mainBell].value;
		~scLang.sendMsg(\control, \mainBell);
		["main bell synths active"].postln.yield;


		~boy[\mainBell].kill;
		~scLang.sendMsg(\control, \mainBell);
		["main bell synths freed"].postln.yield;
	};
});

~boyMake[\mainBellToggle] = r ({ | val |
	loop{
		~boy[\transport].playNextBar({ Pbindef(\mainBell).play(~boy[\transport]) });
		~scLang.sendMsg(\control, \mainBellToggle);
		["main bell playing"].postln.yield;

		Pbindef(\mainBell).stop;
		~scLang.sendMsg(\control, \mainBellToggle);
		["main bell stopped"].postln.yield;
	};
});



/*
~boy[\mainBell].value
Pbindef(\mainBell).play(~boy[\transport])

~boySynth[\mainBell].verb.set(\mix, 0.6, \room, 0.75, \damp, 0)



Pbindef(\mainBell,
	\instrument, \playBuf,
	\out, 0,
	\amp, 0.7,
	\legato, 1,
	\dur, 8,
	\attack, 0.05,
	\sustain, 6,
	\release, 0.05,
	\note, Pseq([7], inf),
	\octave, 0,
	\freq, Pfunc{ | ev | ev.use(ev[\freq]) },
	\bufName, Pfunc({ | ev | ~boyBuf[\bells].at((ev[\freq].cpsmidi)) })
)

Pbindef(\mainBell).stop




Pbind(
				\instrument, \playBuf,
				\out, ~birdsBus[\noiseSynth].gran,
				\group, ~birdsSynth[\noiseSynth].gran,
				\addAction, \addBefore,
				\amp, Pwhite(0.4, 0.7, inf),
				\scale, Pfunc({ ~birds[\mode]}, inf),
				\root, 6,
				\legato, 1,
				\octave, 5,
				\dur, 4,
				\attack, attack,
				\sustain, sustain,
				\release, release,
				\degree, Pseq([6, 4], 1),
				\freq, Pfunc { | ev | ev.use(ev[\freq]) },
				\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })),

*/