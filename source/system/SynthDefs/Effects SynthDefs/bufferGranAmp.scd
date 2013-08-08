/*
Monday, August 5th 2013
bufferGranAmp
prm
*/


SynthDef(\bufferGranAmp, {

	|
	buffer, in, out, amp = 1, ampScaleHi = 0.3,
	grainDurLo = 5, grainDurHi = 0.005, trigLo = 0.65, trigHi = 95, ampLo = 0.4, ampHi = 1.3,
	posLo = 0.0, posHi = 1.0, panLo = -1, panHi = 1, rateLo = 1, rateHi = 1, env = -1
	|

	var input, amplitude, trigChange, trigger, duration, position, panning, rate;
	var granulation, ampChange, sig;

	input = In.ar(in);
	//input = SoundIn.ar(0);
	amplitude = Amplitude.ar(input, 0.01, 0.01);
	//amplitude.poll;
	trigChange = amplitude.linlin(0, ampScaleHi, trigLo, trigHi);
	trigger = Dust.ar(trigChange);
	duration = amplitude.linlin(0, ampScaleHi, grainDurLo, grainDurHi);
	position = TRand.ar(posLo, posHi, trigger);
	panning = TRand.ar(posLo, posHi, trigger);
	rate = TRand.ar(rateLo, rateHi, trigger);
	granulation = GrainBuf.ar(2, trigger, duration, buffer, rate, position, 2, panning, env);
	ampChange = amplitude.linlin(0, ampScaleHi, ampLo, ampHi);
	sig = granulation * ampChange;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;
