/*
Thursday, November 1st 2012
tremgtr.scd
prm
*/

~birds[\tremgtr] = {

	~birdsBus[\tremgtr] = (
		\verb: Bus.audio,
		\dist: Bus.audio,
		\eq: Bus.audio,
		\trem: Bus.audio,
		\verb2: Bus.audio,
		\fader: Bus.audio
	);

	~birdsSynth[\tremgtr] = (

		\inFader: Synth(\fader, [\in, ~inst[\guitar], \out, ~birdsBus[\tremgtr].verb, \amp, 1],
			~group[\fx], \addToTail),

		\verb: Synth(\reverb1, [\in, ~birdsBus[\tremgtr].verb, \out, ~birdsBus[\tremgtr].dist,
			\mix, 0.95, \room, 0.9, \damp, 0.1, \amp, 1], ~group[\fx], \addToTail),

		\dist: Synth(\digitalClip2, [\in, ~birdsBus[\tremgtr].dist, \out, ~birdsBus[\tremgtr].eq,
			\amount, 500, \amp, 0.2], ~group[\fx], \addToTail),

		\eq: Synth(\eq3, [\in, ~birdsBus[\tremgtr].eq, \out, ~birdsBus[\tremgtr].trem,
			\loFreq, 250, \loGain, 5, \hiFreq, 3500, \hiGain, -7.65], ~group[\fx], \addToTail),

		\trem: Synth(\multiTrem, [\in, ~birdsBus[\tremgtr].trem, \out, ~birdsBus[\tremgtr].verb2,
			\tremOneFreq, 0.25, \tremTwoFreq, 1.3333, \tremThreeFreq, 1.5, \tremFourFreq, 4],
			~group[\fx], \addToTail),

		\verb2: Synth(\convReverb, [\in, ~birdsBus[\tremgtr].verb2, \out, ~birdsBus[\tremgtr].fader,
			\buffer, ~impulse[\chamberMedium], \mix, 0.1], ~group[\fx], \addToTail),

		\fader: Synth(\pan, [\in, ~birdsBus[\tremgtr].fader, \out, ~mixer[\s2], \amp, 0],
			~group[\fx], \addToTail)
	);
};

~birds[\tremgtr].addUniqueMethod(\kill, {
	~birdsBus[\tremgtr].do({ | i | i.free; });
	~birdsSynth[\tremgtr].do({ | i | i.free; });
});

~birdsMake[\tremgtr] = r ({
	loop {
		~birds[\tremgtr].value;
		~scLang.sendMsg(\control, \tremgtr);
		["tremgtr active"].postln.yield;

		~birds[\tremgtr].kill;
		~scLang.sendMsg(\control, \tremgtrToggle);
		["tremgtr synths freed"].postln.yield;
	};

});

~birdsMake[\tremgtrToggle] = r ({
	loop {
		~birdsSynth[\tremgtr].inFader.set(\mute, 0);
		~scLang.sendMsg(\control, \tremgtrToggle);
		["input to tremgtr muted"].postln.yield;

		~birdsSynth[\tremgtr].inFader.set(\mute, 1);
		~scLang.sendMsg(\control, \tremgtrToggle);
		["input to tremgtr active"].postln.yield;
	};
});



/*

   * verb
      * mix - 0.68
      * decay time - 6 seconds
   * distortion
   * tremolo
      * 1n
      * 8nd
      * 4nt
      * 16n
   * EQ 3
      * low
         * 250 Hz
         * 5 db boost
      * hi

         * 2500 Hz
         * 7.65 db cut
   * verb

      * mix - 0.5
      * decay time - 4 seconds
*/