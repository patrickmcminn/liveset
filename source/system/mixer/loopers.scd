/*
Thursday, June 13th 2013
loopers.scd
prm
*/

~looper = (

	init: { | self |
		self.makeBuffers;
		self.makeBusses;
		self.makeSynths;
		self.makeOSC;
		self;

	},

	kill: { | self |
		self.killBuffers;
		self.killBusses;
		self.killSynths;
		self.killOSC;
		self;

	},

	makeOSC: { | self |
		OSCdef(\looper, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case

			{ id == \s1Loop } { self.s1Loop; }
			{ id == \s2Loop } { self.s2Loop; }
			{ id == \s3Loop } { self.s3Loop; }
			{ id == \masterLoop } { self.masterLoop }

			{ id == \s1Reset } { self.s1Reset }
			{ id == \s2Reset } { self.s2Reset }
			{ id == \s3Reset } { self.s3Reset }
			{ id == \masterReset } { self.masterReset }

			{ id == \s1Vol } { self.s1.set(\amp, val); }
			{ id == \s2Vol } { self.s2.set(\amp, val); }
			{ id == \s3Vol } { self.s3.set(\amp, val); }
			{ id == \masterVol } { self.master.set(\amp, val); }

			{ id == \s1Beat } { self.s1Beat.value; }
			{ id == \s2Beat } { self.s2Beat.value; }
			{ id == \s3Beat } { self.s3Beat.value; }
			{ id == \masterBeat } { self.masterBeat.value; }

			{ id == \s1Grain } { self.s1.set(\grainsize, val); }
			{ id == \s2Grain } { self.s2.set(\grainsize, val); }
			{ id == \s3Grain } { self.s3.set(\grainsize, val); }
			{ id == \masterGrain } { self.master.set(\grainsize, val); }


		}, \looper, ~scLang)
	},

	killOSC: { | self |
		OSCdef(\looper).free;
		self;
	},

	makeBuffers: { | self |
		self.masterBuf = Buffer.alloc(s, s.sampleRate * 10, 2);
		self.s1Buf = Buffer.alloc(s, s.sampleRate * 10, 2);
		self.s2Buf = Buffer.alloc(s, s.sampleRate * 10, 2);
		self.s3Buf = Buffer.alloc(s, s.sampleRate * 10, 2);
		self;
	},

	killBuffers: { | self |
		self.masterBuf.free;
		self.s1Buf.free;
		self.s2Buf.free;
		self.s3Buf.free;
		self;
	},

	makeBusses: { | self |

	},

	killBusses: { | self |

	},

	makeSynths: { | self |
		self.master = Synth(\looper, [\in, ~mixer[\master], \out, 0, \amp, 0.5, \buffer, self.masterBuf],
			~mixerSynth[\master], \addBefore);
		self.s1 = Synth(\looper, [\in, ~mixer[\s1], \out, ~mixer[\master], \amp, 0.5, \buffer, self.s1Buf],
			~group[\audioFader], \addToHead);
		self.s2 =Synth(\looper, [\in, ~mixer[\s2], \out, ~mixer[\master], \amp, 0.5, \buffer, self.s2Buf],
			~group[\audioFader], \addToHead);
		self.s3 = Synth(\looper, [\in, ~mixer[\s3], \out, ~mixer[\master], \amp, 0.5, \buffer, self.s3Buf],
			~group[\audioFader], \addToHead);
		["looper synths created"].postln;
		self;
	},

	killSynths: { | self |
		self.master.free;
		self.s1.free;
		self.s2.free;
		self.s3.free;
		["looper synths freed"].postln;
		self;
	},

	masterLoop: { | self |
		self.master.set(\t_trig, 1);
		~scLang.sendMsg(\control, \masterLoop);
		["master bus loop trigger"].postln;
		self;
	},

	masterReset: { | self |
		~looper.masterBeat.reset;
		self.master.set(\t_reset, 1);
		{ self.masterBuf.zero; }.defer(0.1);
		["master bus loop cleared"].postln;
		self;
	},

	s1Loop: { | self |
		self.s1.set(\t_trig, 1);
		~scLang.sendMsg(\control, \s1Loop);
		["s1 bus loop trigger"].postln;
		self;
	},

	s1Reset: { | self |
		~looper.s1Beat.reset;
		self.s1.set(\t_reset, 1);
		{ self.s1Buf.zero; }.defer(0.1);
		["s1 bus loop cleared"].postln;
		self;
	},

	s2Loop: { | self |
		self.s2.set(\t_trig, 1);
		~scLang.sendMsg(\control, \s2Loop);
		["s2 bus loop trigger"].postln;
		self;
	},

	s2Reset: { | self |
		~looper.s2Beat.reset;
		self.s2.set(\t_reset, 1);
		{ self.s2Buf.zero; }.defer(0.1);
		["s2 bus loop cleared"].postln;
		self;
	},

	s3Loop: { | self |
		self.s3.set(\t_trig, 1);
		~scLang.sendMsg(\control, \s3Loop);
		["s3 bus loop trigger"].postln;
		self;
	},

	s3Reset: { | self |
		~looper.s3Beat.reset;
		self.s3.set(\t_reset, 1);
		{ self.s3Buf.zero; }.defer(0.1);
		["s3 bus loop cleared"].postln;
		self;
	},

);

~looper.s1Beat = r { | self |
	loop {
		["play s1 loop from beat 0"].postln;
		~looper.s1.set(\t_switch, 1);
		~looper.s1.set(\frombeat, 0);
		~scLang.sendMsg(\control, \s1LoopSwitch).yield;

		["play s1 loop from beat 1"].postln;
		~looper.s1.set(\frombeat, 1);
		~scLang.sendMsg(\control, \s1LoopSwitch).yield;

		["play s1 loop from beat 3"].postln;
		~looper.s1.set(\frombeat, 2);
		~scLang.sendMsg(\control, \s1LoopSwitch).yield;

		["play s1 loop from beat 3"].postln;
		~looper.s1.set(\frombeat, 3);
		~scLang.sendMsg(\control, \s1LoopSwitch).yield;

		["play s1 loop in entirety"].postln;
		~looper.s1.set(\t_switch, 1);
		~scLang.sendMsg(\control, \s1LoopSwitch).yield;
	}
};

~looper.s2Beat = r { | self |
	loop {
		["play s2 loop from beat 0"].postln;
		~looper.s2.set(\t_switch, 1);
		~looper.s2.set(\frombeat, 0);
		~scLang.sendMsg(\control, \s2LoopSwitch).yield;

		["play s2 loop from beat 1"].postln;
		~looper.s2.set(\frombeat, 1);
		~scLang.sendMsg(\control, \s2LoopSwitch).yield;

		["play s2 loop from beat 2"].postln;
		~looper.s2.set(\frombeat, 2);
		~scLang.sendMsg(\control, \s2LoopSwitch).yield;

		["play s2 loop from beat 3"].postln;
		~looper.s2.set(\frombeat, 3);
		~scLang.sendMsg(\control, \s2LoopSwitch).yield;

		["play s2 loop in entirety"].postln;
		~looper.s2.set(\t_switch, 1);
		~scLang.sendMsg(\control, \s2LoopSwitch).yield;
	}
};

~looper.s3Beat = r { | self |
	loop {
		["play s3 loop from beat 0"].postln;
		~looper.s3.set(\t_switch, 1);
		~looper.s3.set(\frombeat, 0);
		~scLang.sendMsg(\control, \s3LoopSwitch).yield;

		["play s3 loop from beat 1"].postln;
		~looper.s3.set(\frombeat, 1);
		~scLang.sendMsg(\control, \s3LoopSwitch).yield;

		["play s3 loop from beat 2"].postln;
		~looper.s3.set(\frombeat, 2);
		~scLang.sendMsg(\control, \s3LoopSwitch).yield;

		["play s3 loop from beat 3"].postln;
		~looper.s3.set(\frombeat, 3);
		~scLang.sendMsg(\control, \s3LoopSwitch).yield;

		["play s3 loop in entirety"].postln;
		~looper.s3.set(\t_switch, 1);
		~scLang.sendMsg(\control, \s3LoopSwitch).yield;
	}
};

~looper.masterBeat = r { | self |
	loop {
		["play master loop from beat 0"].postln;
		~looper.master.set(\t_switch, 1);
		~looper.master.set(\frombeat, 0);
		~scLang.sendMsg(\control, \masterLoopSwitch).yield;

		["play master loop from beat 1"].postln;
		~looper.master.set(\frombeat, 1);
		~scLang.sendMsg(\control, \masterSwitch).yield;

		["play master loop from beat 2"].postln;
		~looper.master.set(\frombeat, 2);
		~scLang.sendMsg(\control, \masterSwitch).yield;

		["play master loop from beat 3"].postln;
		~looper.master.set(\frombeat, 3);
		~scLang.sendMsg(\control, \masterSwitch).yield;

		["play master loop in entirety"].postln;
		~looper.master.set(\t_switch, 1);
		~scLang.sendMsg(\control, \masterSwitch).yield;
	}
};


