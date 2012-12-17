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

~birdsMake[\eqgtr] = r({
	loop {

		~birds[\eqgtr].value;
		~scLang.sendMsg(\control, \eqgtr);
		["eqgtr synths made"].postln.yield;


		~birds[\eqgtr].kill;
		~scLang.sendMsg(\control, \eqgtr);
		["eqgtr Synths freed"].postln.yield;
	}
});


~birdsMake[\eqgtrToggle] = r ({
	loop{
		~birdsSynth[\eqgtr].inFader.set(\mute, 0);
		~scLang.sendMsg(\control, \eqgtrToggle);
		["eqgtr input muted"].postln;


		~birdsSynth[\eqgtr].inFader.set(\mute, 1);
		~scLang.sendMsg(\control, \eqgtrToggle);
		["eqgtr input active"].postln;
	}
});




/*
   * gran
   * Distortion
   * Tons of Reverb (15s tail, 0.8 mix)
   * Hi-Cut (1970 Hz)
*/
