/*
Monday, October 8th
hiShelf.scd
prm
*/

SynthDef(\hiShelf, {
	| in, out, freq = 2500, rs = 1, gain = 0 |
	var input, filter, sig;
	input = In.ar(in);
	filter = BHiShelf.ar(input, freq, rs, gain);
	sig = filter.softclip;
	sig = ReplaceOut.ar(out, sig);
}).add;

"hiShelf SynthDef Added".postln;
"     args: in, out, freq = 2500, rs = 1, gain = 0".postln;