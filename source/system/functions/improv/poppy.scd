/*
Monday, July 15th 2013
poppy.scd
prm
*/

~improv.poppy = (

	in: ~inst.mic,
	out: ~mixer.s3,

	state: 0,
	activeState: 1,
	triggerState: 0,

	playVol: 0.dbamp,
	atk: 0.05,
	rel: 0.05,
	lengthLo: 0.5,
	lengthHi: 1.5,

	spawn: { | self |
		if( self. state == 0, { self.init; }, { self.kill; });
		self;
	},

	init: { | self |
		self.addSynthDefs;
		self.makeOSC;
		self.makeBuffers;
		self.makeBusses;
		self.makeSynths;
		self.state = 1;
		~scLang.sendMsg(\improvControl, \poppyTop, 1);
		self;
	},

	kill: { | self |
		self.killOSC;
		self.killBuffers;
		self.killBusses;
		self.killSynths;
		if( self.triggerState == 1, { self.killTrigger; });
		~scLang.sendMsg(\improvControl, \poppyTop, 0);
		self.state = 0;
		self;
	},

	addSynthDefs: { | self |

		SynthDef(\improvPoppyTr, {
			| name, id = 1, trigger = 0, trigRate = 3, trigVal = 1 |
			var dust, impulse, trig, send;
			dust = Dust.kr(trigRate);
			impulse = Impulse.kr(trigRate);
			trig = Select.kr(trigger, [dust, impulse]);
			SendReply.kr(trig, '/improvPoppy', trigVal, id);
		}).add;

		self;
	},


	makeOSC: { | self |
		OSCdef(\improvPoppy, { | msg |
			var id, val, val2;
			id = msg.at(1);
			val = msg.at(2);
			val2 = msg.at(3);
			case
			{ val == 1 } { self.playEnv;  "trigger works".postln; }
		}, \improvPoppy);

		self;
	},

	killOSC: { | self |
		OSCdef(\improvPoppy).free;
		self;
	},

	makeBusses: { | self |
		self.verbBus = Bus.audio;
		self.thruBus = Bus.audio;
		self.faderBus = Bus.audio;
		self;
	},

	killBusses: { | self |
		self.verbBus.free;
		self.thruBus.free;
		self.faderBus.free;
		self;
	},

	makeBuffers: { | self, length = 20 |
		self.buffer = Buffer.alloc(s, s.sampleRate * length);
		self;
	},

	killBuffers: { | self |
		self.buffer.free;
		self;
	},

	makeSynths: { | self |
		self.inFader = Synth.tail(~group.fx, \fader, [\in, self.in, \out, self.verbBus, \amp, 1]);
		self.verb = Synth.tail(~group.fx, \reverb1, [\in, self.verbBus, \out, self.thruBus, \amp, 4.dbamp,
			\mix, 0.82, \room, 0.92, \damp, 0.9]);
		self.thru = Synth.tail(~group.fx, \fader, [\in, self.thruBus, \out, self.faderBus]);
		self.record = Synth.tail(~group.fx, \recordBuf,
			[\in, self.thruBus, \bufName, self.buffer, \loop, 1, \preLevel, 0.3]);
		self.fader = Synth.tail(~group.fx, \pan, [\in, self.faderBus, \out, self.out, \amp, -4.dbamp]);
		self;
	},

	killSynths: { | self |
		self.inFader.free;
		self.verb.free;
		self.record.free;
		self.fader.free;
		self;
	},

	playEnv: { | self |
		Synth.before(self.record, \playBuf,
			[
				\bufName, self.buffer, \out, self.faderBus, \rate, 1, \loop, 0, \amp, self.playVol,
				\attack, self.atk, \sustain, rrand(self.lengthLo, self.lengthHi), \release, self.rel,
				\startPos, self.buffer.numFrames * 1.0.rand
			],
		);
		self;
	},

	triggerToggle: { | self |
		if( self.triggerState == 0, { self.makeTrigger; }, { self.killTrigger; });
		self;
	},

	makeTrigger: { | self |
		self.trigger = Synth.tail(~group.control, \improvPoppyTr, [\trigRate, 0.3]);
		~scLang.sendMsg(\improvControl, \poppyTrigger, 1);
		self.triggerState = 1;
		self;
	},

	killTrigger: { | self |
		self.trigger.free;
		~scLang.sendMsg(\improvControl, \poppyTrigger, 0);
		self.triggerState = 0;
		self;
	},

	changeTrigRate: { | self, val |
		self.trigger.set(\trigRate, val);
		~scLang.sendMsg(\improvControl, \poppyTrigVal, val);
		self;
	},

	changePlayVol: { | self, val |
		self.playVol = val;
		~scLang.sendMsg(\improvControl, \poppyPlayVol, val);
		self;
	},

	clearBuffer: { | self |
		self.buffer.zero;
		~scLang.sendMsg(\improvControl, \poppyBufferClear);
		self;
	},

	muteToggle: { | self |
		if( self.activeState == 1, { self.mute; }, { self.unmute; });
		self;
	},

	mute: { | self |
		self.inFader.set(\amp, 0);
		self.activeState = 0;
		~scLang.sendMsg(\improvControl, \poppyMute, 0);
		self;
	},

	unmute: { | self |
		self.inFader.set(\amp, 1);
		self.activeState = 1;
		~scLang.sendMsg(\improvControl, \poppyMute, 1);
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

);
