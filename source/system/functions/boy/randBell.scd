/*
Thursday, November 22nd, 2012
randBell.scd
prm
*/

~boy[\randBell] = {

	~boyBus[\randBell] = (
		\inFader: Bus.audio,
		\gran: Bus.audio,
		\fader: Bus.audio(s, 2)
	);

	~boySynth[\randBell] = (

		\inFader: Synth(\fader, [\in, ~boyBus[\randBell].inFader, \out, ~boyBus[\randBell].gran], ~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~boyBus[\randBell].gran, \out, ~boyBus[\randBell].fader,
				\bufLength, 4, \pan, 0, \panOffset, 1, \grainDur, 3, \grainDurOffset, 0.1,
				\rate, 0.5
			],
			~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~boyBus[\randBell].fader, \out, ~mixer[\s1], \amp, -9.0.dbamp], ~group[\fx], \addToTail)
	);

	Pbindef(\randBellDSharp,
		\instrument, \playBuf,
		\dur, 0.25,
		\type, Pif(Pfunc({ 300.rand == 0 }), \note, \rest),
		\note, 3,
		\sustain, 5,
		\octave, 0,
		\group, ~boySynth[\randBell].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\randBell].inFader,
		\freq, Pfunc{ | ev | ev.use(ev[\freq]) },
		\bufName, Pfunc({ | ev | ~boyBuf[\bells].at((ev[\freq].cpsmidi)) })
	);

	Pbindef(\randBellE,
		\instrument, \playBuf,
		\dur, 0.25,
		\type, Pif(Pfunc({ 35.rand == 0 }), \note, \rest),
		\note, 4,
		\sustain, 5,
		\octave, 0,
		\group, ~boySynth[\randBell].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\randBell].inFader,
		\freq, Pfunc{ | ev | ev.use(ev[\freq]) },
		\bufName, Pfunc({ | ev | ~boyBuf[\bells].at((ev[\freq].cpsmidi)) })
	);

	Pbindef(\randBellFSharp,
		\instrument, \playBuf,
		\dur, 0.25,
		\type, Pif(Pfunc({ 80.rand == 0 }), \note, \rest),
		\note, 6,
		\sustain, 5,
		\octave, 0,
		\group, ~boySynth[\randBell].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\randBell].inFader,
		\freq, Pfunc{ | ev | ev.use(ev[\freq]) },
		\bufName, Pfunc({ | ev | ~boyBuf[\bells].at((ev[\freq].cpsmidi)) })
	);

	Pbindef(\randBellG,
		\instrument, \playBuf,
		\dur, 0.25,
		\type, Pif(Pfunc({ 20.rand == 0 }), \note, \rest),
		\note, 7,
		\sustain, 5,
		\octave, 0,
		\group, ~boySynth[\randBell].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\randBell].inFader,
		\freq, Pfunc{ | ev | ev.use(ev[\freq]) },
		\bufName, Pfunc({ | ev | ~boyBuf[\bells].at((ev[\freq].cpsmidi)) })
	);

	Pbindef(\randBellGSharp,
		\instrument, \playBuf,
		\dur, 0.25,
		\type, Pif(Pfunc({ 150.rand == 0 }), \note, \rest),
		\note, 8,
		\sustain, 5,
		\octave, 0,
		\group, ~boySynth[\randBell].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\randBell].inFader,
		\freq, Pfunc{ | ev | ev.use(ev[\freq]) },
		\bufName, Pfunc({ | ev | ~boyBuf[\bells].at((ev[\freq].cpsmidi)) })
	);

	Pbindef(\randBellB,
		\instrument, \playBuf,
		\dur, 0.25,
		\type, Pif(Pfunc({ 30.rand == 0 }), \note, \rest),
		\note, 11,
		\sustain, 5,
		\octave, 0,
		\group, ~boySynth[\randBell].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\randBell].inFader,
		\freq, Pfunc{ | ev | ev.use(ev[\freq]) },
		\bufName, Pfunc({ | ev | ~boyBuf[\bells].at((ev[\freq].cpsmidi)) })
	);

	Pbindef(\randBellD,
		\instrument, \playBuf,
		\dur, 0.25,
		\type, Pif(Pfunc({ 30.rand == 0 }), \note, \rest),
		\note, 14,
		\sustain, 5,
		\octave, 0,
		\group, ~boySynth[\randBell].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\randBell].inFader,
		\freq, Pfunc{ | ev | ev.use(ev[\freq]) },
		\bufName, Pfunc({ | ev | ~boyBuf[\bells].at((ev[\freq].cpsmidi)) })
	);

	Pbindef(\randBellHighFSharp,
		\instrument, \playBuf,
		\dur, 0.25,
		\type, Pif(Pfunc({ 25.rand == 0 }), \note, \rest),
		\note, 18,
		\sustain, 5,
		\octave, 0,
		\group, ~boySynth[\randBell].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\randBell].inFader,
		\freq, Pfunc{ | ev | ev.use(ev[\freq]) },
		\bufName, Pfunc({ | ev | ~boyBuf[\bells].at((ev[\freq].cpsmidi)) })
	);

	Pbindef(\randBellHighG,
		\instrument, \playBuf,
		\dur, 0.25,
		\type, Pif(Pfunc({ 30.rand == 0 }), \note, \rest),
		\note, 19,
		\sustain, 5,
		\octave, 0,
		\group, ~boySynth[\randBell].inFader,
		\addAction, \addBefore,
		\out, ~boyBus[\randBell].inFader,
		\freq, Pfunc{ | ev | ev.use(ev[\freq]) },
		\bufName, Pfunc({ | ev | ~boyBuf[\bells].at((ev[\freq].cpsmidi)) })
	);
};

~boy[\randBell].addUniqueMethod(\kill, {
	~boyBus[\randBell].do({ | i | i.free; });
	~boySynth[\randBell].do({ | i | i.free });
	Pbindef(\randBellDSharp).clear;
	Pbindef(\randBellE).clear;
	Pbindef(\randBellFSharp).clear;
	Pbindef(\randBellG).clear;
	Pbindef(\randBellGSharp).clear;
	Pbindef(\randBellB).clear;
	Pbindef(\randBellD).clear;
	Pbindef(\randBellHighFSharp).clear;
	Pbindef(\randBellHighG).clear;
});

~boyMake[\randBell] = r({ | main |

	var val, toggle, vol;
	val = main.at(0);
	toggle = main.at(1);
	vol = main.at(2);

	loop {

		~boy[\randBell].value;

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\randBellToggle, { ~scLang.sendMsg(\randBell, \toggle, toggle); }, toggle);
		MIDIdef.cc(\randBellVolume, { | amp | ~scLang.sendMsg(\randBell, \volume, amp); }, vol);

		["random bell synths created"].postln;
		~ohm.turnPurple(val).yield;

		~boy[\randBell].kill;
		~ohm.turnOff(toggle);
		MIDIdef(\randBellToggle).free;
		MIDIdef(\randBellVolume).free;
		["random bell synths freed"].postln;
		~ohm.turnRed(val).yield;
	};
});

~boyMake[\randBellToggle] = r({ | val |
	loop {
		Pbindef(\randBellDSharp).play;
		Pbindef(\randBellE).play;
		Pbindef(\randBellFSharp).play;
		Pbindef(\randBellG).play;
		Pbindef(\randBellGSharp).play;
		Pbindef(\randBellB).play;
		Pbindef(\randBellD).play;
		Pbindef(\randBellHighFSharp).play;
		Pbindef(\randBellHighG).play;
		["rand bells playing"].postln;
		~ohm.turnPink(val).yield;

		Pbindef(\randBellDSharp).stop;
		Pbindef(\randBellE).stop;
		Pbindef(\randBellFSharp).stop;
		Pbindef(\randBellG).stop;
		Pbindef(\randBellGSharp).stop;
		Pbindef(\randBellB).stop;
		Pbindef(\randBellD).stop;
		Pbindef(\randBellHighFSharp).stop;
		Pbindef(\randBellHighG).stop;
		~ohm.turnRed(val).yield;
	};
});


	