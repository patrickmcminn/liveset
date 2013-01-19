/*
Monday, January 14th 2013
controlScalerLinLin.scd
prm
*/

SynthDef(\controlScalerLinLin, {
	| in = 0, out = 0, rangeInLo, rangeInHi, rangeOutLo, rangeOutHi |
	var input, scaler, sig;
	input = In.kr(in);
	scaler = LinLin.kr(input, rangeInLo, rangeInHi, rangeOutLo, rangeOutHi);
	sig = ReplaceOut.kr(out, scaler);
}).add;