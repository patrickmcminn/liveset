/*
Saturday, June 22nd 2013
moogLadder.scd
prm
*/

SynthDef(\moogLadder, {
	| in, out, amp = 1, cutoff = 10000, res = 0.1 |
	var input, filter, sig;
	input = In.ar(in);
	filter = MoogLadder.ar(input, cutoff, res);
	sig = filter * amp;
	sig = Out.ar(out, sig);
}).add;

SynthDef(\moogLadderStereo, {
	| in, out, amp = 1, cutoff = 10000, res = 0.1 |
	var input, filter, sig;
	input = In.ar(in, 2);
	filter = MoogLadder.ar(input, cutoff, res);
	sig = filter * amp;
	sig = Out.ar(out, sig);
}).add;


