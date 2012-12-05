/*
Tuesday, November 27th 2012
tremShift.scd
prm
*/

~birds[\tremShift] = {

	~birdsBus[\tremShift] = Bus.control;

	~birdsSynth[\tremShift] = Synth(\ctlLinLine, [\out, ~birdsBus[\tremShift], \start, 0, \end, -12.dbamp, \dur, 10],
		~group[\control], \addToTail);

	~birdsSynth[\tremgtr].fader.set(\amp, ~birdsBus[\tremShift].asMap);
};

~birdsMake[\tremShift] = r({ | val |
	loop {
		~ohm.turnPurple(val);
		~birds[\tremShift].value;
		{ ~ohm.turnRed(val)}.defer(5).yield;
	};
});