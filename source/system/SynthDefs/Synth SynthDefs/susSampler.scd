/*
Saturday, June 22nd 2013
susSampler.scd
prm
*/


SynthDef(\susSampler, {
	|
	out, amp = 0.2, buffer, gate = 1, loop = 1, rate = 1,
	attack = 0.01, decay = 0.5, sustain = 1, release = 0.5, balance = 0
	|

	var playBuf, envelope, sig;

	playBuf = PlayBuf.ar(2, buffer, rate, loop:  loop);
	envelope = EnvGen.kr(Env.adsr(attack, decay, sustain, release), gate, doneAction: 2);
	sig = playBuf * envelope;
  sig = Balance2.ar(sig[0], sig[1], balance, amp);
	sig = Out.ar(out, sig);
}).add;
