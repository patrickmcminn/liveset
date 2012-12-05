/*
pitchShifter SynthDef.scd
*/

(
SynthDef(\pitchShifter, {
	| in, out, interval = 0, amp = 1 |
	var int, input, sig;
	int = exp(0.057762265 * interval);
	input = In.ar(in);
	sig = PitchShift.ar(input, 0.1, int, 0.001, 0.04);
	sig = sig*amp;
	sig = Out.ar(out, sig);
}).add;

"pitchShifter SynthDef Loaded".postln;
"args: in, out, interval, amp = 1".postln;
"".postln;
);