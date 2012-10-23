/*
Monday, October 8th
droneDelay.scd
prm
deleay with incredibly long delay time
*/

SynthDef(\droneDelay, {
	| in, out, maxDelay = 3, delayTime = 2, decayTime = 40, mix = 1, thresh = 0.5
	ratio = 4, attack = 0.01, release = 0.01, amp = 1, inputScale = 0.2 |
	var input, ratioConvert, dry, compressor, delay, limiter, sig, output;
	input = In.ar(in);
	dry = input * (1-mix);
	ratioConvert = 1/ratio;
	compressor = Compander.ar(input, input, thresh, 1, ratioConvert, attack, release);
	compressor = compressor * inputScale;
	delay = CombN.ar(compressor, maxDelay, delayTime, decayTime);
	delay = delay * mix;
	sig = (dry + delay) * amp;
	sig = sig.softclip;
	limiter = Compander.ar(sig, sig, 1, 1, 0.1, 0.01, 0.01);
	output = ReplaceOut.ar(out, limiter);
}).add;

"droneDelay SynthDef added".postln;
"     args: in, out, maxDelay = 3, delayTime = 2, decayTime = 40, mix = 1, thresh = 0.5, ratio = 4, attack = 0.01".postln;
"     ratio = 4, attack = 0.01, release = 0.01, amp = 1, inputScale = 0.2".postln;