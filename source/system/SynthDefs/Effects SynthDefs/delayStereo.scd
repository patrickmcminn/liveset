/*
Monday, October 8th 2012
delayStereo.scd
prm
*/

SynthDef(\delayStereo, {
	| in, out, maxDelay = 10, delayTime = 2, decayTime = 1.5, amp = 1, mix = 0.5 |
	var input, dry, delay, sig;
	input = In.ar(in, 2);
	dry = input * (1-mix);
	delay = CombN.ar(input, maxDelay, delayTime, decayTime);
	delay = delay * mix;
	sig = (dry + delay) * amp;
	sig = Out.ar(out, sig);
}).add;

"delayStereo SynthDef Added".postln;
"     args: in, out, maxDelay = 10, delayTime = 2, decayTime = 1.5, amp = 1, mix = 0.5".postln;
"".postln;