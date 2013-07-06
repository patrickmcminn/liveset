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
			//MIDIdef.noteOn("preset" ++ (i + 1), { ~scLang.sendMsg(\lightMultiFreeze, \preset, (i + 1)) }, num);
			MIDIdef.noteOn("preset" ++ (i + 1), { self.preset(i+1); }, num);
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
		~light.multiFreeze.groupTremDepth(0.5);
		~light.multiFreeze.tremRateSingle(\freeze1, exprand(1.0, 10.0));
		~light.multiFreeze.tremRateSingle(\freeze2, exprand(1.0, 10.0));
		~light.multiFreeze.tremRateSingle(\freeze3, exprand(1.0, 10.0));
		~light.multiFreeze.tremRateSingle(\freeze4, exprand(1.0, 10.0));
		~light.multiFreeze.tremRateSingle(\freeze5, exprand(1.0, 10.0));
		~light.multiFreeze.tremRateSingle(\freeze6, exprand(1.0, 10.0));
		~light.multiFreeze.tremRateSingle(\freeze7, exprand(1.0, 10.0));
		~light.multiFreeze.tremRateSingle(\freeze8, exprand(1.0, 10.0));
		self;
	},

	preset2: { | self |

		self;
	},

	preset3: { | self |

		self;
	},

	preset4: { | self |

		self;
	},

	preset5: { | self |

		self;
	},

	preset6: { | self |

		self;
	},
);