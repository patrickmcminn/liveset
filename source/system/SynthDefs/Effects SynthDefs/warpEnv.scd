/*
Wednesday, March 13th 2013
warp.scd
prm
*/

// synthdef for warping, pitch-shfiting, and shaping buffers! Yay!

SynthDef(\warpEnv, {
	|
	out, amp = 0.5,
	bufName, posLow = 0.1, posHi = 0.9, posFreq = 1, shift = 0,
	lowShelfFreq = 220, lowShelfGain = 0,
	cutoff = 15000, hiCutoff = 20,
	attack = 0.05, decay = 0, sustain = 1.0, release = 0.05, gate = 1
	|

	var interval, transport, warp, lowShelf, lowPass, hiPass, env, panner, sig;

	interval = exp(0.057762265 * shift);
	transport = SinOsc.ar(
		(BufFrames.kr(bufName)/s.sampleRate)
		*
		posFreq).range(posLow, posHi);
	warp = Warp1.ar(1, bufName, transport, interval, 0.2, -1, 8, 0, 2);
	lowShelf = BLowShelf.ar(warp, lowShelfFreq, 1, lowShelfGain);
	lowPass = LPF.ar(lowShelf, cutoff);
	hiPass = HPF.ar(lowPass, hiCutoff);
	env = EnvGen.kr(Env.adsr(attack, decay, sustain, release, curve: 1), gate, doneAction: 2);
	env = hiPass * env;
	sig = env * amp;
	sig = Out.ar(out, sig);
}).add;




// c = Synth(\warpEnv,
// [\posFreq, 0.2, \bufName, a, \attack, 12, \release, 7, \shift, -12, \lowShelfFreq, 220, \lowShelfGain, 7, \cutoff, 600]);
// c.set(\gate, 0)
// c.free;
// a.play
//
// d = Synth(\warpEnv, [\bufName, a])
// e = Synth(\warpEnv, [\bufName, b])
//
// { (BufFrames.ir(a)/s.sampleRate).poll; }.play
