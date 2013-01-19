/*
Saturday, January 12th 2012
gendy.scd
prm
*/

~gendy = (

	gendyBus: nil,
	faderBus: nil,

	inFader: nil,
	gendy: nil,
	fader: nil,


	init: { | self, in, out, group |
		self.makeBusses;
		self.makeSynths(in, out, group);
		self;
	},

	makeBusses: { | self |
		self.gendyBus = Bus.audio;
		self.faderBus = Bus.audio;
		self;
	},

	freeBusses: { | self |
		self.gendyBus.free;
		self.faderBus.free;
		["gendy busses freed"].postln;
		self;
	},

	makeSynths: { | self, in = 0, out = 0, group = 0|
		self.inFader = Synth(\fader, [\in, in, \out, self.gendyBus, \amp, 1.0], group, \addToTail);
		self.gendy = Synth(\gendyIn, [\in, self.gendyBus, \out, self.faderBus, \amp, 0.5], group, \addToTail);
		self.fader = Synth(\pan, [\in, self.faderBus, \out, out, \amp, 1.0], group, \addToTail);
		self;
	},

	freeSynths: { | self |
		self.inFader.free;
		self.gendy.free;
		self.fader.free;
		["gendy synths freed"].postln;
		self;
	},

	kill: { | self |
		self.freeBusses;
		self.freeSynths;
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