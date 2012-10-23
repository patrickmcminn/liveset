/*
Monday, October 8th 2012
reverb2.scd
prm
stereo reverb
*/

SynthDef(\reverb2, {	// stereo reverb
	| in, out, mix = 0.25, room = 0.15, damp = 0.5, amp = 1 |
	var input, reverb, sig;
	input = In.ar(in, 2);
	reverb = FreeVerb2.ar(input[0], input[1], mix, room, damp);
	sig = reverb * amp;
	sig = Out.ar(out, sig);
}).add;

"reverb2 SynthDef Added".postln;
"      args: in, out, mix = 0.25, room = 0.15, damp = 0.5, amp = 1".postln;
"".postln;