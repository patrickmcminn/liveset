/*
Sunday, June 30th 2013
interface.scd
prm
*/

var record, freeze, env, vol, trem, trig, freeAll, clearAll;
record = 0;
freeze = 1;
env = 2;
vol = 3;
trem = 4;
trig = 64;
freeAll = 55;
clearAll = 63;


~light.multiFreeze.interface = (

	state: 0,

	spawn: { | self |
		if ( self.state == 0, { self.init; }, { self.kill; });
		self;
	},

	init: { | self |
		self.makeButtons;
		self.makeFaders;
		self;
	},

	kill: { | self |
		self.killButtons;
		self.killFaders;
		self;
	},

	makeButtons: { | self |
		self.makeRecord;
		self.makeFrozen;
		self.makePlayEnv;
		self.makeTrigger;
		self.makeVol;
		self.makeTrem;
		self;
	},

	killButtons: { | self |
		self.killRecord;
		self.killFrozen;
		self.killPlayEnv;
		self.killTrigger;
		self.killVol;
		self.killTrem;
		self;
	},

	makeRecord: { | self, num = 8 |
		num.do({ | i |
			~ohm.turnGreen((i * 8) + record);
			MIDIdef.noteOn("record" ++ i, { ~scLang.sendMsg(\lightMultiFreeze, \record, i); }, (i * 8) + record; );
		});
		self;
	},

	killRecord: { | self, num = 8 |
		num.do({ | i |
			~ohm.turnOff((i * 8 ) + record);
			MIDIdef("record" ++ i).free;
		});
		self;
	},

	makeFrozen: { | self, num = 8 |
		num.do({ | i |
			~ohm.turnBlue((i * 8) + freeze);
			MIDIdef.noteOn("frozen" ++ i, {
				var toggle = 0;
				if ( toggle == 0,

					{
						~scLang.sendMsg(\lightMultiFreeze, \playFrozen, ("freeze" ++ i).asSymbol, i);
						~ohm.turnGreen((i * 8) + freeze);
						~restoreOhm.light.multiFreeze.page.put(((i * 8) + freeze), \green);
						toggle = 1;
					},
					{
						~scLang.sendMsg(\lightMultiFreeze, \stopFrozen, i);
						~ohm.turnRed((i * 8) + freeze);
						~restoreOhm.light.multiFreeze.page.put(((i*8) + freeze), \red);
						toggle = 0;
					}
				);

			}, (i * 8) + freeze;);
		});
		self;
	},

	killFrozen: { | self, num = 8 |
		num.do({ | i | MIDIdef("frozen" ++ i).free; });
		self;
	},

	makePlayEnv: { | self, num = 8 |
		num.do({ | i |
			~ohm.turnPurple((i * 8) + env);
			MIDIdef.noteOn("playEnv" ++ i, {
				~scLang.sendMsg(\lightMultiFreeze, \playEnv, i);
			}, (i * 8) + env);
		});
		self;
	},

	killPlayEnv: { | self, num = 8 |
		num.do({ | i | MIDIdef("playEnv" ++ i).free; });
		self;
	},
);