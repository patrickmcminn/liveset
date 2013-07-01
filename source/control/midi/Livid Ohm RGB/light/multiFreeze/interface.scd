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
		self.makeFrozen
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



);