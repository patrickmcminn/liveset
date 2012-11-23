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

		\inFader: Synth(\fader, [\in, ~inst[\mute], \out, ~boyBus[\trumpet].eq, \amp, 1],
			~group[\fx], \addToTail),

		\eq: Synth(\eq3, [\in, ~boyBus[\trumpet].eq, \out, ~boyBus[\trumpet].verb,
			\loGain, -6, \hiGain, -6], ~group[\fx], \addToTail),

		\verb: Synth(\reverb1, [\in, ~boyBus[\trumpet].verb, \out, ~boyBus[\trumpet].dist,
			\mix, 0.75, \room, 0.7, \damp, 0.1], ~group[\fx], \addToTail),

		\dist: Synth(\digitalClip2, [\in, ~boyBus[\trumpet].dist, \out, ~boyBus[\trumpet].nebula,
			\amount, 150, \amp, 0.2], ~group[\fx], \addToTail),

		\nebula: Synth(\nebula, [\in, ~boyBus[\trumpet].nebula, \out, ~boyBus[\trumpet].del,
			\activity, 100, \depth, 60], ~group[\fx], \addToTail),

		\del: Synth(\pingPongDelayStereo, [\in, ~boyBus[\trumpet].del, \out, ~boyBus[\trumpet].fader,
			\delay, 0.915, \decay, 9, \centerFreq, 1000, \bw, 4, \mix, 0.36], ~group[\fx], \addToTail)
	);
};

~boy[\trumpet].addUniqueMethod(\kill, {
	~boyBus[\trumpet].do({ | i | i.free; });
	~boySynth[\trumpet].do({ | i | i.free; });
});

~boyMake[\trumpet] = r ({ | main |
	var val, toggle, vol;
	val = main.at(0);
	toggle = main.at(1);
	vol = main.at(2);

	loop {
		~boy[\trumpet].value;

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\trumpetToggle, { ~scLang.sendMsg(\trumpet, \toggle, toggle); }, toggle);
		MIDIdef.cc(\trumpetVolume, { | amp | ~scLang.sendMsg(\trumpet, \volume, amp); }, vol);

		["trumpet synths on"].postln;
		~ohm.turnBlue(val).yield;

		~boy[\trumpet].kill;
		~ohm.turnOff(toggle);
		MIDIdef(\trumpetToggle).free;
		MIDIdef(\trumpetVolume).free;
		["trumpet synths off"].postln;
		~ohm.turnRed(val).yield;
	};
});

~boyMake[\trumpetToggle] = r({ | val |
	loop {

		~boySynth[\trumpet].inFader.set(\mute, 0);
		["trumpet input muted"].postln;
		~ohm.turnRed(val).yield;

		~boySynth[\trumpet].inFader.set(\mute, 1);
		["trumpet input active"].postln;
		~ohm.turnPurple(val).yield;
	};
});


