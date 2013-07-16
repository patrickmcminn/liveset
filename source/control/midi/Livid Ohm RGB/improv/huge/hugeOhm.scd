/*
Tuesday, July 16th 2013
hugeOhm.scd
prm
*/

~improvOhm.huge = (

	main: 5,
	toggle: 13,
	page: 21,

	vol: 15,
	cutoffRate: 19,

	makeOSC: { | self |

		OSCdef(\hugeOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \hugeTop } { self.spawn(val); }
			{ id == \hugeActive } { self.toggleOhm(val); }

		}, \improvControl, ~scLang);

		OSCdef(\hugeOhmRestore, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \hugeToggle } { if( val == 1, { self.makeToggleMIDI; })}
			{ id == \hugePage } { if( val == 1, { self.makePageMIDI; })}
			{ id == \hugeVolume } { if ( val == 1, { self.makeVolume;}) }
			{ id == \hugeCutoffRate } { if ( val == 1, { self.makeCutoffRate; }) }
		}, \restoreOhmImprov, ~scLang);

		self;
	},

	killOSC: { | self |
		OSCdef(\hugeOhm).free;
		OSCdef(\hugeOhmRestore).free;
		self;
	},

	spawn: { | self, val |
		if( val == 1, { self.init; }, { self.kill; });
		self;
	},

	init: { | self |
		self.makeButtons;
		self.makeFaders;
		self.makeDials;
		self;
	},

	kill: { | self |
		self.killButtons;
		self.killFaders;
		self.killDials;
		self;
	},

	makeButtons: { | self |
		self.topOhm(1);
		self.makeToggle;
		self.makePage;
		self;
	},

	killButtons: { | self |
		self.topOhm(0);
		self.killToggle;
		self.killPage;
		self;
	},

	topOhm: { | self, val |
		if( val == 1,
			{
				~ohm.turnBlue(self.main);
				~restoreOhm.improv.page.put(self.main, \blue);
			},
			{
				~ohm.turnRed(self.main);
				~restoreOhm.improv.page.put(self.main, \red);
			}
		);
		self;
	},

	makeToggle: { | self |
		~ohm.turnGreen(self.toggle);
		~restoreOhm.improv.page.put(self.toggle, \green);
		self.makeToggleMIDI;
		~restoreOhm.improv.hugeToggle = 1;
		self;
	},

	killToggle: { | self |
		~ohm.turnOff(self.toggle);
		~restoreOhm.improv.page.put(self.toggle, \off);
		self.killToggleMIDI;
		~restoreOhm.improv.hugeToggle = 0;
		self;
	},

	makeToggleMIDI: { | self |
		MIDIdef.noteOn(\hugeToggle, { ~improv.huge.muteToggle; }, self.toggle);
		self;
	},

	killToggleMIDI: { | self |
		MIDIdef(\hugeToggle).free;
		self;
	},

	toggleOhm: { | self, val |
		case
		{ val == 0 } { ~ohm.turnRed(self.toggle); ~restoreOhm.improv.page.put(self.toggle, \red); }
		{ val == 1 } { ~ohm.turnGreen(self.toggle); ~restoreOhm.improv.page.put(self.toggle, \green); }
	},

	makePage: { | self |
		~ohm.turnPurple(self.page);
		~restoreOhm.improv.page.put(self.page, \purple);
		self.makePageMIDI;
		~restoreOhm.improv.hugePage = 1;
		self;
	},

	killPage: { | self |
		~ohm.turnOff(self.page);
		~restoreOhm.improv.page.put(self.page, \off);
		self.killPageMIDI;
		~restoreOhm.improv.hugePage = 0;
		self;
	},

	makePageMIDI: { | self |
		MIDIdef.noteOn(\hugePage, { ~page.improv.huge; }, self.page);
		self;
	},

	killPageMIDI: { | self |
		MIDIdef(\hugePage).free;
		self;
	},

	makeFaders: { | self |
		self.makeVolume;
		self;
	},

	killFaders: { | self |
		self.killVolume;
		self;
	},

	makeVolume: { | self |
		MIDIdef.cc(\hugeVolume, { | val |
			var amp = val.linlin(0, 127, 0, -4.dbamp);
			~improv.huge.main.set(\amp, amp);
		}, self.vol);
		~restoreOhm.improv.hugeVolume = 1;
		self;
	},

	killVolume: { | self |
		MIDIdef(\hugeVolume).free;
		~restoreOhm.improv.hugeVolume = 0;
		self;
	},

	makeDials: { | self |
		self.makeCutoffRate;
		self;
	},

	killDials: { | self |
		self.killCutoffRate;
		self;
	},

	makeCutoffRate: { | self |
		MIDIdef.cc(\hugeCutoffRate, { | val |
			var rate = val.linlin(0, 127, 0.1, 100);
			~improv.huge.main.set(\cutoffChangeRate, rate);
			rate.postln;
		}, self.cutoffRate);
		~restoreOhm.improv.cutoffRate = 1;
		self;
	},

	killCutoffRate: { | self |
		MIDIdef(\hugeCutoffRate).free;
		self;
	},

)