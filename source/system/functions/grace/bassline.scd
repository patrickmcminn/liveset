/*
Monday, September 2nd 2013
bassline.scd
prm
*/

~grace.bassline = (

	state: 0,
	play1State: 0,
	play2State: 0,
	output: ~mixer.s3,

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
		self.playGroup = Group.new(self.fader, \addBefore);
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
		self.faderBus = Bus.audio;
		self;
	},

	killBusses: { | self |
		self.faderBus.free;
		self;
	},

	makeSynths: { | self |
		self.fader = Synth.tail(~group.fx, \pan, [\in, self.faderBus, \out, self.output, \amp, -6.dbamp]);
		self;
	},

	killSynths: { | self |
		self.fader.free;
		self;
	},

	makePatterns: { | self |
		Pbindef(\graceBassline1,
			\instrument, \ratioSawSus,
			\group, self.playGroup,
			\addAction, \addToTail,
			\out, self.faderBus,
			\atk, 0.05,
			\dec, 0,
			\susLvl, 1,
			\rel, 1,
			\octave, 2,
			\note, 0,
			\filterMul, 3,
			\amp, Pseq([0.9, 0.9, 1], inf),
			\dur, Pseq([4, 4, 8], inf),
			\legato, 1
		);
		Pbindef(\graceBassline2,
			\instrument, \ratioSawSus,
			\group, self.playGroup,
			\addAction, \addToTail,
			\out, self.faderBus,
			\atk, 0.05,
			\dec, 0,
			\susLvl, 1,
			\rel, 0.05,
			\legato, 1,
			\octave, 2,
			\note, Pseq([Pseq([0, 2, 4], 2), Pseq([0, 2, -2], 1)], inf),
			\filterMul,Pseq([Pseq([3, 3, 3], 2), Pseq([3, 3, 4], 1)], inf),
			\amp, Pseq([0.9, 0.9, 1], inf),
			\dur, Pseq([4.5, 4.5, 9], inf) + Pwhite(-0.3, 0.3),
		);
		self;
	},

	killPatterns: { | self |
		Pbindef(\graceBassline2).clear;
		Pbindef(\graceBassline1).clear;
		self;
	},

	togglePattern1: { | self |
		if ( self.play1State == 0, { self.playPattern1; }, { self.stopPattern1; });
		self;
	},

	playPattern1: { | self |
		Pbindef(\graceBassline1).play;
		self.play1State = 1;
		self;
	},

	stopPattern1: { | self |
		Pbindef(\graceBassline1).stop;
		self.play1State = 0;
		self;
	},

	togglePattern2: { | self |
		if ( self.play2State == 0, { self.playPattern2; }, { self.stopPattern2; });
		self;
	},

	playPattern2: { | self |
		Pbindef(\graceBassline2).play;
		self.play2State = 1;
		self;
	},

	stopPattern2: { | self |
		Pbindef(\graceBassline2).stop;
		self.play2State = 0;
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
