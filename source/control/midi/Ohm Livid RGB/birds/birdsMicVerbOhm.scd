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

~birdsMake[\birdsMicVerb] = r ({ | main |

	var val, toggle, vol;
	val = main.at(0);
	toggle = main.at(1);
	vol = main.at(2);

	loop {

		~birds[\birdsMicVerb].value;

		~ohm.turnBlue(toggle);
		MIDIdef.noteOn(\birdsMicVerbToggle, { ~scLang.sendMsg(\birdsMicVerb, \toggle, toggle); }, toggle);
		MIDIdef.cc(\birdsMicVerbVolume, { | amp | ~scLang.sendMsg(\birdsMicVerb, \volume, amp); }, vol);

		["mic verb synths active"].postln;
		~ohm.turnPurple(val).yield;


		~birds[\birdsMicVerb].kill;
		~ohm.turnOff(toggle);
		MIDIdef(\birdsMicVerbToggle).free;
		MIDIdef(\birdsMicVerbVolume).free;
		["mic verb synths freed"].postln;
		~ohm.turnRed(val).yield;

	}
});

~birdsMake[\birdsMicVerbToggle] = r ({ | val |
	loop {

		~birdsSynth[\birdsMicVerb].inFader.set(\mute, 0);
		["mic verb input muted"].postln;
		~ohm.turnRed(val).yield;

		~birdsSynth[\birdsMicVerb].inFader.set(\mute, 1);
		["mic verb input active"].postln;
		~ohm.turnBlue(val).yield;

	}
});

