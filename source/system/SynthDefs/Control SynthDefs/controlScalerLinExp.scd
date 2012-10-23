/*
Thursday October 4th, 2012
controlScalerLinExp.scd
prm
converts control signals from a Linear to an Exponential Scale
*/

SynthDef(\controlScalerLinExp, {
	| in = 0, out = 0, rangeInLo, rangeInHi, rangeOutLo, rangeOutHi |
	var input, scaler, sig;
	input = In.kr(in);
	scaler = LinExp.kr(input, rangeInLo, rangeInHi, rangeOutLo, rangeOutHi);
	sig = ReplaceOut.kr(out, scaler);
}).add;

"controlScalerLinExp SynthDef Added".postln;
"     args: in = 0, out = 0, rangeInLo, rangeInHi, rangeOutLo, rangeOutHi".postln;