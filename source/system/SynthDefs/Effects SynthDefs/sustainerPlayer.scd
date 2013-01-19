/*
Monday, January 14th 2012
sustainerPlayer.scd
prm
*/

SynthDef(\sustainerPlayer, {
	| out, bufName, pan = 0, trigRate = 60, grainDur = 0.35, pos = 0.3
	attack = 0.01, release = 6.0, amp = 1 |
	var grainTrig, granulation, env, sig;
	grainTrig = Dust.ar(trigRate);
	granulation = GrainBuf.ar(2, trigger: grainTrig, dur: grainDur,
		sndbuf: bufName, rate: 1, pos: pos, pan: pan);
	env = EnvGen.ar(Env.perc(attack, release), 1);
	sig = granulation * env;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;