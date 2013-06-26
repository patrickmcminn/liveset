/*
Friday, March 15th
sidechainCompressor.scd
prm
*/

SynthDef(\sidechainCompressor, {

	|
	in, out, amp = 1,
	sIn, thresh = 0.0002, slopeBelow = 1, slopeAbove = 0.5, clampTime = 0.001, relaxTime = 0.1

	|

	var input, sidechain, compressor, sig;

	input = In.ar(in);
	sidechain = In.ar(sIn);
	compressor = Compander.ar(input, sidechain, thresh, slopeBelow, slopeAbove, clampTime, relaxTime);
	sig = compressor * amp;
	sig = Out.ar(out, sig);
}).add;



SynthDef(\sidechainCompressorStereo, {

	|
	in, out, amp = 1, pan = 0,
	sIn, thresh = 0.0002, slopeBelow = 1, slopeAbove = 0.5, clampTime = 0.001, relaxTime = 0.1

	|

	var input, sidechain, compressor, sig;

	input = In.ar(in);
	sidechain = In.ar(sIn);
	compressor = Compander.ar(input, sidechain, thresh, slopeBelow, slopeAbove, clampTime, relaxTime);
	sig = compressor * amp;
	sig = Pan2.ar(sig, pan);
	sig = Out.ar(out, sig);
}).add;
