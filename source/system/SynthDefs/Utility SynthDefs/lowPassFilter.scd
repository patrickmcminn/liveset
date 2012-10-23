/*
Monday, October 8th 2012
lowPassFilter.scd
prm
*/

SynthDef(\lowPassFilter, {
	| in, out, cutoff = 1000, amp = 1 |
	var input, filter, sig;
	input = In.ar(in);
	filter = LPF.ar(input, cutoff);
	sig = filter * amp;
	sig = ReplaceOut.ar(out, sig);
}).add;

"lowPassFilter SynthDef Added".postln;
"      args: in, out, cutoff = 1000, amp = 1".postln;