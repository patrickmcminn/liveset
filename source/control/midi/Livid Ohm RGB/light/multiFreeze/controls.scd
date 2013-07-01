/*
Sunday, June 30th 2013
controls.scd
prm
*/

var vol;
var susAtk, susRel, atk, sus, rel, curve;
var cutoff, tremRate, tremDepth;
vol = 15;
cutoff = 20;
tremRate = 13;
tremDepth = 12;
susAtk = 9;
susRel = 8;
atk = 19;
sus = 18;
rel = 11;
curve = 10;


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
		self;
	},

	killDials: { | self |
		self.killADSR;
		self.killTrem;
		self.killFilter;
		self;
	},

	makeADSR: { | self |
		MIDIdef.cc(\multiFreezeSusAtk, { | val |
			var attack = val.linlin(0, 127, 0, 15);
			~scLang.sendMsg(\lightMultiFreeze, \susAtk, attack);
		}, susAtk);
		MIDIdef.cc(\multiFreezeSusRel, { | val |
			var release = val.linlin(0, 127, 0, 60);
			~scLang.sendMsg(\lightMultiFreeze, \susRel, release);
		}, susRel);
		MIDIdef.cc(\multiFreezeAtk, { | val |
			var attack = val.linlin(0, 127, 0, 4);
			~scLang.sendMsg(\lightMultiFreeze, \atk, attack);
		}, atk);
		MIDIdef.cc(\multiFreezeSus, { | val |
			var sustain = val.linlin(0, 127, 0, 10);
			~scLang.sendMsg(\lightMultiFreeze, \sus, sustain);
		}, sus);
		MIDIdef.cc(\multiFreezeRel, { | val |
			var release = val.linlin(0, 127, 0, 20);
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
			~scLang.sendMsg(\lightMultiFreeze, \tremRate, rate);
		}, tremRate);
		MIDIdef.cc(\multiFreezeTremDepth, { | val |
			var depth = val.linexp(0, 127, 0.00000001, 1000);
			~scLang.sendMsg(\lightMultiFreeze, \tremDepth, depth);
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
			self;
		}, cutoff);
		self;
	},

	killFilter: { | self |
		MIDIdef(\multiFreezeCutoff).free;
		self;
	}

)