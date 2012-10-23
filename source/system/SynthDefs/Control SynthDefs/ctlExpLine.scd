/*
Thursday October 4th, 2012
controlScalerLinExp.scd
prm
exponential line from a startpoint to an endpoint
*/



SynthDef(\ctlExpLine, {	// Exponential line from a starting point to an ending point
	| out, start = 0.000000001, end = 1, dur = 1 |
	var line, sig;
	line = XLine.kr(start, end, dur, doneAction: 2);
	sig = ReplaceOut.kr(out, line);
}).add;

"ctlExpLine Synth Added".postln;
"     args: out, start, end, dur".postln;