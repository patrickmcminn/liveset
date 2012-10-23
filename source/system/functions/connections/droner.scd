/*
Wednesday, October 12th 2012
droner.scd
prm
*/


~connections[\droner] = {
	~connectBus[\droner] = (
		\drone:   Bus.audio,
		\verb:    Bus.audio,
		\filter:  Bus.audio(s, 2),
		\rate:    Bus.control
	);

	~connectSynth[\droner] = (

		\rate:    Synth(\demandRand7, [\out, ~connectBus[\droner].rate, \freq, 12, \d1, 0.5, \d2, 0.5, \d3, 0.5,
			\d4, 0.5, \d5, 0.5, \d6, 0.25, \d7, 0.25],
			~group[\control], \addToTail),



		\inFader: Synth(\fader, [\in, ~inst[\mute], \out, ~connectBus[\droner].drone], ~group[\fx], \addToTail),



		\hiShelf: Synth(\hiShelf, [\in, ~connectBus[\droner].drone, \out, ~connectBus[\droner].drone, \freq, 2637,
			\gain, -3], ~group[\fx], \addToTail),


		\del:     Synth(\droneDelay, [\in, ~connectBus[\droner].drone, \out, ~connectBus[\droner].drone,
			\delayTime, 1.1305, \decayTime, 200, \mix, 1], ~group[\fx], \addToTail),



		\erosion: Synth(\erosion, [\in, ~connectBus[\droner].drone, \out, ~connectBus[\droner].drone, \freq, 500,
			\rangeLo, 0.002, \rangeHi, 0.009, \mix, 0.02], ~group[\fx], \addToTail),



		\gran:    Synth(\granulator,
			[
				\mix, 0, \in, ~connectBus[\droner].drone,
				\out, ~connectBus[\droner].verb,
				\bufLength, 5, \panOffset, 0.03, \grainDur, 0.13, \grainDurOffset, 0.1,
				\rate, ~connectBus[\droner].rate.asMap, \env, ~grainBufs[\gabor], \trigRate, 15, \amp, 3
		], ~group[\fx], \addToTail),



		\verb:    Synth(\convReverbStereo, [\in, ~connectBus[\droner].verb, \out, ~connectBus[\droner].filter,
			\buffer, ~impulse[\cathedral1], \mix, 0.6, \inputScale, 0.5], ~group[\fx], \addToTail),



		\loShelf: Synth(\lowShelfStereo, [\in, ~connectBus[\droner].filter, \out, ~connectBus[\droner].filter,
			\freq, 250, \gain, -6], ~group[\fx], \addToTail),



		\fader:   Synth(\stereoFader, [\in, ~connectBus[\droner].filter, \out, ~mixer[\s1], \amp, 0.6],
			~group[\fx], \addToTail)
	);


};

~connections[\droner].addUniqueMethod(\kill, {
	~connectBus[\droner].do({ | i | i.free; });
	~connectSynth[\droner].do({ | i | i.free; });
});


~connectMake[\droner] = r { | main |
	var val, toggle, erode, rater;
	val = main.at(0);
	toggle = main.at(1);
	erode = main.at(2);
	rater = main.at(3);
	loop {

		~connections[\droner].value;

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\dronerToggle, { ~scLang.sendMsg(\droner, \toggle, toggle) }, toggle);

		~ohm.turnYellow(erode);
		MIDIdef.noteOn(\dronerErode, { ~scLang.sendMsg(\droner, \erodeOn, erode)}, erode);
		MIDIdef.noteOff(\dronerErodeOff, { ~scLang.sendMsg(\droner, \erodeOff, erode) }, erode);

		~ohm.turnGreen(rater);
		MIDIdef.noteOn(\dronerRater, { ~scLang.sendMsg(\droner, \rater, rater)}, rater);

		MIDIdef.cc(\dronerGran, { | val |
			var mix = val.linlin(0, 127, 0, 1);
			~connectSynth[\droner].gran.set(\mix, mix);
		},17);

		"Droner Active".postln;
		~ohm.turnBlue(val).yield;



		MIDIdef.cc(\dronerGran).free;
		~ohm.turnOff(toggle);
		MIDIdef(\dronerToggle).free;
		~ohm.turnOff(erode);
		MIDIdef(\dronerErode).free;
		MIDIdef(\dronerErode).free;
		~ohm.turnOff(rater);
		MIDIdef(\dronerRater).free;
		~connections[\droner].kill;
		"Droner Freed".postln;
		~ohm.turnRed(val).yield;
	};
};

~connectMake[\dronerToggle] = r { | val |
	loop {
		~connectSynth[\droner].inFader.set(\mute, 0);
		["droner input muted"].postln;
		~ohm.turnRed(val).yield;

		~connectSynth[\droner].inFader.set(\mute, 1);
		["droner input active"].postln;
		~ohm.turnBlue(val).yield;
	};
};

~connectMake[\dronerRater] = r { | val |
	loop {
		~connectSynth[\droner].rate.set(\d1, 1, \d2, 1);
		["droner rates of 1 added"].postln;
		~ohm.turnPink(val).yield;

		~connectSynth[\droner].gran.set(\rate, 0.5);
		["droner rates to 0.5"].postln;
		~ohm.turnPurple(val).yield;

		~connectSynth[\droner].rate.set(\d1, 0.5, \d2, 0.5, \d3, 0.5, \d4, 0.5, \d5, 0.5, \d6, 0.25, \d7, 0.25);
		~connectSynth[\droner].gran.set(\rate, ~connectBus[\droner].rate.asMap);
		~ohm.turnGreen(val).yield;
	}
};







/*
(
droner = {
	~droneBus = (
		\drone:		Bus.audio,
		\verb:		Bus.audio(s, 2),
		\filter:		Bus.audio(s, 2),
		\rate:		Bus.control);
	~drone = (
		\rate:		Synth(\demandRand7, [\out, ~droneBus.at(\rate), \freq, 12, \d1, 0.5,
						\d2, 0.5, \d3, 0.5, \d4, 0.5, \d5, 0.5, \d6, 0.25, \d7, 0.25],
						~controlGroup, \addToTail),
		\inFader:		Synth(\fader, [\in, ~muteBus, \out, ~droneBus.at(\drone)], ~fx, \addToTail),
		\hiShelf:		Synth(\hiShelf, [\in, ~droneBus.at(\drone), \out, ~droneBus.at(\drone), 						\freq, 2637, \gain, -3], ~fx, \addToTail),
		\del:		Synth(\droneDelay, [\in, ~droneBus.at(\drone), \out, ~droneBus.at(\drone),
						\delayTime, 1.1305, \decayTime, 200, \mix, 1], ~fx, \addToTail),
		\erosion:		Synth(\erosion, [\in, ~droneBus.at(\drone), \out, ~droneBus.at(\drone), 						\freq, 500, \rangeLo, 0.002,\rangeHi, 0.009, \mix, 0.02],
						~fx, \addToTail),
		\gran:		Synth(\granulator, [
						\mix,			0,
						\in, 			~droneBus.at(\drone),
						\out,			~droneBus.at(\verb),
						\bufLength,		5,
						\panOffset,		0.03,
						\grainDur, 		0.13,
						\grainDurOffset,	0.1,
						\rate,			~droneBus.at(\rate).asMap,
						\env,			~grainBufs.at(\gabor),
						\trigRate,		15,
						\amp,			3],
						~fx, \addToTail),
		\verb:		Synth(\convReverbStereo, [\in, ~droneBus.at(\verb), \out,
						~droneBus.at(\filter), \buffer, ~cathedralOne, \mix, 0.6,
							\inputScale, 0.5], ~fx, \addToTail),
		\loShelf:		Synth(\lowShelfStereo, [\in, ~droneBus.at(\filter),
						\out, ~droneBus.at(\filter), \freq, 250, \gain, -6], ~fx, \addToTail),
		\fader:		Synth(\stereoFader, [\in, ~droneBus.at(\filter), \out, ~outBusOne,
						\amp, 0.6],~fx, \addToTail));
};
~dronerFree = { ~droneBus.do({ | i | i.free }); ~drone.do({ | i | i.free }); };
);

*/