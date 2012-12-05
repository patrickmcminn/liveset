/*
Monday, October 8th 2012
lowShelfStereo.scd
prm
*/

SynthDef(\lowShelfStereo, {
	| in, out, freq = 110, rs = 1, gain = 0 |
	var input, filter, sig;
	input = In.ar(in, 2);
	filter = BLowShelf.ar(input, freq, rs, gain);
	sig = filter.softclip;
	sig = Out.ar(out, sig);
}).add;


"lowShelfStereo SynthDef Added".postln;
"     args: in, out, freq = 110, rs = 1, gain = 0".postln;