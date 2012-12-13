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

~boyMake[\trumpet] = r ({ | main |
	var val, toggle, majorThird, minorThird, offOne, offTwo, octave, vol;
	val = main.at(0);
	toggle = main.at(1);
	minorThird = main.at(2);
	majorThird = main.at(3);
	offOne = main.at(4);
	offTwo = main.at(5);
	octave = main.at(6);
	vol = main.at(7);

	loop {
		~boy[\trumpet].value;

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\trumpetToggle, { ~scLang.sendMsg(\boyTrumpet, \toggle, toggle); }, toggle);
		~ohm.turnBlue(minorThird);
		MIDIdef.noteOn(\trumpetMinor, { ~scLang.sendMsg(\boyTrumpet, \minorThird, minorThird); }, minorThird);
		~ohm.turnLavender(majorThird);
		MIDIdef.noteOn(\trumpetMajor, { ~scLang.sendMsg(\boyTrumpet, \majorThird, majorThird); }, majorThird);
		MIDIdef.noteOff(\noTrumpetShift, { ~scLang.sendMsg(\boyTrumpet, \unison, offOne, offTwo); }, [offOne, offTwo]);
		~ohm.turnBlue(octave);
		MIDIdef.noteOn(\trumpetOctave, { ~scLang.sendMsg(\boyTrumpet, \octave, octave); }, octave);
		MIDIdef.cc(\trumpetVolume, { | amp | ~scLang.sendMsg(\boyTrumpet, \volume, amp); }, vol);

		["trumpet synths on"].postln;
		~ohm.turnBlue(val).yield;

		~boy[\trumpet].kill;
		~ohm.turnOff(toggle);
		~ohm.turnOff(minorThird);
		~ohm.turnOff(majorThird);
		~ohm.turnOff(octave);
		MIDIdef(\trumpetOctave).free;
		MIDIdef(\trumpetMinor).free;
		MIDIdef(\trumpetMajor).free;
		MIDIdef(\noTrumpetShift).free;
		MIDIdef(\trumpetToggle).free;
		MIDIdef(\trumpetVolume).free;
		["trumpet synths off"].postln;
		~ohm.turnRed(val).yield;
	};
});

~boyMake[\trumpetToggle] = r({ | val |
	loop {

		~boySynth[\trumpet].inFader.set(\mute, 0);
		~boySynth[\trumpet].pitchShift.set(\amp, 0);
		["trumpet input muted"].postln;
		~ohm.turnRed(val).yield;

		~boySynth[\trumpet].inFader.set(\mute, 1);
		~boySynth[\trumpet].pitchShift.set(\amp, -5.dbamp);
		["trumpet input active"].postln;
		~ohm.turnPurple(val).yield;
	};
});

~boyMake[\trumpetOctaveToggle] = r({ | val |
	loop {
		~boySynth[\trumpet].pitchShift.set(\interval, 12);
		["octave pitch shifter"].postln;
		~ohm.turnYellow(val).yield;

		~boySynth[\trumpet].pitchShift.set(\interval, 0);
		["octave pitch shifter off"].postln;
		~ohm.turnRed(val).yield;
	};
});

