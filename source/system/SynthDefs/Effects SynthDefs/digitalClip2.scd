/*
Monday, October 8th 2012
digitalClip2.scd
prm
*/

SynthDef(\digitalClip2, {	// best to have a noise gate in front of this
	| in, out, amount = 10, amp = 0.2 |
	var sig, scale, distort, output;
	sig = In.ar(in) * amount;
	distort = sig.distort;
	scale = distort * amp;
	output = ReplaceOut.ar(out, scale);
}).add;

"digitalClip2 SynthDef Added".postln;
"      args: in, out, amount = 10, amp = 2".postln;
"".postln;