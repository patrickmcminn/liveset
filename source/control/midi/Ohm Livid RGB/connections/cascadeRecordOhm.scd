/*
Tuesday October 16th
cascadeRecord.scd
prm
*/

~connections[\cascadeRecord] = Routine ({ | val |

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\cascade].at(0)],
		~group[\fx], \addToTail);
	["high E recorded"].postln;
	~ohm.turnLavender(val).yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\cascade].at(1)],
		~group[\fx], \addToTail);
	["Low C# Recorded"].postln;
	~ohm.turnPurple(val).yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\cascade].at(2)],
		~group[\fx], \addToTail);
	["High F# Recorded"].postln;
	~ohm.turnYellow(val).yield;
});

~connections[\cascadeRecord].addUniqueMethod(\reset, {
	~connecBuf[\cascade].do({ | i | i.zero });
	~connections[\cascadeRecord].reset;
});

~connectMake[\cascadeRecord] = r { | val |
	loop {
		~connections[\cascadeRecord].value(val).postln.yield;
	};
};