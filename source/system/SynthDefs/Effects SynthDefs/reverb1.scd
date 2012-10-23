/*
Monday, October 8th
reverb1.scd
prm
*/

SynthDef(\reverb1, {	// mono reverb
	| in, out, mix = 0.25, room = 0.15, damp = 0.5, amp = 1 |
	var input, reverb, sig;
	input = In.ar(in);
	reverb = FreeVerb.ar(input, mix, room, damp);
	sig = reverb * amp;
	sig = Out.ar(out, sig);
}).add;

"reverb1 SynthDef added".postln;
"     args: in, out, mix = 0.25, room = 0.15, damp = 0.5, amp = 1".postln;