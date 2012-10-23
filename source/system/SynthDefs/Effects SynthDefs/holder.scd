/*
Monday, October 8th 2012
holder.scd
prm
freezes incoming audio signal
*/

SynthDef(\holder, {
	| out, bufName, pan = 0, trigRate = 60, grainDur = 0.35, pos = 0.3,
	attack = 0.01, sustain = 1.0, release = 0.01, amp = 1 |
	var grainTrig, granulation, env, sig;
	grainTrig = Dust.ar(trigRate);
	granulation = GrainBuf.ar(2, trigger: grainTrig, dur: grainDur,
		sndbuf: bufName, rate: 1, pos: pos, pan: pan);
	env = EnvGen.kr(Env.linen(attack, sustain, release), 1,  doneAction: 2);
	sig = granulation * env;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;

"holder SynthDef Added".postln;
"     args: out, bufName, pan = 0, trigRate = 60, grainDur = 0.35, pos = 0.3, attack = 0.01, sustain = 1.0".postln;
"     release = 0.01, amp = 1".postln;