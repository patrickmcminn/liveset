/*
Saturday, November 24th 2012
noiseChords.scd
prm
*/

~boy[\noiseChords] = {

	var gMajor7, eMajor7, dMajor7, aMajor;
	gMajor7 = [-12, 0, 4, 7, 11];
	eMajor7 = [-15, 1, 4, 8, 9];
	dMajor7 = [-17, -1, 2, 6, 7];
	aMajor = [-10, -3, 2, 6, 9];

	~boyBus[\noiseChords] = (
		\dist: Bus.audio,
		\fader: Bus.audio
	);

	~boySynth[\noiseChords] = (

		\dist: Synth(\digitalClip2, [\in, ~boyBus[\noiseChords].dist, \out, ~boyBus[\noiseChords].fader,
			\amount, 5000, \cutoff, 4000], ~group[\fx], \addToTail),

		\fader: Synth(\pan, [\in, ~boyBus[\noiseChords].fader, \out, ~mixer[\s2], \amp, 0.3],
			~group[\fx], \addToTail)
	);


	Pbindef(\boyChordsOne,
		\instrument, \hammond,
		\group, ~boySynth[\noiseChords].dist,
		\addAction, \addBefore,
		\out, ~boyBus[\noiseChords].dist,
		\dist, 1.2,
		\amp, 0.2,
		\cutoff, 20000,
		\legato, 0,
		\root, 7,
		\note, Pseq([gMajor7, eMajor7, dMajor7, aMajor], inf),
		\dur, Pseq([4, 3.5, 4.5, 4], inf),
		\atk, 0.01,
		\rel, 0.01,
		\sus, Pkey(\dur)*0.732,
		\octave, 4
	);


	Pbindef(\boyChordsTwo,
		\instrument, \hammond,
		\group, ~boySynth[\noiseChords].dist,
		\addAction, \addBefore,
		\out, ~boyBus[\noiseChords].dist,
		\dist, 1.2,
		\amp, 0.35,
		\cutoff, 20000,
		\legato, 1,
		\root, 7,
		\note, Pseq([gMajor7, eMajor7, gMajor7, eMajor7, dMajor7, aMajor, gMajor7, dMajor7], inf),
		\dur, Pseq([4, 3.5, 4.5, 3.5, 4, 4.5, 4, 4], inf),
		\atk, 0.12,
		\sus, Pkey(\dur) * 0.732,
		\octave, 4
	);


	Pbindef(\boyChordsThree,
		\instrument, \hammond,
		\group, ~boySynth[\noiseChords].dist,
		\addAction, \addBefore,
		\out, ~boyBus[\noiseChords].dist,
		\dist, 1.2,
		\amp, 0.3,
		\cutoff, 20000,
		\legato, 1,
		\root, 7,
		\note, Pseq([gMajor7, eMajor7], inf),
		\dur, Pseq([4, 3.5, 4.5, 3.5], inf),
		\atk, 0.12,
		\sus, Pkey(\dur)*0.732,
		\octave, 4
	);

};

~boy[\noiseChords].addUniqueMethod(\kill, {
	~boyBus[\noiseChords].do({ | i | i.free; });
	~boySynth[\noiseChords].do({ | i | i.free; });
	Pbindef(\boyChordsOne).stop;
	Pbindef(\boyChordsTwo).stop;
	Pbindef(\boyChordsThree).stop;
	Pbindef(\boyChordsOne).remove;
	Pbindef(\boyChordsTwo).remove;
	Pbindef(\boyChordsThree).remove;
});

~boy[\noiseChords].addUniqueMethod(\playOne, {
	~boy[\transport].playNextBar({
		Pbindef(\boyChordsOne).play(~boy[\transport]);
	});
});

~boy[\noiseChords].addUniqueMethod(\stopOne, {
	Pbindef(\boyChordsOne).stop;
});

~boy[\noiseChords].addUniqueMethod(\playTwo, {
	~boy[\transport].playNextBar({
		Pbindef(\boyChordsTwo).play(~boy[\transport]);
	});
});

~boy[\noiseChords].addUniqueMethod(\stopTwo, {
	Pbindef(\boyChordsTwo).stop;
});

~boy[\noiseChords].addUniqueMethod(\playThree, {
	~boy[\transport].playNextBar({
		Pbindef(\boyChordsThree).play(~boy[\transport]);
	});
});

~boy[\noiseChords].addUniqueMethod(\stopThree, {
	Pbindef(\boyChordsThree).stop;
});

~boyMake[\noiseChords] = r({ | main |

	var val, one, two, three, vol;
	val = main.at(0);
	one = main.at(1);
	two = main.at(2);
	three = main.at(3);
	vol = main.at(4);

	loop {
		~boy[\noiseChords].value;

		~ohm.turnGreen(one);
		MIDIdef.noteOn(\noiseChordsOne, { ~scLang.sendMsg(\noiseChords, \one, one) }, one);
		~ohm.turnBlue(two);
		MIDIdef.noteOn(\noiseChordsTwo, { ~scLang.sendMsg(\noiseChords, \two, two) }, two);
		~ohm.turnPink(three);
		MIDIdef.noteOn(\noiseChordsThree, { ~scLang.sendMsg(\noiseChords, \three, three) }, three);
		MIDIdef.cc(\noiseChordsVolume, { | amp | ~scLang.sendMsg(\noiseChords, \volume, amp) }, vol);
		["noise chords synths created"].postln;
		~ohm.turnLavender(val).yield;

		~boy[\noiseChords].kill;
		~ohm.turnOff(one);
		MIDIdef(\noiseChordsOne).free;
		~ohm.turnOff(two);
		MIDIdef(\noiseChordsTwo).free;
		~ohm.turnOff(three);
		MIDIdef(\noiseChordsThree).free;
		MIDIdef(\noiseChordsVolume).free;
		["noise chords synths freed"].postln;
		~ohm.turnRed(val).yield;

	};
});

~boyMake[\noiseChordsOne] = r ({ | val |
	loop{
		~boy[\noiseChords].playOne;
		["noise chords 1 playing"].postln;
		~ohm.turnPink(val).yield;

		~boy[\noiseChords].stopOne;
		["noise chords 1 stopped"].postln;
		~ohm.turnRed(val).yield;
	};
});

~boyMake[\noiseChordsTwo] = r ({ | val |
	loop {
		~boy[\noiseChords].playTwo;
		["noise chords 2 playing"].postln;
		~ohm.turnPurple(val).yield;

		~boy[\noiseChords].stopTwo;
		["noise chords 2 stopped"].postln;
		~ohm.turnRed(val).yield;
	};
});

~boyMake[\noiseChordsThree] = r ({ | val |
	loop {
		~boy[\noiseChords].playThree;
		["noise chords three playing"].postln;
		~ohm.turnYellow(val).yield;

		~boy[\noiseChords].stopThree;
		["noise chords three stopped"].postln;
		~ohm.turnRed(val).yield;
	};
});