/*
Friday, June 28th 2013
multiFreeze.scd
prm
*/

~light.multiFreeze = (

	state: 0,
	triggerState: 0,

	input: ~inst.mute,
	output: ~mixer.s2,
	state: 0,
	toggle: 1,
	trigRate: 0.05,

	susAtk: 0.01,
	susDec: 0,
	susSus: 1,
	susRel: 6,
	amp: 0.2,

	atk: 5,
	sus: 0,
	rel: 0.01,
	curve: -12,
	envAmp: 0.2,

	tremRate: 0,
	tremDepth: 0,

	spawn: { | self |
		if( self.state == 0, { self.init }, { self.kill; } );
		self;
	},

	init: { | self |
		self.makeBuffers;
		self.makeBusses;
		self.makeSynths;
		self.makeGroups;
		self.state = 1;
		~scLang.sendMsg(\lightControl, \multiFreeze);
		self;
	},

	kill: { | self |
		self.freeAll;
		//self.triggerGroup.freeAll;
		self.killBuffers;
		self.killBusses;
		self.killSynths;
		self.killGroups;
		self.state = 0;
		~scLang.sendMsg(\lightControl, \multiFreeze);
		self;
	},

	makeOSC: { | self |
		OSCdef(\lightMultiFreeze, { | msg |
			var id, val, val2;
			id = msg.at(1);
			val = msg.at(2);
			val2 = msg.at(3);
			msg.postln;
			case
			{ id == \main } { self.spawn }
			{ id == \output } { self.setOutput(val); }
			{ id == \volume } { self.fader.set(\amp, val); }
			{ id == \singleVolume } { self[val.asSymbol].set(\amp, val2); }
			{ id == \cutoff } { self.filter.set(\cutoff, val); }
			{ id == \record } { self.record(val); }
			{ id == \playFrozen } { self.playFrozen(val, val2); }
			{ id == \stopFrozen } { self.stopFrozen(val); }
			{ id == \playEnv } { self.playEnv(val); }
			{ id == \tremRate } { self.tremRateSingle(val, val2); }
			{ id == \tremDepth } { self.tremDepthSingle(val, val2); }
			{ id == \groupTremRate } { self.groupTremRate(val); }
			{ id == \groupTremDepth } { self.groupTremDepth(val); }
			{ id == \trig } { self.triggers(val); }
			{ id == \trigRate } { self.trigRateChange(val); }
			{ id == \trigSet } { self.trigGroup.set(\trigger, val); }
			{ id == \susAtk } { self.susAtk = val; }
			{ id == \susRel } { self.susRel = val; }
			{ id == \atk } { self.atk = val; }
			{ id == \sus } { self.sus = val; }
			{ id == \rel } { self.rel = val; }
			{ id == \curve } { self.curve = val; }
			{ val == 1 } { self.playEnv(val2); }
		}, \lightMultiFreeze);

		self;
	},

	killOSC: { | self |
		OSCdef(\lightMultiFreeze).free;
		self;
	},

	makeBuffers: { | self |
		self.buffer = Buffer.allocConsecutive(8, s, s.sampleRate * 0.5, 1);
		self;
	},

	killBuffers: { | self |
		self.buffer.size.do({ | i | self.buffer[i].free; });
		self;
	},

	makeBusses: { | self |
		self.filterBus = Bus.audio(s, 2);
		self.faderBus = Bus.audio(s, 2);
		self;
	},

	killBusses: { | self  |
		self.filterBus.free;
		self.faderBus.free;
		self;
	},

	makeSynths: { | self |
		self.filter = Synth(\lowPassFilterS, [\in, self.filterBus, \out, self.faderBus, \cutoff, 15000], ~group.fx, \addToTail);
		self.fader = Synth(\stereoFader, [\in, self.faderBus, \out, self.output, \amp, -6.dbamp], ~group.fx, \addToTail);
		self;
	},

	killSynths: { | self |
		self.filter.free;
		self.fader.free;
		self;
	},

	makeGroups: { | self |
		self.freezeGroup = Group.new(self.filter, \addBefore);
		self.trigGroup = Group.new(~group.control, \addToTail);
		self;
	},

	killGroups: { | self |
		self.freezeGroup.free;
		self.trigGroup.free;
		self;
	},

	muteToggle: { | self |
		if ( self.toggle == 1, { self.mute; }, { self.unmute; });
		self;
	},

	mute: { | self |
		self.toggle = 1;
		self.fader.set(\mute, 1);
		self;
	},

	unmute: { | self |
		self.toggle = 0;
		self.fader.set(\mute, 0);
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
		~scLang.sendMsg(\lightControl, \multiFreezeChangeOutput, 1);
		self;
	},

	set2: { | self |
		self.output = ~mixer.s2;
		self.fader.set(\out, self.output);
		~scLang.sendMsg(\lightControl, \multiFreezeChangeOutput, 2);
		self;
	},

	set3: { | self |
		self.output = ~mixer.s3;
		self.fader.set(\out, self.output);
		~scLang.sendMsg(\lightControl, \multiFreezeChangeOutput, 3);
		self;
	},

	record: { | self, bufNum |
		Synth(\recordBuf, [\in, self.input, \bufName, self.buffer[bufNum]], self.freezeGroup, \addToTail);
		~scLang.sendMsg(\lightControl, \record, bufNum);
		self;
	},

	playFrozen: { | self, name, bufNum |
		self.put(name.asSymbol,
			Synth(\freezePlayerSus, [\buffer, self.buffer[bufNum], \out, self.filterBus, \amp, self.amp,
				\atk, self.susAtk, \rel, self.susRel, \sus, self.susSus, \dec, self.susDec,
				\tremRate, self.tremRate, \tremDepth, self.tremDepth],
				self.freezeGroup, \addToTail)
		);
		~scLang.sendMsg(\lightControl, \multiFreezePlay, name.asSymbol);
		self;
	},

	stopFrozen: { | self, name |
		self[name.asSymbol].set(\gate, 0);
		~scLang.sendMsg(\lightControl, \multiFreezeStop, name.asSymbol);
		self;
	},

	releaseAll: { | self |
		self.freezeGroup.set(\gate, 0);
		self;
	},

	freeAll: { | self |
		self.freezeGroup.freeAll;
		self;
	},

	clearAll: { | self |
		self.buffer.size.do({ | i | self.buffer[i].free; });
		self;
	},

	tremRateSingle: { | self, name, rate |
		self[name.asSymbol].set(\tremRate, rate);
		self;
	},

	tremDepthSingle: { | self, name, depth |
		self[name.asSymbol].set(\tremDepth, depth);
		self;
	},

	groupTremRate: { | self, rate |
		self.freezeGroup.set(\tremRate, rate);
		self.tremRate = rate;
		self;
	},

	groupTremDepth: { | self, depth |
		self.freezeGroup.set(\tremDepth, depth);
		self.tremDepth = depth;
	},

	triggers: { | self |
		if ( self.triggerState == 0, { self.makeTriggers }, { self.killTriggers});
		self;
	},

	makeTriggers: { | self, num = 8 |
		num.do({ | i |
			Synth(\lightFreezeTr, [\trigRate, self.trigRate, \trigVal, i], self.trigGroup, \addToTail);
		});
		~scLang.sendMsg(\lightControl, \multiFreezeTrigger, 1);
		self.triggerState = 1;
		self;
	},

	killTriggers: { | self |
		self.trigGroup.freeAll;
		~scLang.sendMsg(\lightControl, \multiFreezeTrigger, 0);
		self.triggerState = 0;
		self;
	},

	trigRateChange: { | self, rate |
		self.trigRate = rate;
		self.trigGroup.set(\trigRate, rate);
		self;
	},

	playEnv: { | self, bufNum |
		Synth(\freezePlayer, [\buffer, self.buffer[bufNum], \out, self.filterBus,
			\atk, self.atk, \sus, self.sus, \rel, self.rel, \amp, self.envAmp],
			self.freezeGroup, \addToTail);
		self;
	},
)