/*
Monday, September 2nd 2013
cluster.scd
prm
*/

~grace.cluster = (

	state: 0,
	playState: 0,
	muteState: 1,
	output: ~mixer.s2,

	spawn: { | self |
		if( self.state == 0, { self.init; }, { self.kill; });
		self;
	},

	init: { | self |
		self.makeBuffers;
		self.makeBusses;
		self.makeSynths;
		self.makeGroups;
		self.makePatterns;
		self.state = 1;
		self;
	},

	kill: { | self |
		self.killBuffers;
		self.killBusses;
		self.killSynths;
		self.killGroups;
		self.killPatterns;
		self.state = 0;
		self;
	},

	makeGroups: { | self |
		self.playGroup = Group.new(self.filter, \addBefore);
		self;
	},

	killGroups: { | self |
		self.playGroup.free;
		self;
	},

	makeBuffers: { | self |

		self;
	},

	killBuffers: { | self |

		self;
	},

	makeBusses: { | self |
		self.filterBus = Bus.audio(s, 2);
		self.faderBus = Bus.audio(s, 2);
		self;
	},

	killBusses: { | self |
		self.filterBus.free;
		self.faderBus.free;
		self;
	},

	makeSynths: { | self |
		self.filter = Synth.tail(~group.fx, \rlpfStereo, [\in, self.filterBus, \out, self.faderBus, \cutoff, 7000, \res, 1]);
		self.fader = Synth.tail(~group.fx, \stereoFader, [\in, self.faderBus, \out, self.output, \amp, -12.dbamp, \mute, 0]);
		self;
	},

	killSynths: { | self |
		self.filter.free;
		self.fader.free;
		self;
	},

	makePatterns: { | self |
		Pbindef(\graceCluster,
			\instrument, \susSampler,
			\group, self.playGroup,
			\addAction, \addToTail,
			\out, self.filterBus,
			\amp, Pwhite(0.1, 0.3, inf),
			\attack, Pwhite(3, 7, inf),
			\decay, Pwhite(0.01, 4, inf),
			\sustain, Pwhite(0.3, 1, inf),
			\release, Pwhite(9, 15, inf),
			\note, Pwhite(0, 47, inf),
			\octave, 3,
			\legato, 1.5,
			\dur, Pwhite(0.05, 0.1, inf),
			\freq, Pfunc { | ev | ev.use(ev[\freq]) },
			\buffer, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) }),
		);
		self;
	},

	killPatterns: { | self |
		Pbindef(\graceCluster).clear;
		self;
	},

	toggleCluster: { | self |
		if ( self.playState == 0, { self.playCluster}, { self.stopCluster; });
		self;
	},

	playCluster: { | self |
		Pbindef(\graceCluster).play;
		self.playState = 1;
		self;
	},

	stopCluster: { | self |
		Pbindef(\graceCluster).stop;
		self.playState = 0;
		self;
	},

	/*
	playNote: { | self, note |
		var pitch = note - 32;
		self.put(note,
			Synth(\susSampler,
				[\out, self.filterBus, \buffer, ~birdsBuf.noiseSynth[pitch],
					\attack, self.atk, \sustain, self.sus, \release, self.rel, \amp, self.synthAmp],
			self.synthGroup, \addToTail);
		);
		self;
	},

	stopNote: { | self, note |
		self[note].set(\gate, 0);
		self;
	},

	releaseAll: { | self |
		self.synthGroup.set(\gate, 0);
		self;
	},

	freeAll: { | self |
		self.synthGroup.freeAll;
		self;
	},
	*/

	toggleMute: { | self |
		if( self.muteState == 0, { self.mute; }, { self.unmute; });
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

	setOutput: { | self, output |
		case
		{ output == 1 } { self.set1; }
		{ output == 2 } { self.set2; }
		{ output == 3 } { self.set3; }
	},

	set1: { | self |
		self.output = ~mixer.s1;
		self.fader.set(\out, self.output);
		self;
	},

	set2: { | self |
		self.output = ~mixer.s2;
		self.fader.set(\out, self.output);
		self;
	},

	set3: { | self |
		self.output = ~mixer.s3;
		self.fader.set(\out, self.output);
		self;
	},

);