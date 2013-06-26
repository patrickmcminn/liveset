/*
Tuesday, June 11th 2013
looper.scd
prm
*/


// adapted from XL Looper by axl99

SynthDef(\looper, {

	|
	in, out, amp = 0.5, mix = 1,
	t_trig=0, t_reset=1, t_switch, plvl=1, ticknum=4, frombeat=0, grainsize=0, buffer
	|

	var input, dry, sig;

	var gate, time, ticklength, firsttrig, ticks, beats, grainstarts, grainlengths,
		grainend, startfrombeat, bufswitch, rlvl, playenv, player, grainer, recorder, switcher;

	var beatnum = 4;

	input = In.ar(in, 2);
	dry = input * (1 - mix);

	gate = PulseCount.kr(t_trig, t_reset) > 1;
	time = Latch.kr(Timer.kr(t_trig), gate);
	ticklength = time / (beatnum * ticknum);
	// initial trigger to set play- and recbuf to index 0
	firsttrig = Trig.kr(SetResetFF.kr(t_trig, t_reset), 0.05);

	ticks = TDuty.kr(ticklength, gate, 1) * gate;

	// triggers at each loop cycle beginning + extra trigger at start of first recording
	beats = Trig.kr(PulseCount.kr(ticks, t_reset) % (beatnum * ticknum), 0.1) + firsttrig;
	//Poll.kr(ticks, ticks);

	// values for the loopbuf and switching between it and the playbuf
	grainstarts = Array.series(beatnum, 0, (SampleRate.ir * ticklength * ticknum).round(1));
	grainlengths = [0.25, 0.5, 1, 2, 3, 4];
	startfrombeat = Select.kr(frombeat, grainstarts);
	grainend = startfrombeat + (ticklength * SampleRate.ir / Select.kr(grainsize, grainlengths)).round(1);
	bufswitch = (((PulseCount.kr(t_switch, t_reset) % 2) * 2 ) -1);

	// reclevel gate is read from controlbus index 3
	rlvl = EnvGen.kr(Env.asr(0.05, 1.0, 0.05), PulseCount.kr(t_trig, t_reset) % 2);
	playenv = EnvGen.kr(Env.asr(0.05, 1.0, 0.05), gate);

	player = PlayBuf.ar(2, buffer, BufRateScale.kr(buffer), beats, loop:1);
	grainer = LoopBuf.ar(2, buffer, BufRateScale.kr(buffer), bufswitch,
			startfrombeat, startfrombeat, grainend, 2);

	recorder = RecordBuf.ar(input <! input, buffer, recLevel: rlvl, preLevel:plvl, loop:1, trigger:beats);

	switcher = LinXFade2.ar(player, grainer, Lag.kr(bufswitch, 0.1), playenv);

	sig = (switcher * mix) + dry;
	sig = sig * amp;
	sig = Out.ar(out, sig);

}).add;


/*
b = Buffer.alloc(s, s.sampleRate * 10, 2);

a = Bus.audio;
{ Out.ar(a, SoundIn.ar(0)) }.play

c = Synth(\looper, [\in, a], addAction: \addToTail);

c.set(\t_trig, 1)
c.set(\t_reset, 1)
c.set(\buffer, b)
c.set(\amp, 1)

c.set(\t_switch, 1)

c.set(\frombeat, 2)
c.set(\grainsize, 3)
b.zero
*/

