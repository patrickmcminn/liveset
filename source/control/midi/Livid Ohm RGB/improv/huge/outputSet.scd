/*
Tuesday, July 16th 2013
outputSet.scd
prm
*/


~improvOhm.huge.outputSet = (

	out1: 7,
	out2: 15,
	out3: 23,

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
		~ohm.turnBlue(self.out1);
		~restoreOhm.improv.huge.page.put(self.out1, \blue);
		self.midiMake1;
		self;
	},

	midiMake1: { | self |
		MIDIdef.noteOn(\hugeOutput1, { self.set1; }, self.out1);
	},

	kill1: { | self |
		~ohm.turnOff(self.out1);
		~restoreOhm.improv.huge.page.put(self.out1, \off);
		self.midiKill1;
		self;
	},

	midiKill1: { | self |
		MIDIdef(\hugeOutput1).free;
		self;
	},

	make2: { | self |
		~ohm.turnGreen(self.out2);
		~restoreOhm.improv.huge.page.put(self.out2, \green);
		self.midiMake2;

		self;
	},

	midiMake2: { | self |
		MIDIdef.noteOn(\hugeOutput2, { self.set2; }, self.out2);
		self;
	},

	kill2: { | self |
		~ohm.turnOff(self.out2);
		~restoreOhm.improv.huge.page.put(self.out2, \off);
		self.midiKill2;
		self;
	},

	midiKill2: { | self |
		MIDIdef(\hugeOutput2).free;
		self;
	},

	make3: { | self |
		~ohm.turnBlue(self.out3);
		~restoreOhm.improv.huge.page.put(self.out3, \blue);
		self.midiMake3;
		self;
	},

	midiMake3: { | self |
		MIDIdef.noteOn(\hugeOutput3, { self.set3; },self. out3);
		self;
	},

	kill3: { | self |
		~ohm.turnOff(self.out3);
		~restoreOhm.improv.huge.page.put(self.out3, \off);
		self.midiKill3;
		self;
	},

	midiKill3: { | self |
		MIDIdef(\noiseSynthOutput3).free;
		self;
	},


	set1: { | self |
		~improv.huge.setOutput(1);
		self;
	},

	set2: { | self |
		~improv.huge.setOutput(2);
		self;
	},

	set3: { | self |
		~improv.huge.setOutput(3);
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
		~ohm.turnGreen(self.out1);
		~restoreOhm.improv.huge.page.put(self.out1, \green);
		~ohm.turnBlue(self.out2);
		~restoreOhm.improv.huge.page.put(self.out2, \blue);
		~ohm.turnBlue(self.out3);
		~restoreOhm.improv.huge.page.put(self.out3, \blue);
		self;
	},

	change2: { | self |
		self.output = 2;
		~ohm.turnGreen(self.out2);
		~restoreOhm.improv.huge.page.put(self.out2, \green);
		~ohm.turnBlue(self.out1);
		~restoreOhm.improv.huge.page.put(self.out1, \blue);
		~ohm.turnBlue(self.out3);
		~restoreOhm.improv.huge.page.put(self.out3, \blue);
		self;
	},

	change3: { | self |
		self.output = 3;
		~ohm.turnGreen(self.out3);
		~restoreOhm.improv.huge.page.put(self.out3, \green);
		~ohm.turnBlue(self.out2);
		~restoreOhm.improv.huge.page.put(self.out2, \blue);
		~ohm.turnBlue(self.out1);
		~restoreOhm.improv.huge.page.put(self.out1, \blue);
		self;
	},
);