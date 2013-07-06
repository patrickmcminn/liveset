/*
Saturday, July 6th 2013
presets.scd
prm
*/

~lightOhm.multiFreeze.presets = (

	state: 0,
	preset: [5, 13, 21, 6, 14, 22],

	spawn: { | self |
		if ( self.state == 0, { self.init; }, { self.kill; });
		self;
	},

	init: { | self |
		self.makeMIDI;
		self;
	},

	kill: { | self |
		self.killMIDI;
		self;
	},

	makeMIDI: { | self |
		self.preset.do({ | num, i |
			MIDIdef.noteOn("preset" ++ (i + 1), { ~scLang.sendMsg(\lightMultiFreeze, \preset, (i + 1)) }, num);
			self.makeButton(num);
		});
		self;
	},

	killMIDI: { | self |
		self.preset.do({ | num, i |
			MIDIdef("preset" ++ (i + 1)).free;
			self.killButton(num);
		});
		self;
	},

	makeButton: { | self, num |
		~ohm.turnYellow(num);
		~restoreOhm.light.multiFreeze.page.put(num, \yellow);
		self;
	},

	killButton: { | self, num |
		~ohm.turnOff(num);
		~restoreOhm.light.multiFreeze.page.put(num, \off);
		self;
	},

	presetTurn: { | self, num |
		var preset = self.preset[num - 1];
		self.preset.do({ | num | self.makeButton(num); });
		~ohm.turnGreen(preset);
		~restoreOhm.light.multiFreeze.page.put(num, \green);
		self;
	}


);


	