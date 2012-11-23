/*
Thursday, November 15th 2012
pianoFade.scd
prm
*/


SynthDef(\pianoFade, {
	| out, freq = 220, amp = 0.5, atk = 1, sus = 6,
	cutoff = 1500, loGain = 6|

	var decay, env, filter, loShelf, delayTime, detune, strike, hammerEnv, hammer, sum, sig;

	decay = atk + sus;
	env = EnvGen.kr(Env.linen(atk, sus, 0));
	strike = TDuty.ar(Dseq([decay], 1), doneAction: 2);
	hammerEnv = Decay2.ar(strike, 0.008, 0.004);
	sum = Mix.ar(Array.fill(3, { | i |
		detune = #[-0.05, 0, 0.05].at(i);
		delayTime = 1 / (freq + detune);
		hammer = LFNoise2.ar(1300, hammerEnv);
		CombL.ar(hammer,
			delayTime,
			delayTime,
			decay);
	}));
	filter = LPF.ar(sum, cutoff);
	loShelf = BLowShelf.ar(filter, 200, 1, loGain);
	sig = loShelf * env;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;




/*
(
// synthetic piano patch (James McCartney)
var n;
n = 6;	// number of keys playing
play({
	Mix.ar(Array.fill(n, {	// mix an array of notes
		var delayTime, pitch, detune, strike, hammerEnv, hammer;

		// calculate delay based on a random note
		pitch = (36 + 54.rand);
		strike = Impulse.ar(0.1+0.4.rand, 2pi.rand, 0.1); // random period for each key
		hammerEnv = Decay2.ar(strike, 0.008, 0.04); // excitation envelope
		Pan2.ar(
			// array of 3 strings per note
			Mix.ar(Array.fill(3, { arg i;
				// detune strings, calculate delay time :
				detune = #[-0.05, 0, 0.04].at(i);
				delayTime = 1 / (pitch + detune).midicps;
				// each string gets own exciter :
				hammer = LFNoise2.ar(3000, hammerEnv); // 3000 Hz was chosen by ear..
				CombL.ar(hammer,		// used as a string resonator
					delayTime, 		// max delay time
					delayTime,			// actual delay time
					6) 				// decay time of string
			})),
			(pitch - 36)/27 - 1 // pan position: lo notes left, hi notes right
		)
	}))
})
)

SynthDef(\piano, { // based on James McCartney's synthetic piano patch
	| out, freq = 220, amp = 0.5 |

	var delayTime, detune, strike, hammerEnv, hammer, sum, sig;

	strike = TDuty.ar(Dseq([6], 1), doneAction: 2);
	hammerEnv = Decay2.ar(strike, 0.008, 0.04); // excitation envelope
	sum = Mix.ar(Array.fill(3, { | i |
		// detune strings, calculate delay time:
		detune = #[-0.05, 0, 0.05].at(i);
		delayTime = 1 / (freq + detune);
		// each string gets own exciter:
		hammer = LFNoise2.ar(3000, hammerEnv);
		CombL.ar(hammer,
			delayTime,
			delayTime,
			6);
	}));
	sig = sum * amp;
	sig = Out.ar(out, sig);
}).add;


SynthDef(\pianoFade, {
	| out, freq = 220, amp = 0.5, atk = 1, sus = 6,
	cutoff = 1500, loGain = 6|

	var decay, env, filter, loShelf, delayTime, detune, strike, hammerEnv, hammer, sum, sig;

	decay = atk + sus;
	env = EnvGen.kr(Env.linen(atk, sus, 0));
	strike = TDuty.ar(Dseq([decay], 1), doneAction: 2);
	hammerEnv = Decay2.ar(strike, 0.008, 0.004);
	sum = Mix.ar(Array.fill(3, { | i |
		detune = #[-0.05, 0, 0.05].at(i);
		delayTime = 1 / (freq + detune);
		hammer = LFNoise2.ar(1300, hammerEnv);
		CombL.ar(hammer,
			delayTime,
			delayTime,
			decay);
	}));
	filter = LPF.ar(sum, cutoff);
	loShelf = BLowShelf.ar(filter, 200, 1, loGain);
	sig = loShelf * env;
	sig = sig * amp;
	sig = Out.ar(out, sig);
}).add;

Synth(\pianoFade)

s.meter
Pbindef(\test,
	\instrument, \pianoFade,
	\root, 7,
	\note, Pseq([
		Pseq([[-12, 0, 4, 7, 11]], 16),
		Pseq([[-15, -3, 1, 4, 8]], 16),
		Pseq([[-17, -5, -1, 2, 6]], 16),
		Pseq([[-22, -10, -6, -3]], 16)
	], inf),
	\atk, 0.12,
	\sus, 1,
	\legato, 1,
	\amp, 1,
	\octave, 4,
	\dur, 0.183,).play

Synth(\piano, [\freq, [220, 110, 440, 660, 330].choose])

TDuty
{ TDuty.ar(Dseq([0.1, 0.2, 0.4, 0.3], inf)) }.play;

{ TDuty.ar(Dseq([6], 1), doneAction: 2) }.play

*/