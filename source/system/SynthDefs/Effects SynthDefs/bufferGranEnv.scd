/*
Monday, August 5th 2013
bufferGranEnv.scd
prm
*/

SynthDef(\bufferGranEnv, {

	|
	out, panLo = -1, panHi = 1, grainDurLo = 0.05, grainDurHi = 0.15  buffer,
	rateLo = 1, rateHi = 1, posLo = 0.2, posHi = 0.6,
	cutoffLo = 500, cutoffHi = 1200, resLo = 0.8, resHi = 0,
	env = -1, sync = 0, trigRate = 32, amp = 1, overwrite = 1
	|

	var trigger, duration, positionChange, position, panning, rater, granulation;
	var filterStart, filterEnd, filterChange, resChange, filter, sig;

	trigger = SelectX.ar(sync, [Dust.ar(trigRate), Impulse.ar(trigRate)]);
	duration = TRand.ar(grainDurLo, grainDurHi, trigger);
	position = TRand.ar(posLo, posHi, trigger);
	rater = TRand.ar(rateLo, rateHi, trigger);
	panning = TRand.ar(panLo, panHi, trigger);
	granulation = GrainBuf.ar(2, trigger: trigger, dur: duration, sndbuf: buffer, rate: rater,
		pos: position, pan: panning, envbufnum: env);
	filterStart = TRand.ar(cutoffLo, cutoffHi, trigger);
	filterEnd = TRand.ar(cutoffLo, cutoffHi, trigger);
	filterChange = XLine.ar(filterStart, filterEnd, duration);
	resChange = 1 - TExpRand.ar(resLo, resHi, trigger);
	filter = RLPF.ar(granulation, filterChange, resChange);
	sig = filter * amp;
	sig = sig.softclip;
	sig = Out.ar(out, sig);
}).add;
