/*
Sunday, November 18th 2012
back in Baltimore
pingPongDelay.scd
prm
*/


SynthDef(\pingPongDelay, {
	| in, out, delay = 0.7, decay = 6, centerFreq = 660, bw = 4, mix = 0.5, amp = 1 |

	var input, initDelay, leftDelay, rightDelay, sum, filter, dry, sig;

	input = In.ar(in);
	initDelay = DelayN.ar(input, 5, delay);
	leftDelay = CombC.ar(initDelay, 5, delay * 2, decay);

	rightDelay = CombC.ar(input, 5, delay * 2, decay);

	sum = [initDelay + leftDelay, rightDelay];

	filter = BBandPass.ar(sum, centerFreq, bw);

	dry = input * (1-mix);
	sig = filter * mix;
	sig = sig + dry;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;
