/*
Monday, October 8th 2012
hiShelfStereo.scd
prm
*/

SynthDef(\hiShelfStereo, {
	| in, out, freq = 2500, rs = 1, gain = 0 |
	var input, filter, sig;
	input = In.ar(in, 2);
	filter = BHiShelf.ar(input, freq, rs, gain);
	sig = filter.softclip;
	sig = ReplaceOut.ar(out, sig);
}).add;

"hiShelfStereo SynthDef Added".postln;
"     args: in, out, freq = 2500, rs = 1, gain = 0".postln;