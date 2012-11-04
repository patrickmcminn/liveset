/*
Thursday, November 1st 2012
eqgtr.scd
prm
*/

~birds[\eqgtr] = {

	~birdsBus[\eqgtr] = (
		\gran: Bus.audio,
		\dist: Bus.audio(s, 2),
		\verb: Bus.audio(s, 2),
		\eq: Bus.audio(s, 2),
		\fader: Bus.audio(s, 2)
	);

	~birdsSynth[\eqgtr] = (

		\inFader: Synth(\fader, [\in, ~inst[\guitar], \out, ~birdsBus[\eqgtr].gran, \amp, 1], ~group[\fx], \addToTail),

		\gran: Synth(\granulator,
			[
				\in, ~birdsBus[\eqgtr].gran, \out, ~birdsBus[\eqgtr].dist
			],
			~fx[\group], \addToTail),

		\dist: Synth(\digitalClip2Stereo, [\in, ~birdsBus[\eqgtr].dist, \out, ~birdsBus[\eqgtr].verb,
			\amount, 1, \amp, 1], ~group[\fx], \addToTail),

		\verb: Synth(\convReverbStereo, [\in, ~birdsBus[\eqgtr].verb, \out, ~birdsBus[\eqgtr].eq,
			\buffer, ~impulse[\cathedral2], \mix, 0.8], ~group[\fx], \addToTail),

		\eq: Synth(\eq3Stereo, [\in, ~birdsBus[\eqgtr].eq, \out, ~birdsBus[\eqgtr].fader,
			\freqHi, 1970, \hiGain, -70], ~group[\fx], \addToTail),

		\fader: Synth(\stereoFader, [\in, ~birdsBus[\eqgtr].fader, \out, ~mixer[\s1], \amp, 0.8], ~group[\fx], \addToTail)
	);

};

~birds[\eqgtr].addUniqueMethod(\kill, {
	~birdsBus[\eqgtr].do({ | i | i.free; });
	~birdsSynth[\eqgtr].do({ | i | i.free; });
});

~birdsMake[\eqgtr] = r({ | main|

	var val, toggle, vol;
	val = main.at(0);
	toggle = main.at(1);
	vol = main.at(2);

	loop {

		~birds[\eqgtr].value;

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\eqgtrToggle, { ~scLang.sendMsg(\eqgtr, \toggle, toggle) }, toggle);
		MIDIdef.cc(\eqgtrVolume, { | amp | ~scLang.sendMsg(\eqgtr, \volume, amp) }, vol);

		["eqgtr synths made"].postln;
		~ohm.turnBlue(val).yield;


		~ohm.turnOff(toggle);
		MIDIdef(\eqgtrToggle).free;
		MIDIdef(\eqgtrVolume).free;
		~birds[\eqgtr].kill;
		["eqgtr Synths freed"].postln;
		~ohm.turnRed(val).yield;
	}
});


~birdsMake[\eqgtrToggle] = r ({ | val |
	loop{
		~birdsSynth[\eqgtr].inFader.set(\mute, 0);
		["eqgtr input muted"].postln;
		~ohm.turnRed(val).yield;

		~birdsSynth[\eqgtr].inFader.set(\mute, 1);
		["eqgtr input active"].postln;
		~ohm.turnYellow(val).yield;
	}
});




/*
   * gran
   * Distortion
   * Tons of Reverb (15s tail, 0.8 mix)
   * Hi-Cut (1970 Hz)
*/
