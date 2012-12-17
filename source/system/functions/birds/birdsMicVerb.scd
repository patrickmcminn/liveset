/*
Friday, November 2nd 2012
birdsMicVerb.scd
prm
*/


~birds[\birdsMicVerb] = {

	~birdsBus[\birdsMicVerb] = (
		\verb: Bus.audio,
		\fader: Bus.audio
	);

	~birdsSynth[\birdsMicVerb] = (


		\inFader: Synth(\fader, [\in, ~inst[\mic], \out, ~birdsBus[\birdsMicVerb].verb], ~group[\fx], \addToTail),


		\verb: Synth(\convReverb, [\in, ~birdsBus[\birdsMicVerb].verb, \out, ~birdsBus[\birdsMicVerb].fader,
			\buffer, ~impulse[\cathedral1], \mix, 0.6], ~group[\fx], \addToTail),

		\fader: Synth(\pan, [\in, ~birdsBus[\birdsMicVerb].fader, \out, ~mixer[\s2]], ~group[\fx], \addToTail)
	);

};

~birds[\birdsMicVerb].addUniqueMethod(\kill, {
	~birdsBus[\birdsMicVerb].do({ | i | i.free });
	~birdsSynth[\birdsMicVerb].do({ | i | i.free });
});

~birdsMake[\birdsMicVerb] = r ({
	loop {
		~birds[\birdsMicVerb].value;
		~scLang.sendMsg(\control, \birdsMicVerb);
		["mic verb synths active"].postln.yield;

		~birds[\birdsMicVerb].kill;
		~scLang.sendMsg(\control, \birdsMicVerb);
		["mic verb synths freed"].postln.yield;
	}
});

~birdsMake[\birdsMicVerbToggle] = r ({
	loop {
		~birdsSynth[\birdsMicVerb].inFader.set(\mute, 0);
		~scLang.sendMsg(\control, \birdsMicVerbToggle);
		["mic verb input muted"].postln.yield;

		~birdsSynth[\birdsMicVerb].inFader.set(\mute, 1);
		~scLang.sendMsg(\control, \birdsMicVerbToggle);
		["mic verb input active"].postln.yield;

	}
});

