/*
Tuesday, November 19th 2013
noiseMod.scd
prm
*/

SynthDef(\noiseModStereo, {
	| bus, freq = 1, rangeLo = 0, rangeHi = 1 |
	var input, noise, sig;
  input = In.ar(bus, 2);
	noise = LFNoise0.ar(freq).range(rangeLo, rangeHi);
  sig = input * noise;
	sig = ReplaceOut.ar(bus, sig);
}).add;