/*
Saturday, January 19th 2013
granulator.scd
prm
*/

~granulator = (

	state: 0,
	toggleState: 1,

	inFader: nil,
	granulator: nil,
	fader: nil,

	granulatorBus: nil,
	faderBus: nil,

	makeOSC: {
		|
		self, name, path,
		in, out, group, amp = 0.5, bufLength = 3, pan = 0, panOffset = 1, grainDur = 0.1,
		grainDurOffset = 0.09, rate = 1, rateOffset = 0, pos = 0.5, posOffset = 1
		env = -1, sync = 0, trigRate = 32, granAmp = 1, overwrite = 1, mix = 1
		|

		OSCdef(name.asSymbol, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \main } { self.spawn(in, out, group, amp, bufLength, pan, panOffset, grainDur,
				grainDurOffset, rate, rateOffset, pos, posOffset, env,
				sync, trigRate, granAmp, overwrite, mix); }
			{ id == \toggle } { self.toggle; }
			{ id == \pan } { self.granulator.set(\pan, val); }
			{ id == \panOffset } { self.granulator.set(\panOffset, val); }
			{ id == \grainDur } { self.granulator.set(\grainDur, val); }
			{ id == \grainDurOffset } { self.granulator.set(\grainDurOffset, val); }
			{ id == \rate } { self.granulator.set(\rate, val); }
			{ id == \rateOffset } { self.granulator.set(\rateOffset, val); }
			{ id == \pos } { self.granulator.set(\pos, val); }
			{ id == \posOffset } { self.granualtor.set(\posOffset, val); }
			{ id == \env } { self.granulator.set(\env, val); }
			{ id == \sync } { self.granulator.set(\sync, val); }
			{ id == \trigRate } { self.granulator.set(\trigRate, val); }
			{ id == \granAmp } { self.granulator.set(\amp, val); }
			{ id == \mix } { self.granulator.set(\mix, val); }
			{ id == \volume } { self.fader.set(\amp, val); }
		}, path.asSymbol);

		self;
	},

	spawn: {
		|
		self
		in, out, group, amp = 0.5,
		bufLength = 3, pan = 0, panOffset = 1, grainDur = 0.1,
		grainDurOffset = 0.09, rate = 1, rateOffset = 0, pos = 0.5, posOffset = 1
		env = -1, sync = 0, trigRate = 32, granAmp = 1, overwrite = 1, mix = 1
		|
		if ( self.state == 0,
			{ self.init(in, out, group, amp, bufLength, pan, panOffset, grainDur,
				grainDurOffset, rate, rateOffset, pos, posOffset, env,
				sync, trigRate, granAmp, overwrite, mix); },
			{ self.kill; }
		);
		self;
	},

	init: {
		|
		self, in, out, group, amp = 0.5, bufLength = 3, pan = 0, panOffset = 1, grainDur = 0.1,
		grainDurOffset = 0.09, rate = 1, rateOffset = 0, pos = 0.5, posOffset = 1
		env = -1, sync = 0, trigRate = 32, granAmp = 1, overwrite = 1, mix = 1
		|
		self.state = 1;
		self.makeBusses;
		self.makeSynths(in, out, group, amp, bufLength, pan, panOffset, grainDur,
			grainDurOffset, rate, rateOffset, pos, posOffset, env,
			sync, trigRate, granAmp, overwrite, mix);
		self;
	},

	kill: { | self |
		self.state = 0;
		self.makeSynths;
		self.killSynths;
		self;
	},

	makeBusses: { | self |
		self.granulatorBus = Bus.audio;
		self.faderBus = Bus.audio(s, 2);
		self;
	},

	killBusses: { | self |
		self.granulatorBus.free;
		self.faderBus.free;
		self;
	},

	makeSynths: {
		|
		self, in, out, group, amp = 0.5, bufLength = 3, pan = 0, panOffset = 1, grainDur = 0.1,
		grainDurOffset = 0.09, rate = 1, rateOffset = 0, pos = 0.5, posOffset = 1
		env = -1, sync = 0, trigRate = 32, granAmp = 1, overwrite = 1, mix = 1
		|
		self.inFader = Synth(\fader, [\in, in, \out, self.granulatorBus], group, \addToTail);
		self.granulator = Synth(\granulator,
			[
				\in, self.granulatorBus, \out, self.faderBus,
				\bufLength, bufLength, \pan, pan, \panOffset, panOffset,
				\grainDur, grainDur, \grainDurOffset, grainDurOffset,
				\rate, rate, \rateOffset, rateOffset, \pos, pos,
				\posOffset, posOffset, \env, env, \sync, sync,
				\trigRate, trigRate, \amp, granAmp, \overwrite, overwrite, \mix, mix
			],
			group, \addToTail);
		self.fader = Synth(\stereoFader, [\in, self.faderBus, \out, out, \amp, amp], group, \addToTail);
		self;
	},

	killSynths: { | self |
		self.inFader.free;
		self.granulator.free;
		self.fader.free;
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
	},

);