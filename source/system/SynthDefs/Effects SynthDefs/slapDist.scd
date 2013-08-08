/*
Sunday, August 4th 2013
slapDist.scd
prm
*/


SynthDef(\slapDist, {
	|
	in, out, amp = 1, delMix = 0.55, shiftMix = 0.3, verbMix = 0.6,
	maxDelay = 1, delL = 0.1, delR = 0.09,
	int1 = -12, int2 = 7, int3 = 12,
	int1Amp = 0.8, int2Amp = 0.2, int3Amp = 0.6,
	dist = 25, distMix = 0.57, cutoff = 4000
	|

	var input, delayLeft, delayRight, delay;
	var interval1, interval2, interval3, shift1, shift2, shift3, shift;
	var mix, distortion, filter, verb;
	var sig;

	input = In.ar(in);
	//input = SoundIn.ar(0);

	delayLeft = DelayC.ar(input, maxDelay, delL);
	delayRight = DelayC.ar(input, maxDelay, delR);
	delay = [delayLeft, delayRight];
	delay = delay * delMix;
	delay = delay + (input * (1-delMix));

	interval1 = exp(0.057762265 * int1);
	interval2 = exp(0.057762265 * int2);
	interval3 = exp(0.057762265 * int3);
	shift1 = PitchShift.ar(input, 0.2, interval1);
	shift1 = shift1 * int1Amp;
	shift2 = PitchShift.ar(input, 0.2, interval2);
	shift2 = shift2 * int2Amp;
	shift3 = PitchShift.ar(input, 0.2, interval3);
	shift3 = shift3 * int3Amp;
	shift = Mix.ar([shift1, shift2, shift3]);
	shift = shift * shiftMix;
	shift = shift + (delay * (1-shiftMix));
	shift = shift ! 2;

	distortion = (shift * dist).distort;
	distortion = distortion * distMix;
	distortion = distortion + ( shift * (1-distMix));
	filter = LPF.ar(distortion, cutoff);

	verb = FreeVerb2.ar(filter[0], filter[1], verbMix, 0.6, 0.8);
	sig = verb * amp;

	sig = Out.ar(out, sig);

}).add;
