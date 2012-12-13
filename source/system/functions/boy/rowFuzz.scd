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

		\eq: Synth(\eq3, [\in, ~boyBus[\rowFuzz].eq, \out, ~boyBus[\rowFuzz].verb, \hiGain, 9],
			~group[\fx], \addToTail),

		\verb: Synth(\reverb1, [\in, ~boyBus[\rowFuzz].verb, \out, ~boyBus[\rowFuzz].dist, \mix, 0.86,
			\room, 0.8, \damp, 0, \amp, 1], ~group[\fx], \addToTail),

		\dist: Synth(\distortion3, [\in, ~boyBus[\rowFuzz].dist, \out, ~boyBus[\rowFuzz].nebula, \dist, 5.5, \amp, 1,
			\mix, 0.87, \bw, 25], ~group[\fx], \addToTail),

		\nebula: Synth(\nebula8, [\in, ~boyBus[\rowFuzz].nebula, \out, ~boyBus[\rowFuzz].del,
			\depth, 50, \activity, 40], ~group[\fx], \addToTail),

		\del: Synth(\pingPongDelayStereo, [\in, ~boyBus[\rowFuzz].del, \out, ~boyBus[\rowFuzz].fader,
			\delay, 0.915, \decay, 6, \centerFreq, 1000, \bw, 12, \mix, 0.49],
			~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~boyBus[\rowFuzz].fader, \out, ~mixer[\s1], \amp, -6.dbamp], ~group[\fx], \addToTail)
	);

	Pbindef(\rowFuzzMain,
		\instrument, \hammond,
		\group, ~boySynth[\rowFuzz].mainFader,
		\addAction, \addBefore,
		\out, ~boyBus[\rowFuzz].mainFader,
		\root, -5,
		\octave, 6,
		\amp, 0.5,
		\subAmp, 0.7,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.05,
		\partial4Amp, 0.05,
		\partial5Amp, 0.05,
		\partial6Amp, 0.01,
		\partial8Amp, 0,
		\note, Pseq([[-1, 0, 4, 6, 7, 9, 12]], inf),
		\dur, 8,
		\cutoff, 15000,
		\dist, 0.3,
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
		\subAmp, 0,
		\bassAmp, 0,
		\partial2Amp, 0.1,
		\partial3Amp, 0.1,
		\partial4Amp, 0.05,
		\partial5Amp, 0.05,
		\partial6Amp, 0,
		\partial8Amp, 0,
		\amp, 0.1,
		\note, Pseq([[-1, 0, 4, 6, 7, 9, 12]], inf),
		\dur, 8,
		\cutoff, 15000,
		\dist, 1,
		\noise, 0.03,
		\atk, 0.01,
		\sus, Pkey(\dur),
		\rel, 0.01
	);
};

~boy[\rowFuzz].addUniqueMethod(\kill, {
	~boyBus[\rowFuzz].do({ | i | i.free });
	~boySynth[\rowFuzz].do({ | i | i.free });
	Pbindef(\rowFuzzMain).stop;
	Pbindef(\rowFuzzLow).stop;
	Pbindef(\rowFuzzMain).remove;
	Pbindef(\rowFuzzLow).remove;
});

~boy[\rowFuzz].addUniqueMethod(\playMain, {
	~boy[\transport].playNextBar({
		Pbindef(\rowFuzzMain).play(~boy[\transport]);
	});
});

~boy[\rowFuzz].addUniqueMethod(\stopMain, {
	Pbindef(\rowFuzzMain).stop;
});

~boy[\rowFuzz].addUniqueMethod(\playLow, {
	~boy[\transport].playNextBar({
		Pbindef(\rowFuzzLow).play(~boy[\transport]);
	});
});

~boy[\rowFuzz].addUniqueMethod(\stopLow, {
	Pbindef(\rowFuzzLow).stop;
});

~boyMake[\rowFuzz] = r ({
	loop {
		~boy[\rowFuzz].value;
		~scLang.sendMsg(\control, \rowFuzz);
		["row fuzz synths created"].postln.yield;


		~boy[\rowFuzz].kill;
		~scLang.sendMsg(\control, \rowFuzz);
		["row fuzz synths freed"].postln.yield;
	};
});

~boyMake[\rowFuzzMainToggle] = r ({
	loop{
		~boy[\rowFuzz].playMain;
		~scLang.sendMsg(\control, \rowFuzzMainToggle);
		["main row fuzz playing"].postln.yield;

		~boy[\rowFuzz].stopMain;
		~scLang.sendMsg(\control, \rowFuzzMainToggle);
		["main row fuzz stopped"].postln.yield;
	};
});

~boyMake[\rowFuzzLowToggle] = r ({
	loop {
		~boy[\rowFuzz].playLow;
		~scLang.sendMsg(\control, \rowFuzzLowToggle);
		["low row fuzz playing"].postln.yield;

		~boy[\rowFuzz].stopLow;
		~scLang.sendMsg(\rowFuzzLowToggle);
		["low row fuzz stopped"].postln.yield;
	};
});

		