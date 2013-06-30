/*
Monday, October 8th 2012
randTrig.scd
prm
SynthDef for sending random control triggers
*/


SynthDef(\randTrig, {	// control SynthDef for sending triggers using Dust
	| out, freq = 1 |
	var sig;
	sig = Dust.kr(freq);
	sig = Out.kr(out, sig);
}).add;

"randTrig SynthDef added".postln;
"     args: out, freq = 1".postln;

SynthDef(\randTrigA, {	// control SynthDef for sending triggers using Dust at Audio Rate
	| out, freq = 1 |
	var sig;
	sig = Dust.ar(freq);
	sig = Out.ar(out, sig);
}).add;
