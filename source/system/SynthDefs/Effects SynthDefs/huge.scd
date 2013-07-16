/*
Tuesday, July 16th 2013
huge.scd
prm
*/

SynthDef(\huge, {
	|
	in, out, amp = 0.5, dist = 10,
	ampScale = 2, subAmp = 1
	bufLength = 1, trigRate = 7, grainDur = 0.1, rate = 100, grainAmp = 0.4
	cutoff = 5000
	|

	var input, freq, hasFreq, amplitude;
	var sine, distortion;
	var buffer, playhead, record, trigger, panner, granulation;

	input = In.ar(in);

	# freq, hasFreq = Pitch.kr(input, ampThreshold: 0.02, median: 7);
	amplitude = Amplitude.ar(input, 0.01, 0.07);

	sine = SinOsc.ar(freq/2) * amplitude;
	sine = sine * subAmp;

	distortion = (input * dist).distort;
	distortion = distortion * amplitude;

	buffer = LocalBuf(s.sampleRate * bufLength, 1);
	playhead = Phasor.ar(0, BufRateScale.kr(buffer), 0, BufFrames.kr(buffer));
	record = BufWr.ar(input, buffer, playhead, overwrite);
	trigger = Impulse.ar(trigRate);
	position =
	panner = TRand.ar(-1, 1, trigger);
	granulation = GrainBuf.ar(1, trigger, rainDur, buffer, rate, position, 2, panner, -1);





}).add;