/*
Thursday, November 22nd 2012
Fort Wayne, IN
rowFuzz.scd
prm
*/

~boy[\rowFuzz] = {

	~boyBus[\rowFuzz] = (
		\mainFader: Bus.audio,
		\lowFader: Bus.audio,
		\eq: Bus.audio,
		\verb: Bus.audio,
		\dist: Bus.audio,
		\nebula: Bus.audio,
		\del: Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);

	~boySynth[\rowFuzz] = (

		\mainFader: Synth(\fader, [\in, ~boyBus[\rowFuzz].mainFader, \out, ~boyBus[\rowFuzz].eq, \amp, 1],
			~group[\fx], \addToTail),

		\lowFader: Synth(\fader, [\in, ~boyBus[\rowFuzz].lowFader, \out, ~boyBus[\rowFuzz].eq, \amp, 1],
			~group[\fx], \addToTail),

		\eq: Synth(\eq3, [\in, ~boyBus[\rowFuzz].eq, \out, ~boyBus[\rowFuzz].verb, \hiGain, 6],
			~group[\fx], \addToTail),

		\verb: Synth(\reverb1, [\in, ~boyBus[\rowFuzz].verb, \out, ~boyBus[\rowFuzz].nebula, \mix, 0.8,
			\room, 0.7, \damp, 0.3, \amp, 1], ~group[\fx], \addToTail),

		\nebula: Synth(\nebula, [\in, ~boyBus[\rowFuzz].nebula, \out, ~boyBus[\rowFuzz].del,
			\depth, 61, \activity, 55, \num, 8], ~group[\fx], \addToTail),

		\del: Synth(\pingPongDelayStereo, [\in, ~boyBus[\rowFuzz].del, \out, ~boyBus[\rowFuzz].fader,
			\delay, 0.915, \decay, 12, \centerFreq, 1000, \bw, 5, \mix, 0.49],
			~group[\fx], \addToTail),

		\fader: Synth(\pan, [\in, ~boyBus[\rowFuzz].fader, \out, ~mixer[\s1]], ~group[\fx], \addToTail)
	);

	Pbindef(\rowFuzzMain,
		\instrument, \hammond,
		\group, ~boySynth[\rowFuzz].mainFader,
		\addAction, \addBefore,
		\out, ~boyBus[\rowFuzz].mainFader,
		\root, -5,
		\octave, 5,
		\amp, 0.5,
		\note, Pseq([[-1, 0, 4, 6, 7, 9, 12]], inf),
		\dur, 8,
		\subAmp,
		\bassAmp,
		\fundAmp,
		\partial2Amp,
		\partial3Amp,
		\partial4Amp,
		\partial5Amp,
		\partial6Amp,
		\partial8Amp,
		\cutoff, 15000,
		\dist, 15,
		\noise, 0.03,
		\atk, 0.01,
		\sus, Pkey(\dur),
		\rel, 0.01
	);

	Pbindef(\rowFuzzLow,
		\instrument, \hammond,
		\group, ~boySynth[\rowFuzz].lowFader,
		\addAction, \addBefore,
		\out, ~boyBus[\rowFuzz].lowFader,
		\root, -5,
		\octave, 4,
		\amp, 0.2,
		\note, Pseq([[-1, 0, 4, 6, 7, 9, 12]], inf),
		\dur, 8,
		\subAmp,
		\bassAmp,
		\fundAmp,
		\partial2Amp,
		\partial3Amp,
		\partial4Amp,
		\partial5Amp,
		\partial6Amp,
		\partial8Amp,
		\cutoff, 15000,
		\dist, 15,
		\noise, 0.03,
		\atk, 0.01,
		\sus, Pkey(\dur),
		\rel, 0.01
	);
};

~boy[\rowFuzz].addUniqueMethod(\kill, {
	~boyBus[\rowFuzz].do({ | i | i.free });
	~boySynth[\rowFuzz].do({ | i | i.free });
	Pbindef(\rowFuzzMain).clear;
	Pbindef(\rowFuzzLow).clear;
});

~boy[\rowFuzz].addUniqueMethod(\playMain, {
	Pbindef(\rowFuzzMain).play(~boy[\transport]);
});

~boy[\rowFuzz].addUniqueMethod(\stopMain, {
	Pbindef(\rowFuzzMain).stop;
});

~boy[\rowFuzz].addUniqueMethod(\playLow, {
	Pbindef(\rowFuzzLow).play(~boy[\transport]);
});

~boy[\rowFuzz].addUniqueMethod(\stopLow, {
	Pbindef(\rowFuzzLow).stop;
});

~boyMake[\rowFuzz] = r ({ | main |
	var val, mainToggle, lowToggle, play, vol;
	val = main.at(0);
	mainToggle = main.at(1);
	lowToggle = main.at(2);
	play = main.at(3);
	vol = main.at(4);

	loop {
		~boy[\rowFuzz].value;

		~ohm.turnPurple(mainToggle);
		MIDIdef.noteOn(\rowFuzzMainToggle, { ~scLang.sendMsg(\rowFuzz, \mainToggle, mainToggle); }, mainToggle);

		~ohm.turnLavender(lowToggle);
		MIDIdef.noteOn(\rowFuzzLowToggle, { ~scLang.sendMsg(\rowFuzz, \lowToggle, lowToggle); }, lowToggle);

		MIDIdef.cc(\rowFuzzVolume, { | amp | ~scLang.sendMsg(\rowFuzz, \volume, amp); }, vol);
		["row fuzz synths created"].postln;
		~ohm.turnBlue(val).yield;

		~boy[\rowFuzz].kill;
		~ohm.turnOff(mainToggle);
		MIDIdef(\rowFuzzMainToggle).free;
		~ohm.turnOff(lowToggle);
		MIDIdef(\rowFuzzLowToggle).free;
		MIDIdef(\rowFuzzVolume).free;
		["row fuzz synths freed"].postln;
		~ohm.turnRed(val).yield;

	};
});

~boyMake[\rowFuzzMainToggle] = r ({ | val |
	loop{
		~boy[\rowFuzz].playMain;
		["main row fuzz playing"].postln;
		~ohm.turnPink(val).yield;

		~boy[\rowFuzz].stopMain;
		["main row fuzz stopped"].postln;
		~ohm.turnRed(val).yield;
	};
});

~boyMake[\rowFuzzLowToggle] = r ({ | val |
	loop {
		~boy[\rowFuzz].playLow;
		["low row fuzz playing"].postln;
		~ohm.turnLavender(val).yield;

		~boy[\rowFuzz].stopLow;
		["low row fuzz stopped"].postln;
		~ohm.turnRed(val).yield;
	};
});
		