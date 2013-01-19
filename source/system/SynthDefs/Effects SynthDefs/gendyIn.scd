/*
Saturday, January 12 2012
genyIn.scd
prm
*/

SynthDef(\gendyIn, {
	| in, out, aParamScale = 1, dParamScale = 1, amp = 0.5, shift = 0 |
	var input, freq, hasFreq, aParam, dParam, gendy, amplitude, cPscale, int, pitchShift, sig;
	input = In.ar(in);
	amplitude = Amplitude.ar(input, 0.01, 0.01);
	amplitude = LinLin.ar(amplitude, 0, 0.2, 0, 1.0);
	cPscale = LinLin.ar(amplitude, 0, 0.8, 3, 13);
	# freq, hasFreq = Pitch.kr(input, ampThreshold: 0.02, median: 7);
	aParam = LFPulse.ar((freq *aParamScale), 0, 0.4, 1.0);
	dParam = LFPulse.ar((freq * dParamScale), 0, 0.4, 1.0);
	gendy = Gendy2.ar(ampdist: 6, durdist: 6,
		adparam: aParam, ddparam: dParam, initCPs: 15, knum: cPscale, maxfreq: 1000);
	int = exp(0.057762265 * shift);
	pitchShift = PitchShift.ar(gendy, 0.2, int);
	sig = pitchShift * amplitude;
	sig = sig * amp;
	sig = sig.softclip;
	sig = Out.ar(out, sig);
}).add;

