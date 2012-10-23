/*
Monday October 8th 2012
lfSin.scd
prm
control-rate sine oscillator
*/

SynthDef(\lfSin, {	// low-frequency control Sine Oscillator
	| out, freq = 1, rangeLo = 0, rangeHi = 1 |
	var sig;
	sig = SinOsc.kr(freq).range(rangeLo, rangeHi);
	sig = ReplaceOut.kr(out, sig);
}).add;

"lfSin SynthDef added".postln;
"     args: out, freq = 1, rangeLo = 0, rangeHi = 1".postln;