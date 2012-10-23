/*
Thursday, October 4th, 2012
pan.scd
prm
panning SynthDef
*/

SynthDef(\pan, {
	| in, pan = 0, amp = 1, out |
	var input, panner, sig;
	input = In.ar(in);
	panner = Pan2.ar(input, pan);
	sig = panner * amp;
	sig = Out.ar(out, sig);
}).add;

"pan SynthDef added".postln;
"    args: in, pan = 0, amp = 1, out".postln;
