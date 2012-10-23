/*
Monday, October 8th 2012
ctlLinLine.scd
prm
linear line from a start point to an end point
*/

SynthDef(\ctlLinLine, {	// linear line from a starting point to an ending point
	| out, start = 0, end = 1, dur = 1 |
	var line, sig;
	line = Line.kr(start, end, dur, doneAction: 2);
	sig = ReplaceOut.kr(out, line);
}).add;

"ctlLinLine SynthDef added".postln;
"     args: out, start = 0, end = 1, dur = 1".postln;