/*
Thursday, October 4th 2012
faders.scd
prm
SynthDefs for simple mono and stereo faders
*/

SynthDef(\fader, {
	| in, out, amp = 1.0, mute = 1 |
	var input, sig;
	input = In.ar(in);
	sig = input * amp * mute;
	sig = sig.softclip;
	sig = Out.ar(out, sig);
}).add;

"fader SynthDef added".postln;
"     args: in, out, amp = 1, mute = 1".postln;

SynthDef(\stereoFader, {
	| in, out, amp = 1.0, mute = 1 |
	var input, sig;
	input = In.ar(in, 2);
	sig = input * amp * mute;
	sig = sig.softclip;
	sig = Out.ar(out, sig);
}).add;

"stereo fader SynthDef added".postln;
"     args: in, out, amp = 1, mute = 1".postln;

