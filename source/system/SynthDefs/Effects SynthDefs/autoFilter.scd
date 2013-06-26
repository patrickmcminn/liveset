/*
Friday, March 15th 2013
autoFilter.scd
prm
*/


SynthDef(\autoFilter, {

	|
	in, out, amp = 0.5,
	filterType = 0, cutoff = 10000, rq = 1,
	modWave = 0, freq = 1, modLo = 100, modHi = 2000, phase = 0
	|

	var input, modSine, modSaw, modNoise, mod, lowPass, hiPass, bandPass, bandReject, filter, sig;

	input = In.ar(in);

	modSine = SinOsc.ar(freq, phase).range(modLo, modHi);
	modSaw = LFSaw.ar(freq, phase).range(modLo, modHi);
	modNoise = LFNoise0.ar(freq).range(modLo, modHi);
	mod = SelectX.ar(modWave, [modSine, modSaw, modNoise]);

	lowPass = RLPF.ar(input, mod, rq);
	hiPass = RHPF.ar(input, mod, rq);
	bandPass = BPF.ar(input, mod, rq);
	bandReject = BRF.ar(input, mod, rq);
	filter = Select.ar(filterType, [lowPass, hiPass, bandPass, bandReject]);

	sig = filter * amp;
	sig = Out.ar(out, sig);
}).add;

SynthDef(\autoFilterStereo, {

	|
	in, out, amp = 0.5,
	filterType = 0, cutoff = 10000, rq = 1,
	modWave = 0, freq = 1, modLo = 100, modHi = 2000, phase = 0
	|

	var input, modSine, modSaw, modNoise, mod, lowPass, hiPass, bandPass, bandReject, filter, sig;

	input = In.ar(in, 2);

	modSine = SinOsc.ar(freq, phase).range(modLo, modHi);
	modSaw = LFSaw.ar(freq, phase).range(modLo, modHi);
	modNoise = LFNoise0.ar(freq).range(modLo, modHi);
	mod = SelectX.ar(modWave, [modSine, modSaw, modNoise]);

	lowPass = RLPF.ar(input, mod, rq);
	hiPass = RHPF.ar(input, mod, rq);
	bandPass = BPF.ar(input, mod, rq);
	bandReject = BRF.ar(input, mod, rq);
	filter = Select.ar(filterType, [lowPass, hiPass, bandPass, bandReject]);

	sig = filter * amp;
	sig = Out.ar(out, sig);
}).add;
