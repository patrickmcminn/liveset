/*
Saturday, January 12th 2012
gendy.scd
prm
*/


~gendy = (

	state: 0,
	toggleState: 1,

	gendyBus: nil,
	faderBus: nil,

	inFader: nil,
	gendy: nil,
	fader: nil,

	makeOSC: { | self, name, path, in, out, group |
		OSCdef(name.asSymbol, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \main } { self.spawn(in, out, group); }
			{ id == \toggle} { self.toggle; }
			{ id == \reset } { self.gendy.set(\shift, 0); }
			{ id == \shift } { self.gendy.set(\shift, val); }
			{ id == \volume } { self.fader.set(\amp, val); }
		}, path.asSymbol);
	},

	spawn: { | self, in, out, group |
		if ( self.state == 0,
			{ self.init(in, out, group); },
			{ self.kill; }
		);
		self;
	},

	init: { | self, in, out, group |
		self.state = 1;
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
		self.state = 0;
		self.freeBusses;
		self.freeSynths;
		self;
	},

	mute: { | self |
		self.toggleState = 0;
		self.inFader.set(\mute, 0);
		self;
	},

	unmute: { | self |
		self.toggleState = 1;
		self.inFader.set(\mute, 1);
		self;
	},

	toggle: { | self |
		if ( self.toggleState == 0,
			{ self.unmute; },
			{ self.mute; }
		);
		self;
	}

	);