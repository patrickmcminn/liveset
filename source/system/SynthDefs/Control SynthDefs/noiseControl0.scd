/*
Monday, October 8th
noiseControl0.scd
prm
control-rate noise signal
*/


SynthDef(\noiseControl0, {	// control SynthDef using LFNoise0 (no interpolation btwn. values)
	| out, freq = 1, rangeLo = 0, rangeHi = 1 |
	var sig;
	sig = LFNoise0.kr(freq).range(rangeLo, rangeHi);
	sig = ReplaceOut.kr(out, sig);
}).add;

"noiseControl0 Synth Added".postln;
"     args: out, freq = 1, rangeLo = 0, rangeHi = 1".postln;