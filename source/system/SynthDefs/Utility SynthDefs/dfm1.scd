/*
Saturday, June 22nd 2013
dfm1.scd
prm
*/

SynthDef(\dfm1, {

	|
	in, out, amp = 1,
	cutoff = 10000, res = 0.1, dist = 1, type = 0, noise = 0.003
	|

	var input, filter, sig;
	input = In.ar(in);
	filter = DFM1.ar(input, cutoff, res, dist, type, noise);
	sig = filter * amp;
	sig = Out.ar(out, sig);
}).add;

SynthDef(\dfm1Stereo, {

	|
	in, out, amp = 1,
	cutoff = 10000, res = 1, dist = 1, type = 0, noise = 0.003
	|

	var input, filter, sig;
	input = In.ar(input, 2);
	filter = DFM1.ar(in, cutoff, 0.1, dist, type, noise);
	sig = filter * amp;
	sig = Out.ar(out, sig);
}).add;