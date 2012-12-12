/*
Tuesday October 16th
cascadeRecord.scd
prm
*/

~connections[\cascadeRecord] = Routine ({

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\cascade].at(0)],
		~group[\fx], \addToTail);
	["high E recorded"].postln.yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\cascade].at(1)],
		~group[\fx], \addToTail);
	["Low C# Recorded"].postln.yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\cascade].at(2)],
		~group[\fx], \addToTail);
	["High F# Recorded"].postln.yield;
});

~connections[\cascadeRecord].addUniqueMethod(\reset, {
	~connecBuf[\cascade].do({ | i | i.zero });
	~connections[\cascadeRecord].reset;
});

~connectMake[\cascadeRecord] = r {
	loop {
		~scLang.sendMsg(\control, \cascadeRecord);
		~connections[\cascadeRecord].value.postln.yield;
	};
};