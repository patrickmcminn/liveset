/*
Thursday, October 4th 2012
playBuf.scd
prm
buffer playback synthDef with attack, sustain, and release values
*/

SynthDef(\playBuf, {
	| bufName, out, rate = 1, loop = 0, startPos = 0, amp = 1,
	attack = 0.05, sustain = 1, release = 0.05 |
	var play, sig, env;
	play = PlayBuf.ar(1, bufName, rate, 1, startPos, loop);
	env = EnvGen.kr(Env.linen(attack, sustain, release), 1, doneAction: 2);
	sig =  env * play;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;

SynthDef(\playBufStereo, {
	| bufName, out, rate = 1, loop = 0, startPos = 0, amp = 1,
	attack = 0.05, sustain = 1, release = 0.05, pan = 0 |
	var play, sig, env;
	play = PlayBuf.ar(1, bufName, rate, 1, startPos, loop);
	env = EnvGen.kr(Env.linen(attack, sustain, release), 1, doneAction: 2);
	sig =  env * play;
	sig = Pan2.ar(sig, pan);
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;

"playBuf SynthDef added".postln;
"     args: bufName, out, rate = 1, loop = 0, startPos = 0, amp = 1, attack = 0.05, sustain = 1, release = 0.05".postln;
