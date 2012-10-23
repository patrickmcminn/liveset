/*
Monday, October 8th 2012
demandRand7.scd
prm
*/

SynthDef(\demandRand7, {
	| out, freq = 1, d1 = 1, d2 = 2, d3 = 3, d4 = 4, d5 = 5, d6 = 6, d7 = 7 |
	var rand, trig, demand, sig;
	rand = Drand([d1, d2, d3, d4, d5, d6, d7], inf);
	trig = Dust.kr(freq);
	demand = Demand.kr(trig, 0, rand);
	sig = Out.kr(out, demand);
}).add;

"demandRand7 Synth Added".postln;
"     args: out, freq = 1, d1 = 1, d2 = 2, d3 = 3, d4 = 4, d5 = 5, d6 = 6, d7 = 7".postln;
