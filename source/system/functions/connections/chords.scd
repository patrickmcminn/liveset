/*
Wednesday, October 17th 2012
chords.scd
prm
*/


~connections[\chords] = {
	~connectBus[\chords] = (
		\verb: Bus.audio,
		\gran: Bus.audio,
	);
	~connectSynth[\chords] = (

		\hiShelf: Synth(\hiShelf, [\in, ~connectBus[\chords].verb, \out, ~connectBus[\chords].verb,
			\freq, 2500, \gain, -6], ~group[\fx], \addToTail),

		\verb: Synth(\reverb1, [\in, ~connectBus[\chords].verb, \out, ~connectBus[\chords].gran,
			\room, 0.9, \damp, 0.7, \mix, 1], ~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~connectBus[\chords].gran, \out, ~mixer[\s1],
				\bufLength, 3, \mix, 0.45, \grainDur, 0.15, \grainDurOffset, 0.05,
				\panOffset, 0, \env, ~grainBufs[\gabor], \trigRate, 25
			],
			~group[\fx], \addToTail)
	);

	Pbindef(\chordRand,
		\instrument, \holder,
		\bufName, Pxrand([~connectBuf[\chordSum].at(0), ~connectBuf[\chordSum].at(1), ~connectBuf[\chordSum].at(2),
			~connectBuf[\chordSum].at(3)], inf),
		\out, ~connectBus[\chords].verb,
		\group, ~connectSynth[\chords].hiShelf,
		\addAction, \addBefore,
		\dur, Pwhite(0.125, 1, inf),
		\attack, (Pkey(\dur) * 0.05) * ~connections[\transport].tempo,
		\sustain,(Pkey(\dur) * 0.9) * ~connections[\transport].tempo,
		\release, (Pkey(\dur) * 0.05) * ~connections[\transport].tempo,
		\amp, 0.2
	);

	Pbindef(\chords,
		\instrument, \holder,
		\bufName, Pseq([~connectBuf[\chordSum].at(0), ~connectBuf[\chordSum].at(1), ~connectBuf[\chordSum].at(2),
			~connectBuf[\chordSum].at(3)], inf),
		\out, ~connectBus[\chords].verb,
		\group, ~connectSynth[\chords].hiShelf,
		\addAction, \addBefore,
		\dur, 4,
		\attack, 0.01,
		\sustain, 3.2,
		\release, 0.01,
		\amp, 0.6
	);

};

~connections[\chords].addUniqueMethod(\kill, {

	~connectBus[\chords].do({ | i | i.free; });
	~connectSynth[\chords].do({ | i | i.free; });

	Pbindef(\chordRand).stop;
	Pbindef(\chords).stop;

	Pbindef(\chordRand).clear;
	Pbindef(\chords).clear;
});

~connections[\chords].addUniqueMethod(\playRand, {
	Pbindef(\chordRand).play;
});

~connections[\chords].addUniqueMethod(\stopRand, {
	Pbindef(\chordRand).stop;
});

~connections[\chords].addUniqueMethod(\playChords, {
	Pbindef(\chords).play;
});

~connections[\chords].addUniqueMethod(\stopChords, {
	Pbindef(\chords).stop;
});

~connectMake[\chords] = r { | main |
	var val, sum, toggle, vol;
	val = main.at(0);
	sum = main.at(1);
	toggle = main.at(2);
	vol = main.at(3);
	loop{
		~connections[\chords].value;
		~ohm.turnGreen(sum);
		MIDIdef.noteOn(\chordSum, { ~scLang.sendMsg(\chords, \sum, sum) }, sum);
		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\chordToggle, { ~scLang.sendMsg(\chords, \toggle, toggle) }, toggle);
		MIDIdef.cc(\chordVolume, { | amp | ~scLang.sendMsg(\chords, \volume, amp) }, vol);
		["chord synths made"].postln;
		~ohm.turnPurple(val).yield;

		~connections[\chords].kill;
		~ohm.turnOff(sum);
		~ohm.turnOff(toggle);
		MIDIdef(\chordVolume).free;
		MIDIdef(\chordSum).free;
		MIDIdef(\chordToggle).free;
		["chord synths freed"].postln;
		~ohm.turnRed(val).yield;
	};
};

~connectMake[\chordsToggle] = r { | val |
	loop{

		~connections[\transport].playNextBar({
			~connections[\chords].playRand;
			["random chords playing"].postln;
		});
		~ohm.turnYellow(val).yield;


		~connections[\transport].playNextBar({
			~connections[\chords].stopRand;
			~connections[\chords].playChords;
			["chord sequence playing"].postln;
		});
		~ohm.turnLavender(val).yield;

		~connections[\transport].playNextBar({
			~connections[\chords].stopChords;
			["chord sequence stopped"].postln;
		});
		~ohm.turnRed(val).yield;
	};
};





/*
(
~chords = {
	~chordBus = (
		\verb:		Bus.audio,
		\gran:		Bus.audio,
		\pan:		Bus.audio(s, 2));
	~chord = (
		\hiShelf:		Synth(\hiShelf, [\in, ~chordBus.at(\verb), \out, ~chordBus.at(\verb),
						\freq, 2500, \gain, -6], ~fx, \addToTail),
		\verb:		Synth(\reverb1, [\in, ~chordBus.at(\verb), \out, ~chordBus.at(\gran),
						\room, 0.9, \damp, 0.7, \mix, 1], ~fx, \addToTail),
		\gran:		Synth(\granulator, [\in, ~chordBus.at(\gran), \out, ~chordBus.at(\pan),
						\bufLength, 3, \mix, 1, \grainDur, 0.15, \grainDurOffset, 0.05,
						\panOffset, 0, \env, ~grainBufs.at(\gabor), \trigRate, 25],
						~fx, \addToTail),
		\pan:		Synth(\pan, [\in, ~chordBus.at(\pan), \out, ~outBusOne, \amp, 1],
						~fx, \addToTail));

	Pbindef(\chords,
		\instrument,		\holder,
		\bufName,			Pxrand([~chordBufs.at(0), ~chordBufs.at(1), ~chordBufs.at(2),
								~chordBufs.at(3)], inf),
		\out,			~chordBus.at(\verb),
		\group,			~chord.at(\hiShelf),
		\addAction,		\addBefore,
		\dur,			Pwhite(0.125, 1, inf),
		\attack,			(Pkey(\dur)*0.05)*(~connectionsT.tempo),
		\sustain,			(Pkey(\dur)*0.9)*(~connectionsT.tempo),
		\release,			(Pkey(\dur)*0.05)*(~connectionsT.tempo),
		\amp, 0.2);

	Pbindef(\chords2,
		\instrument,		\holder,
		\bufName,			Pseq([~chordBufs.at(0), ~chordBufs.at(1), ~chordBufs.at(2),
								~chordBufs.at(3)], inf),
		\out,			~chordBus.at(\verb),
		\group,			~chord.at(\hiShelf),
		\addAction,		\addBefore,
		\attack,			0.01,
		\sustain,			3.2,
		\release,			0.01,
		\dur,			4,
		\amp,			0.6);
		~chord.at(\gran).set(\mix, 0.45);
};

~chordsFree = { ~chordBus.do({ | i | i.free }); ~chord.do({ | i | i.free }); };
);
*/
