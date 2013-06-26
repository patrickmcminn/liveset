/*
Monday, June 24th 2013
outputSet.scd
prm
*/

var out1, out2, out3;
out1 = 73;
out2 = 66;
out3 = 74;

~improvOhm.noiseSynth.outputSet = (

	state: 0,

	spawn: { | self |
		if( self.state == 0, { self.init; }, { self.kill; });
		self;
	},

	init: { | self |
		self.state = 1;
		self.makeButtons;
		self;
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
		~restoreOhm.improv.noiseSynth.page.put(out1, \purple);
		MIDIdef.noteOn(\noiseSynthOutput1, { self.set1; }, out1);
		self;
	},

	kill1: { | self |
		~ohm.turnOff(out1);
		~restoreOhm.improv.noiseSynth.page.put(out1, \off);
		MIDIdef(\noiseSynthOutput1).free;
		self;
	},

	make2: { | self |
		~ohm.turnGreen(out2);
		~restoreOhm.improv.noiseSynth.page.put(out2, \green);
		MIDIdef.noteOn(\noiseSynthOutput2, { self.set2; }, out2);
		self;
	},

	kill2: { | self |
		~ohm.turnOff(out2);
		~restoreOhm.improv.noiseSynth.page.put(out2, \off);
		MIDIdef(\noiseSynthOutput2).free;
		self;
	},

	make3: { | self |
		~ohm.turnPurple(out3);
		~restoreOhm.improv.noiseSynth.page.put(out3, \purple);
		MIDIdef.noteOn(\noiseSynthOutput3, { self.set3; }, out3);
		self;
	},

	kill2: { | self |
		~ohm.turnOff(out3);
		~restoreOhm.improv.noiseSynth.page.put(out3, \off);
		MIDIdef(\noiseSynthOutput3).free;
		self;
	},


	set1: { | self |
		~scLang.sendMsg(\improvNoiseSynth, \output, 1);
		self;
	},

	set2: { | self |
		~scLang.sendMsg(\improvNoiseSynth, \output, 2);
		self;
	},

	set3: { | self |
		~scLang.sendMsg(\improvNoiseSynth, \output, 3);
		self;
	},

	changeOutput: { | self, val |
		case
		{ val == 1 } { self.change1; }
		{ val == 2 } { self.change2; }
		{ val == 3 } { self.change3; }
	},

	change1: { | self |
		~ohm.turnGreen(out1);
		~restoreOhm.improv.noiseSynth.page.put(out1, \green);
		~ohm.turnPurple(out2);
		~restoreOhm.improv.noiseSynth.page.put(out2, \purple);
		~ohm.turnPurple(out3);
		~restoreOhm.improv.noiseSynth.page.put(out3, \purple);
		self;
	},

	change2: { | self |
		~ohm.turnGreen(out2);
		~restoreOhm.improv.noiseSynth.page.put(out2, \green);
		~ohm.turnPurple(out1);
		~restoreOhm.improv.noiseSynth.page.put(out1, \purple);
		~ohm.turnPurple(out3);
		~restoreOhm.improv.noiseSynth.page.put(out3, \purple);
		self;
	},

	change3: { | self |
		~ohm.turnGreen(out3);
		~restoreOhm.improv.noiseSynth.page.put(out3, \green);
		~ohm.turnPurple(out2);
		~restoreOhm.improv.noiseSynth.page.put(out2, \purple);
		~ohm.turnPurple(out1);
		~restoreOhm.improv.noiseSynth.page.put(out1, \purple);
		self;
	},
);