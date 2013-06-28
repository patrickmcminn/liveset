/*
Friday, June 28th 2013
multiFreeze.scd
prm
*/

~light.multiFreeze = (

	input: ~inst.mute,
	output: ~mixer.s2,
	state: 0,

	spawn: { | self |
		if( self.state == 0, { self.init }, { self.kill; } );
		self;
	},

	init: { | self |
		self.makeBuffers;
		self.makeBusses;
		self.makeSynths;
		self.makeGroups;
		self;
	},

	kill: { | self |
		self.killBuffers;
		self.killBusses;
		self.killSynths;
		self.killGroups;
		self;
	},

	makeOSC: { | self |
		OSCdef(\lightMultiFreeze, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			//case

		}, \lightMultiFreeze);

		self;
	},

	killOSC: { | self |
		OSCdef(\lightMultiFreeze).kill;
		self;
	},

	makeBuffers: { | self |
		self.buffer = Buffer.allocConsecutive(8, s, s.sampleRate * 0.5, 1);
		self;
	},

	killBuffers: { | self |
		self.buffer.size.do({ | i | self.buffer.[i].free; });
		self;
	},

	makeBusses: { | self |
		self.filterBus = Bus.audio;
		self.faderBus = Bus.audio;
		self;
	},

	killBusses: { | self  |
		self.filterBus.free;
		self.faderBus.free;
		self;
	},

	makeSynths: { | self |
		self.filter = Synth(\lowPassFilter, [\in, self.filterBus, \out, self.faderBus, \cutoff, 15000], ~group.fx, \addToTail);
		self.fader = Synth(\pan, [\in, self.faderBus, \out, self.output, \amp, -6.dbamp], ~group.fx, \addToTail);
		self;
	},

	killSynths: { | self |
		self.filter.free;
		self.fader.free;
		self;
	},

	makeGroups: { | self |
		self.freezeGroup = Group.new(self.filter, \addBefore);
		self;
	},

	killGroups: { | self |
		self.freezeGroup.free;
		self;
	},

	record: { | self, bufNum |
		Synth(\recordBuf, [\in, self.input, \bufName, self.buffer[bufNum]], self.freezeGroup, \addToTail);
		self;
	},

	playFrozen: { | self, name, bufNum |
		self.put(name.asSymbol,
			Synth(\freezePlayer, [\buffer, self.buffer[bufNum], \out, self.filterBus, \amp, 1],
				self.freezeGroup, \addToTail)
		);
		self;
	},

	stopFrozen: { | self, name |
		self.name.set(\gate, 0);
		self;
	},
)