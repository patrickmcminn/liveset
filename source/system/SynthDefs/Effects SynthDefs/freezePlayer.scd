/*
Friday, June 28th 2013
freezePlayer.scd
prm
*/

SynthDef(\freezePlayer, {
	| out, buffer, pan = 0, trigRate = 60, grainDur = 0.35, pos = 0.3
	atk = 0.01, dec = 0, sus = 1, rel = 6.0, gate = 1, amp = 1 |
	var grainTrig, granulation, env, sig;
	grainTrig = Dust.ar(trigRate);
	granulation = GrainBuf.ar(2, trigger: grainTrig, dur: grainDur,
		sndbuf: buffer, rate: 1, pos: pos, pan: pan);
	env = EnvGen.ar(Env.adsr(atk, dec, sus, rel), gate, doneAction: 2);
	sig = granulation * env;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;