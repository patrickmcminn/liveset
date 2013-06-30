/*
Friday, June 28th 2013
freezePlayer.scd
prm
*/

SynthDef(\freezePlayerSus, {
	|
	out, buffer, pan = 0, trigRate = 60, grainDur = 0.35, pos = 0.3, rate = 1,
	atk = 0.01, dec = 0, sus = 1, rel = 6.0, gate = 1, amp = 1,
	tremRate = 0, tremDepth = 0
	|
	var grainTrig, granulation, trem, env, sig;
	grainTrig = Dust.ar(trigRate);
	granulation = GrainBuf.ar(2, trigger: grainTrig, dur: grainDur,
		sndbuf: buffer, rate: rate, pos: pos, pan: pan);
	trem = SinOsc.ar(tremRate).range((1-tremDepth), 1);
	env = EnvGen.ar(Env.adsr(atk, dec, sus, rel), gate, doneAction: 2);
	sig = granulation * env;
	sig = sig * trem;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;

SynthDef(\freezePlayer, {
	|
	out, buffer, pan = 0, trigRate = 60, grainDur = 0.35, pos = 0.3, rate = 1,
	atk = 0.01, sus = 1, rel = 0.01, amp = 1, curve = 6
	|
	var grainTrig, granulation, trem, env, sig;
	grainTrig = Dust.ar(trigRate);
	granulation = GrainBuf.ar(2, trigger: grainTrig, dur: grainDur,
		sndbuf: buffer, rate: rate, pos: pos, pan: pan);
	env = EnvGen.ar(Env.linen(atk, sus, rel, curve: curve), 1, doneAction: 2);
	sig = granulation * env;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;