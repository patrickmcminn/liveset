/*
Thursday, October 4th 2012
instIn.scd
prm
SynthDef for exterior input
*/

SynthDef(\instIn, {
	|in = 0, out, amp = 1 |
	var sig = SoundIn.ar(in)*amp;
	Out.ar(out, sig);
}).add;

"instIn SynthDef Added".postln;
"    args: in = 0, out, amp = 1 ".postln;