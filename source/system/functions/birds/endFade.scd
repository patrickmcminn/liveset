/*
Monday, December 3rd 2012
endFade.scd
prm
*/

~birdsMake[\endFade] = r({ | val |
	var time = 45;
	loop {
		~ohm.turnBlue(val);
		~birdsBus[\endFade] = Bus.control;
		~birdsSynth[\endFade] = Synth(\ctlLinLine, [\out, ~birdsBus[\endFade], \start, -12.dbamp, \end, 0, \dur, time],
			~group[\control], \addToTail);
		~birdsSynth[\noiseSynth].fader.set(\amp, ~birdsBus[\endFade].asMap);

		{
			~birds[\noiseSynth].kill;
			~birds[\wobble].kill;
			~birds[\birdsMicVerb].kill;
		}.defer(time).yield;
	};
});