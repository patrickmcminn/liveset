/*
Saturday, October 13th 2012
noteRecord.scd
prm
*/

~connections[\noteRecord] = Routine({ | val |

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\note].at(0)],
		~group[\fx], \addToTail);
	["C# Recorded"].postln;
	~ohm.turnLavender(val).yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\note].at(1)],
		~group[\fx], \addToTail);
	["G# Recorded"].postln;
	~ohm.turnPurple(val).yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\note].at(2)],
		~group[\fx], \addToTail);
	["F# Recorded"].postln;
	~ohm.turnYellow(val).yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\note].at(3)],
		~group[\fx], \addToTail);
	["A Recorded"].postln;
	~ohm.turnPink(val).yield;

	Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\note].at(4)],
		~group[\fx], \addToTail);
	["B Recorded"].postln;
	~ohm.turnBlue(val).yield;
});

~connections[\noteRecord].addUniqueMethod(\reset, { | func, val |
	~connectBuf[\note].do({ | i | i.zero; });
	~connections[\noteRecord].reset;
	~ohm.turnGreen(val);
});

~connectMake[\noteRecord] = Routine({ | val |
	loop {
		~connections[\noteRecord].value(val).yield;
	};
});




/*
(
~nBRecord = Routine({

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~noteBuffers.at(0)], ~fx, \addToTail);
		["C# recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~noteBuffers.at(1)], ~fx, \addToTail);
		["G# recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~noteBuffers.at(2)], ~fx, \addToTail);
		["F# recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~noteBuffers.at(3)], ~fx, \addToTail);
		["A recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~noteBuffers.at(4)], ~fx, \addToTail);
		["B recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~cascadeBuffers.at(0)], ~fx, \addToTail);
		["high E recorded (cascade)"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~cascadeBuffers.at(1)], ~fx, \addToTail);
		["low C# recorded (cascade)"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~cascadeBuffers.at(2)], ~fx, \addToTail);
		["high F# recorded (cascade)"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~chordBuffers.at(0)], ~fx, \addToTail);
		["chord-part F# recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~chordBuffers.at(1)], ~fx, \addToTail);
		["chord-part A recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~chordBuffers.at(2)], ~fx, \addToTail);
		["chord-part C# recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~chordBuffers.at(3)], ~fx, \addToTail);
		["chord-part B recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~chordBuffers.at(4)], ~fx, \addToTail);
		["chord-part G# recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~chordBuffers.at(5)], ~fx, \addToTail);
		["chord-part E recorded"].yield;

	});
);
*/
