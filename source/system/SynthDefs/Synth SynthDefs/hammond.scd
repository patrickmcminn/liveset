/*
Thursday, November 15th 2012
Brooklyn, NY
hammond.scd
prm
*/

SynthDef(\hammond, {
	| out = 0, freq = 220, amp = 0.5,
	subAmp = 0.1, bassAmp = 0.1, fundAmp = 1,
	partial2Amp = 0.25, partial3Amp = 0.125, partial4Amp = 0.1, partial5Amp = 0.09, partial6Amp = 0.08, partial8Amp = 0.05,
	cutoff = 20000, res = 0.1, dist = 1.5, noise = 0.0003, atk = 0.01, sus = 1, rel = 0.01 |

	var subOctave, bass, fund, octave, octaveFifth, twoOct, twoOctThird, twoOctFifth, threeOct;
	var sum, env, filter, sig;

	subOctave = SinOsc.ar(freq/2) * subAmp;
	bass = SinOsc.ar(freq * (3/4)) * bassAmp;
	fund = SinOsc.ar(freq) * fundAmp;
	octave = SinOsc.ar(freq * 2) * partial2Amp;
	octaveFifth = SinOsc.ar(freq * 3) * partial3Amp;
	twoOct = SinOsc.ar(freq * 4) * partial4Amp;
	twoOctThird = SinOsc.ar(freq * 5) * partial5Amp;
	twoOctFifth = SinOsc.ar(freq * 6) * partial6Amp;
	threeOct = SinOsc.ar(freq * 8) * partial8Amp;

	sum = Mix.new([ subOctave, bass, fund, octave, octaveFifth, twoOct, twoOctThird, twoOctFifth, threeOct]);
	filter = DFM1.ar(sum, cutoff, res, dist, 0, noise); 
	env = EnvGen.kr(Env.linen(atk, sus, rel), doneAction: 2);
	sig = filter * env;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;



/*
(
\instrument: \hammond,
\dur: 10,
\note: [0, 4, 7, 11],
\root: 7,
\octave: 4,
\sus: 4,
\subAmp: 0.1,
\bassAmp: 0.2,
\partial2Amp: 0.1,
\partial3Amp: 0.09,
\partial4Amp: 0.08,
\partial5Amp: 0.07,
\partial6Amp: 0.06,
\partial8Amp: 0.05,
\amp: 0.2,
\dist: 1.2,
\cutoff: 10000,
).play
*/


/*
Pbindef(\test, 
	\instrument, \hammond,
	\dur, 4,
	\note, Pseq([
			[12, 16, 19, 23],
			[9, 13, 16, 20],
			[7, 11, 14, 18],
			[2, 9, 12, 16],
			], inf),
	\root, -5,
	\octave, 4,
	\sus, 4,
	\subAmp, 0.7,
	\bassAmp, 0.1,
	\partial2Amp, 0.1,
	\partial3Amp, 0.09, 
	\partial4Amp, 0.08,
	\partial5Amp, 0.07,
	\partial6Amp, 0.06,
	\partial8Amp, 0.05,
	\amp, 0.2,
	\dist, 12,
	\cutoff, 1600
).play
*/






