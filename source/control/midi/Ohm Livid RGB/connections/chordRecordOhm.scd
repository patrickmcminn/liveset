/*
Tuesday, October 16th 2012
chordRecord.scd
prm
*/

~connections[\chordRecord] = Routine({ | val |
	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(0)],
		~group[\fx], \addToTail);
	["F# recorded"].postln;
	~ohm.turnLavender(val).yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(1)],
		~group[\fx], \addToTail);
	["A recorded"].postln;
	~ohm.turnPurple(val).yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(2)],
		~group[\fx], \addToTail);
	["C# recorded"].postln;
	~ohm.turnYellow(val).yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(3)],
		~group[\fx], \addToTail);
	["B recorded"].postln;
	~ohm.turnPink(val).yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(4)],
		~group[\fx], \addToTail);
	["G# recorded"].postln;
	~ohm.turnGreen(val).yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(5)],
		~group[\fx], \addToTail);
	["E recorded"].postln;
	~ohm.turnBlue(val).yield;
});

~connections[\chordRecord].addUniqueMethod(\reset, {
	~connectBuf[\chord].do({ | i | i.zero; });
	~connections[\chordRecord].reset;
});

~connectMake[\chordRecord] = r { | val |
	loop {
		~connections[\chordRecord].value(val).postln.yield;
	};
};
