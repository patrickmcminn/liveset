/*
Wednesday, March 27th 2013
filterB.scd
prm
*/

~waking[\filterB] = (

	state: 0,
	muteState: 0,

	makeOSC: { | self  |
		OSCdef(\wakingFilterB, { | msg |

			var id, val1;
			id = msg.at(1);
			val1 = msg.at(2);

			case
			{ id == \main } { self.spawn; }
			{ id == \makeAutoFilter } { self.makeAutoFilter; }
			{ id == \volume } { self.fader.set(\amp, val1); }
			{ id == \freq } { self.autoFilter.set(\freq, val1); }
			{ id == \rangeLo } { self.autoFilter.set(\rangeLo, val1); }
			{ id == \rangeHi } { self.autoFilter.set(\rangeHi, val1); }

		}, \wakingFilterB);

		self;
	},

	killOSC: { | self, name |
		OSCdef(\wakingFilterB).free;
		self;
	},

	spawn: { | self |
		if( self.state == 0,
			{ self.init; },
			{ self.kill; }
		);
		self;
	},

	init: { | self |
		self.state = 1;
		self.makeGroups;
		self.makeBusses;
		self.makeSynths;
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
		self.faderGroup = Group.new(~group[\fx], \addAfter);
		self.filterGroup = Group.new(self.faderGroup,\addToHead);
		self;
	},

	killGroups: { | self |
		self.group.free;
			self.filterGroup.free;
		self;
	},

	makeBusses: { | self |
		self.autoFilterBus = Bus.audio(s, 2);
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

	makeSynths: { | self, amp = 10 |
		self.verb = Synth(\reverb1, [\in, self.verbBus, \out, self.filterBus, \room, 0.75, \damp, 0.1, \amp, 1],
			self.faderGroup, \addToTail);
		self.filter = Synth(\highPassFilter, [\in, self.filterBus, \out, self.compressorBus, \cutoff, 50, \amp, 1],
			self.faderGroup, \addToTail);
		self.compressor = Synth(\sidechainCompressor, [\in, self.compressorBus, \out, self.faderBus,
			\amp, 1],
			self.faderGroup, \addToTail);
		self.fader = Synth(\pan, [\in, self.faderBus, \out, ~mixer[\s3], \amp, amp],
			self.faderGroup, \addToTail);

		self;
	},

	killSynths: { | self |
		self.verb.free;
		self.filter.free;
		self.compressor.free;
		self.fader.free;
		self;
	},

	makeAutoFilter: { | self, freq = 0.03  |
		self.autoFilter = Synth(\autoFilter, [\in, self.autoFilterBus, \out, self.verbBus, \freq, freq, \filterType, 2,
			\modLo, 50, \modHi, 2000, \modWave, 0, \amp, 1, \rq, 1.219], self.filterGroup, \addToHead);
		self.chordOneIn = Synth(\fader, [\in, ~waking[\chordOne].filterOut, \out, self.autoFilterBus],
			self.filterGroup, \addToHead);
		self.chordTwoIn = Synth(\fader, [\in, ~waking[\chordTwo].filterOut, \out, self.autoFilterBus],
			self.filterGroup, \addToHead);
		self;
	},

	killAutoFilter: { | self |
		self.chordOneIn.free;
		self.chordTwoIn.free;
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
