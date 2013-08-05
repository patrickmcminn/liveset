/*
Monday, August 5th 2013
sawShift.scd
prm
*/

SynthDef(\sawShift, {

	|
	out, amp = 0.7,
	lenLo = 0.05, lenHi = 0.3,
	freqLo = 50, freqHi = 300, cutoffLo = 400, cutoffHi = 1000,
	resLo = 0.95, resHi = 0.5, panLo = -1, panHi = 1
	|

	var length, freqStart, freqStop, freq, filterStart, filterStop, cutoff;
	var resonance, saw, filter, env, sum, panner, pan, sig;

	length = TRand.ar(lenLo, lenHi, 1);
	freqStart = TRand.ar(freqLo, freqHi, 1);
	freqStop = TRand.ar(freqLo, freqHi, 1);
	freq = XLine.ar(freqStart, freqStop, length);
	filterStart = TRand.ar(cutoffLo, cutoffHi, 1);
	filterStop = TRand.ar(cutoffLo, cutoffHi, 1);
	cutoff = XLine.ar(filterStart, filterStop, length);
	resonance = TRand.ar(resLo, resHi, 1);
	saw = Saw.ar(freq);
	filter = RLPF.ar(saw, cutoff, resonance);
	env = EnvGen.ar(Env.perc(length, 0.1, 1, 6), 1, doneAction: 2);
	sum = filter * env;
	panner = TRand.ar(panLo, panHi, 1);
	pan = Pan2.ar(sum, panner);
	sig = pan * amp;
	sig = Out.ar(out, sig);
}).add;



Synth(\sawShift)





	