/*
Thursday, November 1st 2012
ratioSaw.scd
prm
*/

SynthDef(\ratioSaw, {
	| out, amp = 0.8, freq = 220, filterMul = 3
	atk = 0.05, sus = 1, rel = 0.5 |
	var saw, mul, filter, env, sig;
	saw = Saw.ar(freq);
	mul = freq * filterMul;
	filter = LPF.ar(saw, mul);
	env = EnvGen.ar(Env.linen(atk, sus, rel), 1, doneAction: 2);
	sig = filter * env;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;

"ratio saw added".postln;
"args: out, amp = 0.8, freq = 220, filterMul = 3,".postln;
"     atk = 0.05, sus = 1, rel = 0.5".postln;
"".postln;
