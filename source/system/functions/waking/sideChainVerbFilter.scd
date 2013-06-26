/*
Friday, March 15th 2013
sideChainVerbFilter.scd
prm
*/

~sideChainVerbFilter = (

	state: 0,
	muteState: 0,

	makeOSC: { | self, name |
		OSCdef(name.asSymbol, { | msg |

			var id, val1, val2, val3;
			id = msg.at(1);
			val1 = msg.at(2);
			val2 = msg.at(2);
			val3 = msg.at(3);

			case
			{ id == \main } { self.spawn(val1, val2, val3 ); }
			{ id == \makeAutoFilter } { self.makeAutoFilter(val1, val2, val3); }
			{ id == \volume } {
				self.fader.set(\amp, val1); }
			{ id == \freq } {
				self.autoFilter.set(\freq, val1); }

		}, name.asSymbol);

		self;
	},

	killOSC: { | self, name |
		OSCdef(name.asSymbol).free;
		self;
	},

	spawn: { | self, out, sidechainIn, amp = 0.501 |
		if( self.state = 0,
			{ self.init(out, sidechainIn, amp); },
			{ self.kill }
		);
		self;
	},

	init: { | self, out, sidechainIn, amp = 0.501 |
		self.state = 1;
		self.makeGroups;
		self.makeBusses;
		self.makeSynths(out, sidechainIn, amp);
		self;
	},

	kill: { | self |
		self.state = 0;
		self.killGroups;
		self.killBusses;
		self.killSynths;

		self;
	},

	makeGroups: { | self |
		self.group = Group.new(~group[\fx], \addAfter);
		self.filterGroup = Group.new(~group[\fx],\addToTail);
		self;
	},

	killGroups: { | self |
		self.group.free;
			self.filterGroup.free;
		self;
	},

	makeBusses: { | self |
		self.verbBus = Bus.audio;
		self.filterBus = Bus.audio;
		self.compressBus = Bus.audio;
		self.faderBus = Bus.audio(s, 2);
		self;
	},

	killBusses: { | self |
		self.verbBus.free;
		self.filterBus.free;
		self.compressorBus.free;
		self.faderBus.free;
		self;
	},

	makeSynths: { | self, out, sidechainIn, amp = 0.501 |
		self.verb = Synth(\reverb, [\in, self.verbBus, \out, self.filterBus, \room, 0.9, \damp, 0.1, \amp, 1],
			self.group, \addToTail);
		self.filter = Synth(\highPassFilter, [\in, self.filterBus, \out, self.compressorBus, \cutoff, 50, \amp, 1],
			self.group, \addToTail);
		self.compressor = Synth(\sidechainCompressor, [\in, self.compressorBus, \out, self.faderBus, \sIn, sidechainIn, \amp, 1],
			self.group, \addToTail);
		self.fader = Synth(\stereoFader, [\in, self.faderBus, \out, out, \amp, amp], self.group, \addToTail);

		self;
	},

	killSynths: { | self |
		self.verb.free;
		self.filter.free;
		self.compressor.free;
		self.fader.free;
		self;
	},

	makeAutoFilter: { | self, in, out, freq |
		self.autoFilter = Synth(\autoFilter, [\in, in, \out, self.verbBus, \freq, freq, \filterType, 3,
			\modLo, 100, \modHi, 15000, \modWave, 0, \amp, 1], self.filterGroup, \addToHead);
		self;
	},

	killAutoFilter: { | self |
		self.autoFilter.free;
		self;
	},

	mute: { | self |
		self.fader.set(\mute, 0);
		self.muteState = 1;
		self;
	},

	unmute: { | self |
		self.fader.set(\mute, 1);
		self.muteState = 0;
		self;
	},

	muteToggle: { | self |
		if(
			self.muteState == 0,
			{ self.mute },
			{ self.unmute }
		);
		self;
	},


);
