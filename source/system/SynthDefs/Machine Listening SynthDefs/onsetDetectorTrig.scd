/*
Monday, October 8th 2012
onsetDetectorTrig.scd
prm
detects onsets of musical events and sends triggers out via OSC
*/

SynthDef(\onsetDetectorTrig, {
	|in = 0, id = 0,
	trackFall = 0.2, slowLag = 0.2, fastLag = 0.01, fastMul = 0.5, thresh = 0.05, minDur = 0.1 |
	var input, detect, trigger, sig;
	input = In.ar(in);
	detect = Coyote.kr(input, trackFall, slowLag, fastLag, fastMul, thresh, minDur);
	sig = SendTrig.kr(detect, id, 1);
}).add;

"onsetDetectorTrig SynthDef Added".postln;
"     args: in = 0, id = 0, trackFall = 0.2, slowLag = 0.1, fastLag = 0.01, fastMul = 0.5, thresh = 0.05, minDur = 0.1".postln;
"".postln;