/*
Saturday, June 29th 2013
lightFreezeTr.scd
prm
*/

SynthDef(\lightFreezeTr, {
	| name, id = 1, trigger = 0, trigRate = 3, trigVal = 1 |
	var dust, impulse, trig, send;
	dust = Dust.kr(trigRate);
	impulse = Impulse.kr(trigRate);
	trig = Select.kr(trigger, [dust, impulse]);
	SendReply.kr(trig, '/lightMultiFreeze', trigVal, id);
}).add;
