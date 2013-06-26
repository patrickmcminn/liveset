/*
Saturday, June 22nd
noiseSynth.scd
prm
*/

~improv.noiseSynth = (

	state: 0,
	toggleState: 1,

	atk: 2,
	dec: 1,
	sus: 0.8,
	rel: 1,
	synthAmp: 1,

	spawn: { | self |
		if (self.state == 0, { self. init; }, { self.kill });
		~scLang.sendMsg(\control, \improvNoiseSynth);
		self;
	},

	init: { | self |
		self.state = 1;
		self.makeBusses;
		self.makeSynths;
		self.makeGroups;
	},

	kill: { | self |
		self.state = 0;
		self.freeAll;
		self.killBusses;
		self.killSynths;
		self.killGroups;
	},

	makeOSC: { | self |
		OSCdef(\improvNoiseSynth, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \main } { self.spawn; }
			{ id == \play } { self. playNote(val); }
			{ id == \stop } { self.stopNote(val); }
			{ id == \atk } { self.atk = val }
			{ id == \dec } { self.dec = val }
			{ id == \sus } { self.sus = val }
			{ id == \rel } { self.rel = val }
			{ id == \volume } { self.fader.set(\amp, val); }
			{ id == \cutoff } { self.filter.set(\cutoff, val); }
			{ id == \res } { self.filter.set(\res, val); }
			{ id == \trem } { self.tremolo.set(\freq, val); }
			{ id == \tremToggle } { self.tremToggle; }
			{ id == \output } { self.setOutput(val); }

		}, \improvNoiseSynth, ~scLang);
	},

	killOSC: { | self |
		OSCdef(\improvNoiseSynth).free;
	},

	makeGroups: { | self |
		self.synthGroup = Group.new(self.filter, \addBefore);
		self;
	},

	killGroups: { | self |
		self.synthGroup.free;
		self;
	},

	makeBusses: { | self |
		self.tremBus = Bus.control;
		self.filterBus = Bus.audio(s, 2);
		self.faderBus = Bus.audio(s, 2);
		self;
	},

	killBusses: { | self |
		self.tremBus.free;
		self.filterBus.free;
		self.faderBus.free;
		self;
	},

	makeSynths: { | self |
		self.filter = Synth(\moogLadderStereo, [\in, self.filterBus, \out, self.faderBus, \amp, 1],
			~group.fx, \addToTail);
		self.fader = Synth(\stereoFader, [\in, self.faderBus, \out, ~mixer.s2, \amp, -6.dbamp],
			~group.fx, \addToTail);
		self;
	},

	killSynths: { | self |
		self.filter.free;
		self.fader.free;
		self;
	},

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

	setOutput: { | self, out |
		case
		{ out == 1 } { self.setOutput1; }
		{ out == 2 } { self.setOutput2; }
		{ out == 3 } { self.setOutput3; }
	},

	setOutput1: { | self |
		self.fader.set(\out, ~mixer.s1);
		~scLang.sendMsg(\control, \improvNoiseSynthChangeOutput, 1);
		self;
	},

	setOutput2: { | self |
		self.fader.set(\out, ~mixer.s2);
		~scLang.sendMsg(\control, \improvNoiseSynthChangeOutput, 2);
		self;
	},

	setOutput3: { | self |
		self.fader.set(\out, ~mixer.s3);
		~scLang.sendMsg(\control, \improvNoiseSynthChangeOutput, 3);
		self;
	},

	muteToggle: { | self |
		if ( self.toggleState == 1, { self.mute; }, { self.unmute;  });
		self;
	},

	mute: { | self |
		self.toggleState = 0;
		self.fader.set(\mute, 0);
		self;
	},

	unmute: { | self |
		self.toggleState = 1;
		self.fader.set(\mute, 1);
		self;
	},
)