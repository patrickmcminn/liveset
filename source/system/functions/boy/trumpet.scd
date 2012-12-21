/*
Friday, November 23rd 2012
trumpet.scd
prm
*/

~boy[\trumpet] = {

	~boyBus[\trumpet] = (
		\eq: Bus.audio,
		\verb: Bus.audio,
		\dist: Bus.audio,
		\nebula: Bus.audio,
		\del: Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);

	~boySynth[\trumpet] = (

		\inFader: Synth(\fader, [\in, ~inst[\mute], \out, ~boyBus[\trumpet].eq, \amp, -4.dbamp],
			~group[\fx], \addToTail),

		\pitchShift: Synth(\pitchShifter, [\in, ~inst[\mute], \out, ~boyBus[\trumpet].eq,
			\interval, 0, \amp, -3.dbamp], ~group[\fx], \addToTail),

		\eq: Synth(\eq3, [\in, ~boyBus[\trumpet].eq, \out, ~boyBus[\trumpet].verb,
			\loGain, -6, \hiGain, -6], ~group[\fx], \addToTail),

		\verb: Synth(\reverb1, [\in, ~boyBus[\trumpet].verb, \out, ~boyBus[\trumpet].dist,
			\mix, 0.75, \room, 0.7, \damp, 0.1], ~group[\fx], \addToTail),

		\dist: Synth(\digitalClip2, [\in, ~boyBus[\trumpet].dist, \out, ~boyBus[\trumpet].nebula,
			\amount, 150, \amp, 1], ~group[\fx], \addToTail),

		\nebula: Synth(\nebula8, [\in, ~boyBus[\trumpet].nebula, \out, ~boyBus[\trumpet].del,
			\activity, 100, \depth, 100], ~group[\fx], \addToTail),

		\del: Synth(\pingPongDelayStereo, [\in, ~boyBus[\trumpet].del, \out, ~boyBus[\trumpet].fader,
			\delay, 0.915, \decay, 9, \centerFreq, 1000, \bw, 6, \mix, 0.36], ~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~boyBus[\trumpet].fader, \out, ~mixer[\s2], \amp, -8.dbamp],
			~group[\fx], \addToTail)
	);
};

~boy[\trumpet].addUniqueMethod(\kill, {
	~boyBus[\trumpet].do({ | i | i.free; });
	~boySynth[\trumpet].do({ | i | i.free; });
});

~boyMake[\trumpet] = r ({

	loop {
		~boy[\trumpet].value;
		~scLang.sendMsg(\control, \boyTrumpet);
		["trumpet synths on"].postln.yield;

		~boy[\trumpet].kill;
		~scLang.sendMsg(\control, \boyTrumpet);
		["trumpet synths off"].postln.yield;
	};
});

~boyMake[\trumpetToggle] = r({
	loop {

		~boySynth[\trumpet].inFader.set(\mute, 0);
		~boySynth[\trumpet].pitchShift.set(\amp, 0);
		~scLang.sendMsg(\control, \boyTrumpetToggle);
		["trumpet input muted"].postln.yield;

		~boySynth[\trumpet].inFader.set(\mute, 1);
		~boySynth[\trumpet].pitchShift.set(\amp, -5.dbamp);
		~scLang.sendMsg(\control, \boyTrumpetToggle);
		["trumpet input active"].postln.yield;
	};
});

~boyMake[\trumpetOctaveToggle] = r({
	loop {
		~boySynth[\trumpet].pitchShift.set(\interval, 12);
		~scLang.sendMsg(\control, \boyTrumpetOctaveToggle);
		["octave pitch shifter"].postln.yield;


		~boySynth[\trumpet].pitchShift.set(\interval, 0);
		~scLang.sendMsg(\control, \boyTrumpetOctaveToggle);
		["octave pitch shifter off"].postln.yield;

	};
});

