/*
Monday, October 8th 2012
delay.scd
prm
*/

SynthDef(\delay, {
	| in, out, maxDelay = 10, delayTime = 2, decayTime = 1.5, amp = 1, mix = 0.5 |
	var input, dry, delay, sig;
	input = In.ar(in);
	dry = input * (1-mix);
	delay = CombN.ar(input, maxDelay, delayTime, decayTime);
	delay = delay * mix;
	sig = (dry + delay) * amp;
	sig = ReplaceOut.ar(out, sig);
}).add;

"delay SynthDef Added".postln;
"     args: in, out, maxDelay = 10, delayTime = 2, decayTime = 1.5, amp = 1, mix = 0.5".postln;
"".postln;