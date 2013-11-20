/*
Tuesday, November 19th 2013
noiseMod.scd
prm
*/

SynthDef(\noiseModStereo, {
	| bus, freq = 1, rangeLo = 0, rangeHi = 1 |
	var input, noiseLeft, noiseRight, sigLeft, sigRight, sig;
  input = In.ar(bus, 2);
	noiseLeft = LFNoise0.ar(freq).range(rangeLo, rangeHi);
  noiseRight = LFNoise0.ar(freq).range(rangeLo, rangeHi);
  sigLeft = input[0] * noiseLeft;
  sigRight = input[1] * noiseRight;
  sig = [sigLeft, sigRight];
	sig = ReplaceOut.ar(bus, sig);
}).add;