/*
Monday, October 8th 2012
granulator.scd
prm
*/

SynthDef(\granulator, {// granulation of incoming audio

	| in, out, bufLength = 3, pan = 0, panOffset = 1, grainDur = 0.1,
	grainDurOffset = 0.09, rate = 1, rateOffset = 0, pos = 0.5, posOffset = 1
	env = -1, sync = 0, trigRate = 32, amp = 1, overwrite = 1, mix = 1 |

	var input, dry, playhead, buffer, record, trigger, duration, positionChange, position,
		panning, rater, granulation, sig;

	input = In.ar(in);
	dry = input*(1-mix);
	buffer = LocalBuf(s.sampleRate * bufLength, 1);
	buffer.clear;
	playhead = Phasor.ar(0, BufRateScale.kr(buffer), 0, BufFrames.kr(buffer));
	record = BufWr.ar(input, buffer, playhead, overwrite);
	trigger = SelectX.ar(sync, [Dust.ar(trigRate), Impulse.ar(trigRate)]);
	duration = (grainDur + TRand.ar(grainDurOffset.neg, grainDurOffset, trigger)).abs;
	positionChange = Wrap.ar(pos + TRand.ar(posOffset.neg, posOffset, trigger), 0, 1);
	position = if((playhead/buffer.numFrames) == positionChange,
		{ positionChange - 0.1 }, { positionChange });
	rater = rate + (TRand.ar(rateOffset.neg, rateOffset, trigger));
	panning = Wrap.ar(pan + TRand.ar(panOffset.neg, panOffset, trigger), -1, 1);
	granulation = GrainBuf.ar(2, trigger: trigger, dur: duration, sndbuf: buffer, rate: rater,
		pos: position, pan: panning, envbufnum: env);
	granulation = granulation * mix;
	sig = granulation + dry;
	sig = sig * amp;
	sig = sig.softclip;
	sig = Out.ar(out, sig);
}).add;

"granulator SynthDef Added".postln;
"     args: in, out, bufLength = 3, pan = 0, panOffset = 1, grainDur = 0.1, grainDurOffset = 0.09".postln;
"     rate = 1, rateOffset = 0, pos = 0.5, posOffset = 1, env = -1, sync = 0, trigRate = 32, amp = 1".postln;
"     overwrite = 1, mix = 1".postln;