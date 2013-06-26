/*
Wednesday, March 13th 2013
warp.scd
prm
*/

// synthdef for warping, pitch-shfiting, and shaping buffers! Yay!

SynthDef(\warpEnv, {
	| in, out, amp = 0.5,
	bufName, posLow = 0.1, posHi = 0.9, posFreq = 0.2 shift = 0,


	Warp1.ar