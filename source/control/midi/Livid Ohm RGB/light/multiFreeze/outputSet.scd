/*
Sunday, June 30th 2013
outputSet.scd
prm
*/

var out1, out2, out3;
out1 = 7;
out2 = 15;
out3 = 23;

~lightOhm.multiFreeze.outputSet = (

	state: 0,
	output: 2,

	spawn: { | self |
		if( self.state == 0, { self.init; }, { self.kill; });
		self;
	},

	init: { | self |
		self.state = 1;
		self.makeButtons;
		case
		{ self.output == 1 } { self.change1; }
		{ self.output == 2 } { self.change2; }
		{ self.output == 3 } { self.change3; }
	},

	kill: { | self |
		self.state = 0;
		self.killButtons;
		self;
	},

	makeButtons: { | self |
		self.make1;
		self.make2;
		self.make3;
		self;
	},

	killButtons: { | self |
		self.kill1;
		self.kill2;
		self.kill3;
		self;
	},

	make1: { | self |
		~ohm.turnPurple(out1);
		~restoreOhm.light.multiFreeze.page.put(out1, \purple);
		self.midiMake1;
		self;
	},

	midiMake1: { | self |
		MIDIdef.noteOn(\multiFreezeOutput1, { self.set1; }, out1);
	},

	kill1: { | self |
		~ohm.turnOff(out1);
		~restoreOhm.light.multiFreeze.page.put(out1, \off);
		self.midiKill1;
		self;
	},

	midiKill1: { | self |
		MIDIdef(\multiFreezeOutput1).free;
		self;
	},

	make2: { | self |
		~ohm.turnGreen(out2);
		~restoreOhm.light.multiFreeze.page.put(out2, \green);
		self.midiMake2;

		self;
	},

	midiMake2: { | self |
		MIDIdef.noteOn(\multiFreezeOutput2, { self.set2; }, out2);
		self;
	},

	kill2: { | self |
		~ohm.turnOff(out2);
		~restoreOhm.light.multiFreeze.page.put(out2, \off);
		self.midiKill2;
		self;
	},

	midiKill2: { | self |
		MIDIdef(\multiFreezeOutput2).free;
		self;
	},

	make3: { | self |
		~ohm.turnPurple(out3);
		~restoreOhm.light.multiFreeze.page.put(out3, \purple);
		self.midiMake3;
		self;
	},

	midiMake3: { | self |
		MIDIdef.noteOn(\multiFreezeOutput3, { self.set3; }, out3);
		self;
	},

	kill3: { | self |
		~ohm.turnOff(out3);
		~restoreOhm.light.multiFreeze.page.put(out3, \off);
		self.midiKill3;
		self;
	},

	midiKill3: { | self |
		MIDIdef(\multiFreezeOutput3).free;
		self;
	},


	set1: { | self |
		~scLang.sendMsg(\lightMultiFreeze, \output, 1);
		self;
	},

	set2: { | self |
		~scLang.sendMsg(\lightMultiFreeze, \output, 2);
		self;
	},

	set3: { | self |
		~scLang.sendMsg(\lightMultiFreeze, \output, 3);
		self;
	},

	changeOutput: { | self, val |
		case
		{ val == 1 } { self.change1; }
		{ val == 2 } { self.change2; }
		{ val == 3 } { self.change3; }
	},

	change1: { | self |
		self.output = 1;
		~ohm.turnGreen(out1);
		~restoreOhm.light.multiFreeze.page.put(out1, \green);
		~ohm.turnPurple(out2);
		~restoreOhm.light.multiFreeze.page.put(out2, \purple);
		~ohm.turnPurple(out3);
		~restoreOhm.light.multiFreeze.page.put(out3, \purple);
		self;
	},

	change2: { | self |
		self.output = 2;
		~ohm.turnGreen(out2);
		~restoreOhm.light.multiFreeze.page.put(out2, \green);
		~ohm.turnPurple(out1);
		~restoreOhm.light.multiFreeze.page.put(out1, \purple);
		~ohm.turnPurple(out3);
		~restoreOhm.light.multiFreeze.page.put(out3, \purple);
		self;
	},

	change3: { | self |
		self.output = 3;
		~ohm.turnGreen(out3);
		~restoreOhm.light.multiFreeze.page.put(out3, \green);
		~ohm.turnPurple(out2);
		~restoreOhm.light.multiFreeze.page.put(out2, \purple);
		~ohm.turnPurple(out1);
		~restoreOhm.light.multiFreeze.page.put(out1, \purple);
		self;
	},
);