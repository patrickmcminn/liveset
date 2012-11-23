

SynthDef(\additive, { | out = 0, freq = 220, amp = 0.2, partials = 16 |
	var sines, sig;
	var partial1, partial2, partial3;
	sines = Mix.ar(
		Array.fill(16, { | i |
			var partial = i + 1;
			var amplitude = 1/partial;
			SinOsc.ar(freq * partial)*amplitude;
	}) * 4/partials);
	sig = sines * amp;
	sig = Out.ar(out, sig);
}).add;


SynthDef(\additive, {

	| out = 0, freq = 220, amp = 0.5,
	partial1Amp = 1, partial2Amp = 1, partial3Amp = 0.5, partial4Amp = 0.25, partial5Amp = 0.2, partial6Amp = 0.15,
	partial7Amp = 0.1, partial8Amp = 0.05 |

	var fund, partial2, partial3, partial4, partial5, partial6, partial7, partial8, sum, sig;

	fund = SinOsc.ar(freq) * partial1Amp;
	partial2 = SinOsc.ar(freq*2) * partial2Amp;
	partial3 = SinOsc.ar(freq*3) * partial3Amp;
	partial4 = SinOsc.ar(freq*4) * partial4Amp;
	partial5 = SinOsc.ar(freq*5) * partial5Amp;
	partial6 = SinOsc.ar(freq*6) * partial6Amp;
	partial7 = SinOsc.ar(freq*7) * partial7Amp;
	partial8 = SinOsc.ar(freq*8) * partial8Amp;

	sum = Mix.new([fund, partial2, partial3, partial4, partial5, partial6]);
	sig = sum * amp;
	sig = Out.ar(out, sig);
}).add;


(
\instrument: \additive,
\dur: 4,
\note: [-1, 0, 4, 6, 7, 9, 11, 1],
\partial1Amp: 1,
\partial2Amp: 0.2,
\partial3Amp: 0.15,
\partial4Amp: 0.1,
\partial5Amp: 0.09,
\partial6Amp: 0.08,
\partial7Amp: 0.07,
\partial8Amp: 0.05,
\octave: 5
).play

SynthDef(\hammond, {
	| out = 0, freq = 220, amp = 0.5,
	subAmp = 0.1, bassAmp = 0.1, fundAmp = 1,
	partial2Amp = 0.25, partial3Amp = 0.125, partial4Amp = 0.1, partial5Amp = 0.09, partial6Amp = 0.08, partial8Amp = 0.05,
	atk = 0.01, sus = 1, rel = 0.01 |

	var subOctave, bass, fund, octave, octaveFifth, twoOct, twoOctThird, twoOctFifth, threeOct;
	var sum, env, sig;

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
	env = EnvGen.kr(Env.linen(atk, sus, rel), doneAction: 2);
	sig = sum * env;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;

Synth(\hammond)


{ Mix.ar(SinOsc.ar(440), SinOsc.ar(660)) }.scope

{ SinOsc.ar(440) + SinOsc.ar(660) }.scope

Synth(\hammond, [\amp, 0.2, \bassAmp, 1, \subAmp, 1, \partial2Amp, 1, \partial3Amp, 1, \partial4Amp, 1, \partial5Amp, \partial6Amp, \partial8Amp, 1])

Synth(\hammond)

Pbindef(\organTest,
	\instrument, \hammond,
	\note, Pseq([0, 2, 3, 5, 7], inf),
	\dur, 0.23,
	\sus, 0.23,
	\atk, 0.01,
	\rel, 0.01
).play

Pbindef(\organTest2,
	\instrument, \hammond,
	\note, Pseq([[0, 3, 5, 10]], inf),
	\dur, 4,
	\sus, 0.5,
	\amp, 0.01
).play

Synth(\hammond, [\atk, 0.05, \rel, 0.05, \sus, 1])


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
\amp: 0.2
).play





Synth(\additive, [\amp, 1])

{ Saw.ar }.play

(
{
	| out = 0, freq = 220, amp = 0.2, partials = 16 |
	var sines, sig;

	sines = Mix.ar(Array.fill(16, { | i |
		var partial = i + 1;
		var amp = 1/partial;
		SinOsc.ar(freq * partial) * amp;
	})) * 1/partials;
	sig = sines * amp;
	sig = Out.ar(out, sig);
}.play
)

(
{
	Mix.ar(
		Array.fill(32, { | i |
			var partial = i + 1;
			var amp = 1/partial;
			SinOsc.ar(220 * partial) * amp;
	})) * 0.2;
}.play
)


SynthDef(\organ, { |out, freq=440, amp=0.1, gate=1|
    var snd;
    snd = Splay.ar(SinOsc.ar(freq*Array.geom(4,1,2), mul:1/4));
    snd = snd + SinOsc.ar(freq/2, mul:0.4)!2;
    snd = snd * EnvGen.ar(Env.asr(0.001,1,0.01), gate, doneAction:2);
    OffsetOut.ar(out, snd * amp);
}).add;

Synth(\organ)




