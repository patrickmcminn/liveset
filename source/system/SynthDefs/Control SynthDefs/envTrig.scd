/*
Saturday, June 29th 2013
envTrig.scd
prm
*/

SynthDef(\envTrig, { // generates envelopes based on incoming triggers
	| in, trigIn, out, atk = 0.01, sus = 1, rel = 0.01, lvl = 1 |

	var input, trigger, env, sig;
	input = In.ar(in);
	trigger = In.kr(trigIn);
	env = EnvGen.kr(Env.linen(atk, sus, rel, lvl), trigger, doneAction: 2);
	sig = input * env;
	sig = Out.ar(out, sig);
}).add;

	