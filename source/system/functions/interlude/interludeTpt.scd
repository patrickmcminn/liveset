/*
Sunday, August 4th 2013
interludeTpt.scd
prm
*/

~interlude.tpt = (

	in: ~inst.mic,
	out: ~mixer.s3,

	state: 0,
	muteState: 1,

	spawn: { | self |
		if( self.state == 0, { self.init; }, { self.kill; });
		self;
	},

	init: { | self |
		self.state = 1;
		self.makeBusses;
		self.makeSynths;
		self;
	},

	kill: { | self |
		self.state = 0;
		self.killBusses;
		self.killSynths;
		self;
	},

	makeBusses: { | self |
		self.mainBus = Bus.audio;
		self.faderBus = Bus.audio(s, 2);
		self;
	},

	killBusses: { | self |
		self.mainBus.free;
		self.faderBus.free;
		self;
	},

	makeSynths: { | self |
		self.inFader = Synth.tail(~group.fx, \fader, [\in, self.in, \out, self.mainBus]);
		self.main = Synth.tail(~group.fx, \slapDist, [\in, self.mainBus, \out, self.faderBus, \amp, 1]);
		self.fader = Synth.tail(~group.fx, \stereoFader, [\in, self.faderBus, \out, self.out, \amp, -6.dbamp]);
		self;
	},

	killSynths: { | self |
		self.inFader.free;
		self.main.free;
		self;
	},

	muteToggle: { | self |
		if( self.muteState == 1, { self.mute; }, { self.unmute; });
		self;
	},

	mute: { | self |
		self.inFader.set(\mute, 0);
		self.muteState = 0;
		self;
	},

	unmute: { | self |
		self.inFader.set(\mute, 1);
		self.muteState = 1;
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