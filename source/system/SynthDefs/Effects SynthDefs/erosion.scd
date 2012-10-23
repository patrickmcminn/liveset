/*
Monday, October 8th 2012
erosion.scd
prm
*/

SynthDef(\erosion, {
	| in, out, freq = 100, rangeLo = 0.002, rangeHi = 0.1, decayTime = 1.5, amp = 1, mix = 1 |
	var input, dry, noise, delay, sig;
	input = In.ar(in);
	dry = input * (1-mix);
	noise = LFNoise1.ar(freq).range(rangeLo, rangeHi);
	delay = CombN.ar(input, 1, noise, decayTime);
	delay = delay*mix;
	sig = (dry + delay) * amp;
	sig = ReplaceOut.ar(out, sig);
}).add;

"erosion SynthDef Added".postln;
"     args: in, out, freq = 100, rangeLo = 0.002, rangeHi = 0.1, decayTime = 1.5, amp = 1, mix = 1".postln;