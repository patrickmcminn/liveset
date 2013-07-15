/*
Thursday October 4th, 2012
recordBuf.scd
prm
SynthDef for recording into an external buffer
*/

SynthDef(\recordBuf, {
	|in, bufName, loop = 0, preLevel = 0 |
	var input, record, sig;
	input = In.ar(in);
	record = RecordBuf.ar(input, bufName, preLevel: preLevel, loop: loop, trigger: 1, doneAction: 2);
}).add;

"recordBuf SynthDef added".postln;
"     args: in, bufName".postln;