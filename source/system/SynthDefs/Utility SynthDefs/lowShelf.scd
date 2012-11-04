/*
Monday, October 8th
lowShelf.scd
prm
low-shelf EQ filter
*/


SynthDef(\lowShelf, {
	| in, out, freq = 110, rs = 1, gain = 0 |
	var input, filter, sig;
	input = In.ar(in);
	filter = BLowShelf.ar(input, freq, rs, gain);
	sig = filter.softclip;
	sig = ReplaceOut.ar(out, sig);
}).add;

"lowShelf SynthDef Added".postln;
"     args: in, out, freq = 110, rs = 1, gain = 0".postln;
"".postln;
