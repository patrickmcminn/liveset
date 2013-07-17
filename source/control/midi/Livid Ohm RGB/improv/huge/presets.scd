/*
Tuesday, July 16th 2013
presets.scd
prm
*/

~improvOhm.huge.presets = (

	state: 0,
	presetList: [5, 13, 21, 6, 14, 22],

	spawn: { | self |
		if ( self.state == 0, { self.init; }, { self.kill; });
		self;
	},

	init: { | self |
		self.makeMIDI;
		self.state = 1;
		self;
	},

	kill: { | self |
		self.killMIDI;
		self.state = 0;
		self;
	},

	makeMIDI: { | self |
		self.presetList.do({ | num, i |
			MIDIdef.noteOn("preset" ++ (i + 1), { self.preset(i+1); }, num);
			self.makeButton(num);
		});
		self;
	},

	killMIDI: { | self |
		self.presetList.do({ | num, i |
			MIDIdef("preset" ++ (i + 1)).free;
			self.killButton(num);
		});
		self;
	},

	makeButton: { | self, num |
		~ohm.turnYellow(num);
		~restoreOhm.improv.huge.page.put(num, \yellow);
		self;
	},

	killButton: { | self, num |
		~ohm.turnOff(num);
		~restoreOhm.improv.huge.page.put(num, \off);
		self;
	},

	presetTurn: { | self, num |
		var preset = self.presetList[num - 1];
		self.presetList.do({ | num | self.makeButton(num); });
		~ohm.turnGreen(preset);
		~restoreOhm.improv.huge.put(num, \green);
		self;
	},

	preset: { | self, num |
		case
		{ num == 1 } { self.preset1; }
		{ num == 2 } { self.preset2; }
		{ num == 3 } { self.preset3; }
		{ num == 4 } { self.preset4; }
		{ num == 5 } { self.preset5; }
		{ num == 6 } { self.preset6; }
	},

	preset1: { | self |

		self.presetTurn(1);
		self;
	},

	preset2: { | self |
		self.presetTurn(2);
		self;
	},

	preset3: { | self |
		self.presetTurn(3);
		self;
	},

	preset4: { | self |
		self.presetTurn(4);
		self;
	},

	preset5: { | self |
		self.presetTurn(5);
		self;
	},

	preset6: { | self |
		self.presetTurn(6);
		self;
	},
);