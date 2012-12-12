/*
Tuesday, October 16th 2012
edited 12/12/2012
-reflects control surface changes
chordRecord.scd
prm
*/

~connections[\chordRecord] = Routine({ | val |
	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(0)],
		~group[\fx], \addToTail);
	["F# recorded"].postln.yield;


	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(1)],
		~group[\fx], \addToTail);
	["A recorded"].postln.yield;


	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(2)],
		~group[\fx], \addToTail);
	["C# recorded"].postln.yield;


	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(3)],
		~group[\fx], \addToTail);
	["B recorded"].postln.yield;


	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(4)],
		~group[\fx], \addToTail);
	["G# recorded"].postln.yield;


	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\chord].at(5)],
		~group[\fx], \addToTail);
	["E recorded"].postln.yield;

});

~connections[\chordRecord].addUniqueMethod(\reset, {
	~connectBuf[\chord].do({ | i | i.zero; });
	~connections[\chordRecord].reset;
});

~connectMake[\chordRecord] = r { | val |
	loop {
		~scLang.sendMsg(\control, \chordRecord);
		~connections[\chordRecord].value.postln.yield;
	};
};
