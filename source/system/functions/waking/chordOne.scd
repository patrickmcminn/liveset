/*
Sunday, March 17th 2013
chordOne.scd
prm
*/

~waking[\chordOne] = (

	state: 0,
	chordState: 0,
	muteState: 0,

	path: PathName(
		PathName(
			PathName(
				PathName(
					PathName(
						PathName(
							PathName(
								thisProcess.nowExecutingPath.dirname).parentPath
						).parentPath
					).parentPath
				).parentPath
			).parentPath
		).parentPath

	).parentPath ++ "data/sampled/Waking/chord 1.aif",


	makeOSC: { | self |
		OSCdef(\wakingChordOne, { | msg |

			var id, val1;
			id = msg.at(1);
			val1 = msg.at(2);

			case
			{ id == \main } { self.spawn; }
			{ id == \volume } { self.fader.set(\amp, val1); }
			{ id == \chord } { self.chordToggle; }

		}, \wakingChordOne);

		self;
	},

	killOSC: { | self, name |
		OSCdef(\wakingChordOne).free;
		self;
	},

	spawn: { | self |
		if( self.state == 0,
			{ self.init; },
			{ self.kill }
		);
		self;
	},

	init: { | self, amp = 0.3|
		self.state = 1;

		self.makeBuffers;
		self.makeGroups;
		self.makeBusses;
		self.makeSynths(amp);
		self;
	},

	kill: { | self |
		self.state = 0;

		self.killBuffers;
		self.killGroups;
		self.killBusses;
		self.killSynths;

		self;
	},

	makeBuffers: { | self |
		self.buffer = Buffer.read(s, self.path);
		self;
	},

	killBuffers: { | self |
		self.buffer.free;
		self;
	},

	makeGroups: { | self |
		self.chordGroup = Group.new(~group[\synths], \addToTail);
		self;
	},

	killGroups: { | self |
		self.chordGroup.free;
		self;
	},

	makeBusses: { | self |
		self.faderBus = Bus.audio;
		self.postFaderBus = Bus.audio;
		self.filterOut = Bus.audio;
		self;
	},

	killBusses: { | self |
		self.faderBus.free;
		self.postFaderBus.free;
		self.filterOut.free;
		self;
	},

	makeSynths: { | self, amp = 0.3 |
		self.fader = Synth(\fader, [\in, self.faderBus, \out, self.postFaderBus, \amp, amp], self.chordGroup, \addToTail);
		self.filterSend = Synth(\fader, [\in, self.postFaderBus, \out, self.filterOut, \amp, 1], self.chordGroup, \addToTail);
		self.postFader = Synth(\pan, [\in, self.postFaderBus, \out, ~mixer[\s1], \amp, 1], self.chordGroup, \addToTail);

		self;
	},

	killSynths: { | self |
		self.fader.free;
		self.filterSend.free;
		self.postFader.free;
		self;
	},

	makeChord: { | self |
		self.chordState = 1;
		self.chord = Synth(\warpEnv, [\out, self.faderBus, \bufName, self.buffer, \attack, 12, \release, 9, \amp, 1,
			\cutoff, 15000, \hiCutoff, 220], self.chordGroup, \addToHead);
		self;
	},

	killChord: { | self |
		self.chordState = 0;
		self.chord.set(\gate, 0);
		self;
	},

	chordToggle: { | self  |
		if( self.chordState == 0,
			{ self.makeChord; },
			{ self.killChord; }
		);
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
