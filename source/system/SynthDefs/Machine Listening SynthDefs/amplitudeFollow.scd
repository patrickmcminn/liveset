/*
Monday, January 14th 2013
amplitudeFollow.scd
prm
*/

SynthDef(\amplitudeFollow, {
	| in, out, attackTime = 0.01, releaseTime = 0.01 |
	var input, amplitude, sig;
	input = In.ar(in);
	amplitude = A2K.kr(Amplitude.ar(input, attackTime, releaseTime));
	sig = Out.kr(out, amplitude);
}).add;