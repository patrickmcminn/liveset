/*
Tuesday, November 27th 2012
distShift.scd
prm
*/

~birds[\distShift] = {

	~birdsBus[\distShift] = (
		\dist: Bus.control,
		\amp: Bus.control,
		\cutoff: Bus.control
	);

	~birdsSynth[\distShift] = (

		\dist: Synth(\ctlExpLine, [\out, ~birdsBus[\distShift].dist, \start, 1, \end, 10000, \dur, 5],
			~group[\control], \addToTail),

		\amp: Synth(\ctlExpLine, [\out, ~birdBus[\distShift].amp, \start, 1, \end, 0.07, \dur, 5],
			~group[\control], \addToTail),

		\cutoff: Synth(\ctlExpLine, [\out, ~birdBus[\distShift].cutoff, \start, 12000, \end, 18000, \dur, 5],
			~group[\control], \addToTail)
	);

	~birdsSynth[\eqgtr].eq.set(\hiFreq, ~birdsBus[\distShift].at(\cutoff).asMap);
	~birdsSynth[\eqgtr].dist.set(\amount, ~birdsBus[\distShift].at(\dist).asMap, \amp, ~birdsBus[\distShift].at(\amp).asMap);

};

~birdsMake[\distShift] = r ({ | val |
	loop{
		~ohm.turnYellow(val);
		~birdsSynth[\distShift].value;
		["distortion increasing on eqgtr over 5 seconds"].postln;
		{ ~ohm.turnRed(val) }.defer(5).yield;
	};
});