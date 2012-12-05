
SynthDef(\brokenAntenna, {

	|
	in, out, mix = 1,
	lowFreq = 120, lowAtk = 0.00137, lowRel = 0.008
	lowInputGain = 0.7079, lowOutputGain = 1.07152,
	lowThresh = 0.14125, lowBelowRatio = 4, lowAboveRatio = 0.23,
	midAtk = 0.00228, midRel = 0.0096,
	midInputGain = 0.6839, midOutputGain = 0.71614,
	midThresh = 0.14125, midBelowRatio = 4, midAboveRatio = 0.465 ,
	hiFreq = 3250, hiAtk = 0.00042, hiRel = 0.00449,
	hiInputGain = 0.6839, hiOutputGain = 1.92752,
	hiThresh = 0.23041, hiBelowRatio = 4,  hiAboveRatio = 1,
	outputGain = 7.9433,
	amp = 1
	|

	var input, dry, low, mid, hi, sum, sig;
	input = In.ar(in, 2);
	dry = input * (1-mix);
	low = LPF.ar(input, lowFreq);
	low = low * lowInputGain;
	low = Compander.ar(low, low, lowThresh, lowBelowRatio, lowAboveRatio, lowAtk, lowRel);
	low = low * lowOutputGain;
	mid = BBandPass.ar(input, 1685, 4);
	mid = mid * midInputGain;
	mid = Compander.ar(mid, mid, midThresh, midBelowRatio, midAboveRatio, midAtk, midRel);
	mid = mid * midOutputGain;
	hi = HPF.ar(input, hiFreq);
	hi = hi * hiInputGain;
	hi = Compander.ar(hi, hi, hiThresh, hiBelowRatio, hiAboveRatio, hiAtk, hiRel);
	hi = hi*hiOutputGain;
	sum = low + mid + hi;
	sig = sum * outputGain;
	sig = sig * mix;
	sig = dry + sig;
	sig = sig * amp;
	sig = sig.softclip;
	sig = Out.ar(out, sig);
}).add;