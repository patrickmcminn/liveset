/*
Thursday, March 21st 2013
channelStrip.scd
prm
*/

SynthDef(\channelStrip, {
	|
	in, out, amp = 0.5, active = 1,
	send1Out, send1Amp = 0,
	send2Out, send2Amp = 0,
	send3Out, send3Amp = 0,
	pan = 0
	|

	var input, send1, send2, send3, sig;

	input = In.ar(in);
	input = input * active;
	input = input * amp;

	send1 = input * send1Amp;
	send1 = Out.ar(send1Out, send1);

	send2 = input * send2Amp;
	send2 = Out.ar(send2Out, send2);

	send3 = input * send3Amp;
	send3 = Out.ar(send3Out, send3);

	sig = Pan2.ar(input, pan);
	sig = Out.ar(out, sig);
}).add;