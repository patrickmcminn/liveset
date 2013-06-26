/*
Thursday, April 18th 2013
drumMachine.scd
prm
*/

~ohm.clearAll;
~ohm.addEssential;
~time = 0.25;
~drummer = r({
	var i, t, w;
	i = 0;

	loop {
		t = mod(i, 64);
		w = t/8;
		if(
			~drum[w] == 1,
			{
				{ Pan2.ar(RLPF.ar(
					WhiteNoise.ar(0.3) * EnvGen.kr(Env.perc(0.01, rrand(0.05, 0.5)), 1, doneAction: 2),
					rrand(660, 6000), 1.0.rand), 0); }.play;
				~ohm.blink(t, \lavender, ~time);
			},
			{ ~ohm.blink(t, \red, ~time); }
		);
		w.postln;
		i = i + 8;
		(~time + rrand(0.01.neg, 0.01)).wait;
	};
});
~drum = Array.fill(8, 0);
~ss = Array.fill(8);
~ss.size.do({ | i |
	~ss[i] = r({
		loop {
			~drum[i] = 1;
			~ohm.blink(i * 8, \green, ~time).yield;

			~drum[i] = 0;
			~ohm.blink(i * 8, \red, ~time).yield;
		}
	});
});
MIDIdef.cc(\drumTemp, { | val |
	var time = val.linlin(0, 127, 0.01, 0.3);
	~time = time;
	time.postln;
}, 12);
~ss.size.do({ | i |
	MIDIdef.noteOn("slot" ++ i, { ~ss[i].value }, (i * 8));
});
~drummer.play
~drummer.stop
~drummer2.stop









~time2 = 0.25;
~drummer2 = r({
	var i, t, w;
	i = 0;

	loop {
		t = mod(i, 64);
		w = t/8;
		if(
			~drum2[w] == 1,
			{
				{ Pan2.ar(RLPF.ar(
					Saw.ar([48, 50, 51, 53, 55].choose.midicps) * EnvGen.kr(Env.perc(0.01, rrand(0.3, 0.7)), 1, doneAction: 2),
					rrand(660, 6000), 1.0.rand), 0); }.play;
				~ohm.blink((t + 1), \lavender, ~time);
			},
			{ ~ohm.blink((t + 1), \red, ~time); }
		);
		w.postln;
		i = i + 8;
		(~time + rrand(0.01.neg, 0.01)).wait;
	};
});
~drum2 = Array.fill(8, 0);
~ss2 = Array.fill(8);
~ss2.size.do({ | i |
	~ss2[i] = r({
		loop {
			~drum2[i] = 1;
			~ohm.blink((i * 8) + 1, \green, ~time).yield;

			~drum2[i] = 0;
			~ohm.blink((i * 8) + 1, \red, ~time).yield;
		}
	});
});
MIDIdef.cc(\drumTemp2, { | val |
	var time = val.linlin(0, 127, 0.01, 0.3);
	~time2 = time;
	time.postln;
}, 13);
~ss2.size.do({ | i |
	MIDIdef.noteOn("slot2" ++ i, { ~ss2[i].value }, (i *8 ) + 1);
});


~drummer2.play
~drummer2.stop
~drummer.stop



~ss2[0].value

~drummer.play;
~drummer2.play;
~time = 0.1;
~time2 = 0.1;

~drummer.stop
~drummer2.stop


~drummer.play;
~drummer2.play;

~drummer.stop