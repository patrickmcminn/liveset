/*
Monday, September 2nd 2013
rlpf.scd
prm
*/

SynthDef(\rlpf, {
	| in, out, cutoff = 1000, res = 1, amp = 1 |
	var input, filter, sig;
	input = In.ar(in);
	filter = RLPF.ar(input, cutoff, res);
	sig = filter * amp;
	sig = ReplaceOut.ar(out, sig);
}).add;

SynthDef(\rlpfStereo, {
	| in, out, cutoff = 1000, res = 1, amp = 1 |
	var input, filter, sig;
	input = In.ar(in, 2);
	filter = RLPF.ar(input, cutoff, res);
	sig = filter * amp;
	sig = ReplaceOut.ar(out, sig);
}).add;
