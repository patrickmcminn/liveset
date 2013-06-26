/*
Friday, March 15th 2013
highPassFilter.scd
prm
*/

SynthDef(\highPassFilter, {
	| in, out, cutoff = 500, amp = 1 |
	var input, filter, sig;
	input = In.ar(in);
	filter = HPF.ar(input, cutoff);
	sig = filter * amp;
	sig = ReplaceOut.ar(out, sig);
}).add;

"highPassFilter SynthDef Added".postln;
"      args: in, out, cutoff = 1000, amp = 1".postln;