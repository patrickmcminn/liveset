/*
Thursday, November 1st 2012
eqgtr.scd
prm
*/

~birds[\eqgtr] = {

	~birdsBus[\eqgtr] = (
		\dist: Bus.audio,
		\verb: Bus.audio,
		\eq: Bus.audio,
		\fader: Bus.audio
	);

	~birdsSynth[\eqgtr] = (

		\inFader: Synth(\fader, [\in, ~inst[\guitar], \out, ~birdsBus[\eqgtr].dist, \amp, 1], ~group[\fx], \addToTail),

		\dist: Synth(\digitalClip2, [\in, ~birdsBus[\eqgtr].dist, \out, ~birdsBus[\eqgtr].verb,
			\amount, 1, \amp, 1], ~group[\fx], \addToTail),

		\verb: Synth(\convReverb, [\in, ~birdsBus[\eqgtr].verb, \out, ~birdsBus[\eqgtr].eq,
			\buffer, ~impulse[\cathedral1], \mix, 0.8], ~group[\fx], \addToTail),

		\eq: Synth(\eq3, [\in, ~birdsBus[\eqgtr].eq, \out, ~birdsBus[\eqgtr].fader,
			\freqHi, 12000, \hiGain, -40], ~group[\fx], \addToTail),

		\fader: Synth(\pan, [\in, ~birdsBus[\eqgtr].fader, \out, ~mixer[\s1], \amp, 0.8], ~group[\fx], \addToTail)
	);

};

~birds[\eqgtr].addUniqueMethod(\kill, {
	~birdsBus[\eqgtr].do({ | i | i.free; });
	~birdsSynth[\eqgtr].do({ | i | i.free; });
});

~birdsMake[\eqgtr] = r({ | main|

	var val, toggle, shift, vol;
	val = main.at(0);
	toggle = main.at(1);
	shift = main.at(2);
	vol = main.at(3);

	loop {

		~birds[\eqgtr].value;

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\eqgtrToggle, { ~scLang.sendMsg(\eqgtr, \toggle, toggle) }, toggle);
		MIDIdef.cc(\eqgtrVolume, { | amp | ~scLang.sendMsg(\eqgtr, \volume, amp) }, vol);

		~ohm.turnBlue(shift);
		MIDIdef.noteOn(\eqgtrShift, { ~scLang.sendMsg(\eqgtr, \shift, shift) }, shift);

		["eqgtr synths made"].postln;
		~ohm.turnBlue(val).yield;


		~ohm.turnOff(toggle);
		~ohm.turnOff(shift);
		MIDIdef(\eqgtrToggle).free;
		MIDIdef(\eqgtrShift).free;
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
