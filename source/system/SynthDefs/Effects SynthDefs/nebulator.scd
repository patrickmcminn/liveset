

// nebula


/*
notes:
	input --> 8 channels (4 stereo pairs)
			- every other one inverted (multiplied by -1)
			- volumes dynamically changed
	logic -->
			- either synced to a clock, or on an "activity" value/knob
				- free - "activity" knob - scaled value between 0 and 100
						- controls a metro that sends a "1" at specified times
							- flow: (metro speed)
								/100. ---> -1. ---> *-500. ---> + 11 =
				- clock - quantized to live's clock at specified tempi
			- every time given a bang, random number generated, which is scaled by
				the range of the random number and the offset.
			- then run through the slide object, which SuperCollider could approximate with Lag
				- range= %depth (0-100) scaled by *1.27
				- offset: depthScaler = depth*1.27
					offset = 120 - depthScaler + (depthScaler/5)

	how to do this?
		- it would be nice to have  variable number of stereo pairs.
			- so maybe I can't just encapsulate the whole thing in a single SynthDef?
*/


SynthDef(\nebulator, {
	| in = 0, out = 0 trig, depth = 25, amp = 1,
	activity = 50, leftPhase = 1, rightPhase = -1, clock = 0 |
	var input, range, offset, rate, trigger, nebulaLeft, nebulaRight, left, right, sig;

	input = In.ar(in);
	range = depth * 0.01;
	offset = 0.945 - range + (range/5);
	rate = ((activity/100) -1*(-500)+11)/1000;
	trigger = Select.kr(clock, [Impulse.kr(1/rate), In.kr(trig)]);
	nebulaLeft = TRand.kr(0, range, trigger) + offset;
	nebulaRight = TRand.kr(0, range, trigger) + offset;
	nebulaLeft = nebulaLeft.linexp(0, 1.2, 0.0001, 1.2);
	nebulaRight = nebulaRight.linexp(0, 1.2, 0.0001, 1.2);
	left = input * Lag2.kr(nebulaLeft, 0.7);
	left = left * leftPhase;
	right = input* Lag2.kr(nebulaRight, 0.7);
	right = right * rightPhase;
	sig = [left, right];
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;

/*
SynthDef(\instIn, {
	|in = 0, out, amp = 1 |
	var sig = SoundIn.ar(in)*amp;
	Out.ar(out, sig);
}).add;
)

// works!
(
~bus = Bus.audio;
Synth(\instIn, [\in, 0, \out, ~bus], addAction: \addToTail);
Synth(\nebulator, [\in, ~bus, \out, 0, \depth, 76, \activity, 61], addAction: \addToTail);
)


(
var numNebula, in, activity, depth, clock, out;
in = 0;
numNebula = 16;
activity = 22;
depth = 72;
clock = 0;
out = 0;
~nebula = {
	var bus;
	bus = Bus.audio;
	~nebGroup = Group.new(s, \addToTail);
	~nebIn = Synth(\instIn, [\in, in, \out, bus], ~nebGroup, \addToTail);
	~nebs = numNebula.do({ Synth(\nebulator, [\in, bus, \out, out, \activity, activity,
			\depth, depth, \clock, clock, \phaseLeft, 1, \phaseRight, -1],
			~nebGroup, \addToTail)});
};
)

~nebula.value;
*/