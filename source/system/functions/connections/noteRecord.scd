/*
Saturday, October 13th 2012
noteRecord.scd
prm
*/

~connections[\noteRecord] = Routine({

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\note].at(0)],
		~group[\fx], \addToTail);
	["C# Recorded"].postln.yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\note].at(1)],
		~group[\fx], \addToTail);
	["G# Recorded"].postln.yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\note].at(2)],
		~group[\fx], \addToTail);
	["F# Recorded"].postln.yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\note].at(3)],
		~group[\fx], \addToTail);
	["A Recorded"].postln.yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\note].at(4)],
		~group[\fx], \addToTail);
	["B Recorded"].postln.yield;

	loop {
		["all notes recorded"].postln.yield;
	};
});

~connections[\noteRecord].addUniqueMethod(\reset, {
	~connectBuf[\note].do({ | i | i.zero; });
	~connections[\noteRecord].reset;
	["note buffers reset"].postln;
});

~connectMake[\noteRecord] = Routine({
	loop {
		~scLang.sendMsg(\control, \noteRecord);
		~connections[\noteRecord].value.yield;
	};
});

