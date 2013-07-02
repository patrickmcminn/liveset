/*
Sunday, June 30th 2013
controls.scd
prm
*/

var vol;
var susAtk, susRel, atk, sus, rel, curve;
var cutoff, tremRate, tremDepth;
var trigRate;
vol = 15;
cutoff = 17;
tremRate = 21;
tremDepth = 20;
susAtk = 9;
susRel = 8;
atk = 19;
sus = 18;
rel = 11;
curve = 10;
trigRate = 16;

~lightOhm.multiFreeze.controls = (

	toggleState: 0,

	init: { | self |
		self.makeDials;
		self.makeFaders;
		self;
	},

	kill: { | self |
		self.killDials;
		self.killFaders;
		self;
	},

	makeFaders: { | self |
		MIDIdef.cc(\multiFreezeVolume, { | val |
			var amp = val.linlin(0, 127, 0, -2.dbamp);
			~scLang.sendMsg(\lightMultiFreeze, \volume, amp);
		}, vol);
		self;
	},

	killFaders: { | self |
		MIDIdef(\multiFreezeVolume).free;
		self;
	},

	makeDials: { | self |
		self.makeADSR;
		self.makeTrem;
		self.makeFilter;
		self.makeTrigRate;
		self;
	},

	killDials: { | self |
		self.killADSR;
		self.killTrem;
		self.killFilter;
		self.killTrigRate;
		self;
	},

	makeADSR: { | self |
		MIDIdef.cc(\multiFreezeSusAtk, { | val |
			var attack = val.linlin(0, 127, 0.01, 15);
			~scLang.sendMsg(\lightMultiFreeze, \susAtk, attack);
		}, susAtk);
		MIDIdef.cc(\multiFreezeSusRel, { | val |
			var release = val.linlin(0, 127, 0.01, 60);
			~scLang.sendMsg(\lightMultiFreeze, \susRel, release);
		}, susRel);
		MIDIdef.cc(\multiFreezeAtk, { | val |
			var attack = val.linlin(0, 127, 0.01, 4);
			~scLang.sendMsg(\lightMultiFreeze, \atk, attack);
		}, atk);
		MIDIdef.cc(\multiFreezeSus, { | val |
			var sustain = val.linlin(0, 127, 0, 2);
			~scLang.sendMsg(\lightMultiFreeze, \sus, sustain);
		}, sus);
		MIDIdef.cc(\multiFreezeRel, { | val |
			var release = val.linlin(0, 127, 0.01, 4);
			~scLang.sendMsg(\lightMultiFreeze, \rel, release);
		}, rel);
		self;
	},

	killADSR: { | self |
		MIDIdef(\multiFreezeSusAtk).free;
		MIDIdef(\multiFreezeSusRel).free;
		MIDIdef(\multiFreezeAtk).free;
		MIDIdef(\multiFreezeSus).free;
		MIDIdef(\multiFreezeRel).free;
		self;
	},

	makeTrem: { | self |
		MIDIdef.cc(\multiFreezeTremRate, { | val |
			var rate = val.linexp(0, 127, 0.1, 100);
			~scLang.sendMsg(\lightMultiFreeze, \groupTremRate, rate);
		}, tremRate);
		MIDIdef.cc(\multiFreezeTremDepth, { | val |
			var depth = val.linlin(0, 127, 0, 1);
			~scLang.sendMsg(\lightMultiFreeze, \groupTremDepth, depth);
		}, tremDepth);
		self;
	},

	killTrem: { | self |
		MIDIdef(\multiFreezeTremRate).free;
		MIDIdef(\multiFreezeTremDepth).free;
		self;
	},

	makeFilter: { | self |
		MIDIdef.cc(\mutliFreezeCutoff, { | val |
			var cutoff = val.linexp(0, 127, 100, 20000);
			~scLang.sendMsg(\lightMultiFreeze, \cutoff, cutoff);
		}, cutoff);
		self;
	},

	killFilter: { | self |
		MIDIdef(\multiFreezeCutoff).free;
		self;
	},

	makeTrigRate: { | self |
		MIDIdef.cc(\trigRate, { | val |
			var rate = val.linlin(0, 127, 0, 4);
			~scLang.sendMsg(\lightMultiFreeze, \trigRate, rate);
		}, trigRate);
		self;
	},

	killTrigRate: { | self |
		MIDIdef(\trigRate).free;
		self;
	}

)