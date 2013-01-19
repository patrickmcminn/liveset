/*
Monday, January 14th 2012
pings.scd
prm
*/

~pings = (

	amplitude: nil,
	scale: nil,
	inFader: nil,
	ping: nil,
	verb: nil,
	fader: nil,

	pingBus: nil,
	verbBus: nil,
	faderBus: nil,
	ampBus: nil,

	init: { | self, in, out, group, amp = 0.5, bufLength = 5, loScale = 4, hiScale = 20 |
		self.makeBusses;
		self.makeSynths(in, out, group, amp, bufLength, loScale, hiScale);
		self;
	},

	kill: { | self |
		self.freeBusses;
		self.freeSynths;
		self;
	},

	makeBusses: { | self |
		self.ampBus = Bus.control;
		self.pingBus = Bus.audio;
		self.verbBus = Bus.audio(s, 2);
		self.faderBus = Bus.audio(s, 2);
		self;
	},

	freeBusses: { | self |
		self.ampBus.free;
		self.pingBus.free;
		self.verbBus.free;
		self.faderBus.free;
		self;
	},

	makeSynths: { | self, in, out, group, amp = 0.5, bufLength = 5, loScale = 4, hiScale = 20 |
		self.amplitude = Synth(\amplitudeFollow, [\in, in, \out, self.ampBus], group, \addToTail);
		self.scale = Synth(\controlScalerLinLin, [\in, self.ampBus, \out, self.ampBus,
			\rangeInLo, 0, \rangeInHi, 0.5, \rangeOutLo, loScale, \rangeOutHi, hiScale],
			group, \addToTail);
		self.inFader = Synth(\fader, [\in, in, \out, self.pingBus], group, \addToTail);
		self.ping = Synth(\granulator,
			[
				\in, self.pingBus, \out, self.verbBus,
				\bufLength, bufLength, \sync, 1, \trigRate, self.ampBus.asMap,
				\grainDur, 0.25, \grainDurOffset, 0.1, \pan, 0, \panOffset, 0.25,
				\env, ~grainBufs.at(\perc), \amp, 1
			],
			group, \addToTail);
		self.verb = Synth(\reverb2, [\in, self.verbBus, \out, self.faderBus, \mix, 0.5, \room, 0.9,
			\damp, 0.1], group, \addToTail);
		self.fader = Synth(\stereoFader, [\in, self.faderBus, \out, out, \amp, amp],
			group, \addToTail);
		self;
	},

	freeSynths: { | self |
		self.amplitude.free;
		self.scale.free;
		self.inFader.free;
		self.ping.free;
		self.verb.free;
		self.fader.free;
		self;
	},

	mute: { | self |
		self.inFader.set(\mute, 0);
		self;
	},

	unmute: { | self |
		self.inFader.set(\mute, 1);
		self;
	}

);


/*
(// pings
~pings = {
	~pingBus = (
		\mix:	Bus.audio,
		\gran:	Bus.audio,
		\verb:	Bus.audio(s, 2),
		\amp:	Bus.control);
	~ping = (
		\violin:	Synth(\fader, [\in, ~violinIBus, \out, ~pingBus.at(\mix)], ~fx, \addToTail),
		\amp:	Synth(\amplitudeFollow, [\in, ~pingBus.at(\mix), \out, ~pingBus.at(\amp)],
					~fx, \addToTail),
		\scale:	Synth(\controlScalerLinLin, [\in, ~pingBus.at(\amp), \out, ~pingBus.at(\amp),
					\rangeInLo, 0, \rangeInHi, 0.24, \rangeOutLo, 4, \rangeOutHi, 20],
					~fx, \addToTail),
		\gran:	Synth(\granulator, [\in, ~pingBus.at(\mix), \out, ~pingBus.at(\verb),
					\bufLength, 2, \sync, 1, \trigRate, ~pingBus.at(\amp).asMap,
					\grainDur, 0.25, \grainDurOffset, 0.1, \pan, -0.25, \panOffset, 0,
					\env, ~grainBufs.at(\perc), \amp, 4], ~fx, \addToTail),
		\reverb:	Synth(\reverb2, [\in, ~pingBus.at(\verb), \out, ~fxBus, \mix, 0.5,
					\room, 0.9, \damp, 0.1],~fx, \addToTail));
};

~pingsFree = { ~pingBus.do({ | i | i.free; });  ~ping.do({ | i | i.free; }); };
);
*/