/*
Sunday, June 30th 2013
interface.scd
prm
*/

var record, freeze, env, vol, trem, trig, freeAll, clearAll, singleVol, singleTremRate, singleTremDepth, rate;
record = 0;
freeze = 1;
env = 2;
vol = 3;
singleVol = 14;
singleTremRate = 13;
singleTremDepth = 12;
trem = 4;
trig = 64;
// freeAll = 55;
// clearAll = 63;
rate = 63;


~lightOhm.multiFreeze.interface = (

	state: 0,
	freezeState: Array.fill(8, 0),

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
			~ohm.turnYellow((i * 8) + record);
			~restoreOhm.light.multiFreeze.page.put(((i * 8) + record), \yellow);
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
				if ( self.freezeState[i] == 0,

					{
						~scLang.sendMsg(\lightMultiFreeze, \playFrozen, ("freeze" ++ i).asSymbol, i);
						~ohm.turnGreen((i * 8) + freeze);
						~restoreOhm.light.multiFreeze.page.put(((i * 8) + freeze), \green);
						self.freezeState[i] = 1;
					},
					{
						~scLang.sendMsg(\lightMultiFreeze, \stopFrozen, ("freeze" ++ i). asSymbol);
						~ohm.turnRed((i * 8) + freeze);
						~restoreOhm.light.multiFreeze.page.put(((i*8) + freeze), \red);
						self.freezeState[i] = 0;
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
			~ohm.turnCyan((i * 8) + env);
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

	makeVol: { | self, num = 8 |
		num.do({ | i |
			~ohm.turnPink((i * 8) + vol);
			MIDIdef.noteOn("volCntrl" ++ i, { | val |
				self.singleVolume(i);
				8.do({ | i | ~ohm.turnPink((i * 8) + vol) });
				~ohm.turnGreen((i * 8) + vol);
				~restoreOhm.light.multiFreeze.page.put((i * 8) + vol, \green);
			}, ((i * 8) + vol));
		});
		self;
	},

	killVol: { | self, num = 8 |
		num.do({ | i | MIDIdef("volCntrl" ++ i).free; });
		self;
	},

	singleVolume: { | self, num |
		MIDIdef.cc(\singleVolume, { | val |
			var amp = val.linlin(0, 127, 0.0, 1.0);
			~scLang.sendMsg(\lightMultiFreeze, \singleVolume, ("freeze" ++ num).asSymbol, amp);
			amp.postln;
		}, singleVol);
		self;
	},

	makeTrem: { | self, num = 8 |
		num.do({ | i |
			~ohm.turnLavender((i * 8) + trem);
			MIDIdef.noteOn("tremCntrl" ++ i, { | val |
				self.singleTrem(i);
				8.do({ | i | ~ohm.turnLavender((i * 8) + trem) });
				~ohm.turnGreen((i * 8) + trem);
				~restoreOhm.light.multiFreeze.page.put((i * 8) + trem, \green);
			}, ((i * 8) + trem));
		});
		self;
	},

	killTrem: { | self, num = 8 |
		num.do({ | i | MIDIdef("tremCntrl" ++ i).free; });
		self;
	},

	singleTrem: { | self, num |
		MIDIdef.cc(\singleTremRate, { | val |
			var rate = val.linexp(0, 127, 0.1, 100);
			~scLang.sendMsg(\lightMultiFreeze, \tremRate, ("freeze" ++ num).asSymbol, rate);
		}, singleTremRate);
		MIDIdef.cc(\singleTremDepth, { | val |
			var depth = val.linlin(0, 127, 0, 1);
			~scLang.sendMsg(\lightMultiFreeze, \tremDepth, ("freeze" ++ num).asSymbol, depth);
		}, singleTremDepth);
		self;
	},

	makeTrigger: { | self |
		~ohm.turnYellow(trig);
		MIDIdef.noteOn(\trigToggle, { ~scLang.sendMsg(\lightMultiFreeze, \trig); }, trig);
		self;
	},

	makeRate: { | self |
		self.makeRateMIDI;
		self.makeRateButton(1);
		self;
	},

	makeRateMIDI: { | self |
		MIDIdef(\rate, { ~light.multiFreeze.rateChange; }, 63);
		self;
	},

	makeRateButton: { | self, num |
		case
		{ num == 0.5 }
		{
			~ohm.turnBlue(rate);
			~restoreOhm.light.multiFreeze.page.put(rate, \blue);
		}
		{ num == 1 }
		{
			~ohm.turnCyan(rate);
			~restoreOhm.light.multiFreeze.page.put(rate, \cyan);
		}
		{ num == 1.5 }
		{
			~ohm.turnPurple(rate);
			~restoreOhm.light.multiFreeze.page.put(rate, \purple);
		}
		{ num == 2 }
		{
			~ohm.turnYellow(rate);
			~restoreOhm.light.multiFreeze.page.put(rate, \yellow);
		}
	},

);