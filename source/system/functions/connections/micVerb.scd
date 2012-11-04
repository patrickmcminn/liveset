/*
Wednesday, October 10th 2012
micVerb.scd
prm
*/


~connections[\micVerb] = {

	~connectBus[\micVerb] = (
		\rate: Bus.control,
		\inVerb: Bus.audio,
		\gran: Bus.audio,
		\verb: Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);

	~connectSynth[\micVerb] = (

		\rate: Synth(\demandRand7, [\out, ~connectBus[\micVerb].rate, \freq, 17, \d1, 0.5, \d2, 0.5,
			\d3, 0.5, \d4, 0.5, \d5, 1, \d6, 1, \d7, 1], ~group[\control], \addToTail),

		\inFader: Synth(\fader, [\in, ~inst[\mic], \out, ~connectBus[\micVerb].inVerb], ~group[\fx], \addToTail),

		\verb: Synth(\reverb1, [\in, ~connectBus[\micVerb].inVerb, \out, ~connectBus[\micVerb].gran,
			\room, 0.9, \damp, 0.2, \mix, 0.6, \amp, 0.8], ~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~connectBus[\micVerb].gran, \out, ~connectBus[\micVerb].verb,
				\mix, 0.2, \bufLength, 3, \pan, 0.15, \panOffset, 0.3,
				\env, ~grainBufs[\rexpodec], \rate, ~connectBus[\micVerb].rate.asMap,
				\grainDur, 0.2, \grainDurOffset, 0.05, \trigRate, 35, \sync, 0.5
			],
			~group[\fx], \addToTail),

		\verb2: Synth(\convReverbStereo, [\in, ~connectBus[\micVerb].verb, \out, ~connectBus[\micVerb].fader,
			\buffer, ~impulse[\cathedral2], \mix, 0.3], ~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~connectBus[\micVerb].fader, \out, ~mixer[\s3]], ~group[\fx], \addToTail)
	);

};

~connections[\micVerb].addUniqueMethod(\kill, {
	~connectBus[\micVerb].do({ | i | i.free });
	~connectSynth[\micVerb].do({ | i | i.free });
});

~connectMake[\micVerb] = r { | main |
	var val, toggle, vol, mix;
	val = main.at(0);
	toggle = main.at(1);
	vol = main.at(2);
	mix = main.at(3);
	loop{
		~connections[\micVerb].value;
		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\micVerbToggle, { ~scLang.sendMsg(\micVerb, \toggle, toggle) }, toggle);
		MIDIdef.cc(\micVerbVolume, { | amp | ~scLang.sendMsg(\micVerb, \volume, amp) }, vol);
		MIDIdef.cc(\micVerbGran, { | mix | ~scLang.sendMsg(\micVerb, \gran, mix) }, mix);
		"Mic Verb Active".postln;
		~ohm.turnBlue(val).yield;

		~connections[\micVerb].kill;
		~ohm.turnOff(toggle);
		MIDIdef(\micVerbVolume).free;
		MIDIdef(\micVerbToggle).free;
		MIDIdef(\micVerbGran).free;
		"Mic Verb Freed".postln;
		~ohm.turnRed(val).yield;
	};
};

~connectMake[\micVerbToggle] = r { | val |
	loop{
		~connectSynth[\micVerb].inFader.set(\mute, 0);
		["input for mic verb muted"].postln;
		~ohm.turnRed(val).yield;

		~connectSynth[\micVerb].inFader.set(\mute, 1);
		["input for mic verb active"].postln;
		~ohm.turnBlue(val).yield;
	};
};


/*
(
~micEnd = {
	~micEndBus = (
		\rate:	Bus.control,
		\inVerb:	Bus.audio,
		\gran:	Bus.audio,
		\verb:	Bus.audio,
		\fader:	Bus.audio);
	~mics = (
		\rate:	Synth(\demandRand7, [\out, ~micEndBus.at(\rate), \freq, \17, \d1, 0.5, \d2, 0.5,
					\d3, 0.5, \d4, 0.5, \d5, 1, \d6, 1, \d7, 1], ~controlGroup, \addToTail),
		\inFader:	Synth(\fader, [\in, ~micBus, \out, ~micEndBus.at(\inVerb)], ~fx, \addToTail),
		\verb1:	Synth(\reverb1, [\in, ~micEndBus.at(\inVerb), \out, ~micEndBus.at(\gran),
					\room, 0.9, \damp, 0.2, \mix, 0.6, \amp, 0.8], ~fx, \addToTail),
		\gran:	Synth(\granulator, [\in, ~micEndBus.at(\gran), \out, ~micEndBus.at(\verb),
					\mix, 0.2, \bufLength, 3, \pan, 0.15, \panOffset, 0.3,
					\env, ~grainBufs.at(\rexpodec), \rate, ~micEndBus.at(\rate).asMap,
					\grainDur, 0.2, \grainDurOffset, 0.05, \trigRate, 35, \sync, 0.5],
					~fx, \addToTail),
		\verb2:	Synth(\convReverbStereo, [\in, ~micEndBus.at(\verb), \out, ~micEndBus.at(\fader),
					\buffer, ~cathedralTwo, \mix, 0.3], ~fx, \addToTail),
		\fader:	Synth(\stereoFader, [\in, ~micEndBus.at(\fader), \out, ~outBusThree],
					~fx, \addToTail));
};

~micEndFree = { ~micEndBus.do({ | i | i.free }); ~mics.do({ | i | i.free }); };
);
*/