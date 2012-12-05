SynthDef(\nebula8, {
	| in = 0, out = 0 trig, depth = 25, amp = 1, activity = 50 |
	var input, range, offset, rate, trigger, nebulaLeft, nebulaRight, left, right, sig;

	input = In.ar(in);
	range = depth * 0.01;
	offset = 0.945 - range + (range/5);
	rate = ((activity/100) -1*(-500)+11)/1000;
	trigger = Impulse.kr(1/rate);

	nebulaLeft = Mix.fill(4, {
		(TRand.kr(0, range, trigger) + offset).linexp(0, 1.2, 0.0001, 1.2)
	});
	nebulaLeft = nebulaLeft/4;

	nebulaRight = Mix.fill(4, {
		(TRand.kr(0, range, trigger) + offset).linexp(0, 1.2, 0.0001, 1.2)
	});
	nebulaRight = nebulaRight/4;


	left = input * Lag2.kr(nebulaLeft, 0.7);
	right = input * Lag2.kr(nebulaRight, 0.7);

	sig = [left, right];
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
SynthDef(\instIn, {
	|in = 0, out, amp = 1 |
	var sig = SoundIn.ar(in)*amp;
	Out.ar(out, sig);
}).add;
)

(
~bus = Bus.audio;
Synth(\instIn, [\in, 0, \out, ~bus], addAction: \addToTail);
Synth(\nebulator, [\in, ~bus, \out, 0, \depth, 76, \activity, 61], addAction: \addToTail);
)

(
~bus = Bus.audio;
~synth = { Out.ar(~bus, Saw.ar(220) * 0.4) }.play;
~nebula = Synth(\nebula, [\in, ~bus, \out, 0, \depth, 76, \activity, 61], addAction: \addToTail);
)
*/ 