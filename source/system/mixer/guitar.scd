/*
November 1st, 2012
guitar.scd
prm
creates Synths for inital guitar processing and EQing
*/


~instI[\guitar] = Synth(\eq3,
	[
		\in, ~inst[\guitarInit], \out, ~inst[\guitar],
		\loFreq, 300, \loGain, 6,
		\hiFreq, 1000, \hiGain, 6,
		\amp, 0.8
	],
	~group[\input], \addToTail
);
