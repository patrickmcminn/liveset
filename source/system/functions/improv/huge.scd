/*
Tuesday, July 16th 2013
huge.scd
prm
*/

~improv.huge = (

	in: ~inst.mute,
	out: ~mixer.s2,

	state: 0,
	activeState: 1,

	spawn: { | self |
		if( self.state == 0, { self.init; }, { self.kill; });
		self;
	},

	init: { | self |
		self.makeBuffers;
		self.makeBusses;
		self.makeSynths;
		~scLang.sendMsg(\improvControl, \hugeTop, 1);
		self.state = 1;
		self;
	},

	kill: { | self |
		self.killBuffers;
		self.killBusses;
		self.killSynths;
		~scLang.sendMsg(\improvControl, \hugeTop, 0);
		self.state = 0;
		self;
	},

	makeBuffers: { | self |
		self;
	},

	killBuffers: { | self |
		self;
	},

	makeBusses: { | self |
		self.hugeBus = Bus.audio;
		self;
	},

	killBusses: {  | self |
		self.hugeBus.free;
		self;
	},

	makeSynths: { | self |
		self.inFader = Synth.tail(~group.fx, \fader, [\in, self.in, \out, self.hugeBus]);
		self.main = Synth.tail(~group.fx, \huge, [\in, self.hugeBus, \out, self.faderBus, \amp, 0.5]);
		self;
	},

	killSynths: { | self |
		self.inFader.free;
		self.main.free;
		self;
	},

	muteToggle: { | self |
		if( self.activeState == 1, { self.mute; }, { self.unmute; });
		self;
	},

	mute: { | self |
		self.inFader.set(\amp, 0);
		~scLang.sendMsg(\improvControl, \hugeActive, 0);
		self.activeState = 0;
		self;
	},

	unmute: { | self |
		self.inFader.set(\amp, 1);
		~scLang.sendMsg(\improvControl, \hugeActive, 1);
		self.activeState = 1;
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
		~scLang.sendMsg(\improvControl, \poppyChangeOutput, 1);
		self;
	},

	set2: { | self |
		self.output = ~mixer.s2;
		self.fader.set(\out, self.output);
		~scLang.sendMsg(\improvControl, \poppyChangeOutput, 2);
		self;
	},

	set3: { | self |
		self.output = ~mixer.s3;
		self.fader.set(\out, self.output);
		~scLang.sendMsg(\improvControl, \poppyChangeOutput, 3);
		self;
	},

)