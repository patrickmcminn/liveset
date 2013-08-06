/*
Monday, July 15th 2013
tptOhm.scd
prm
*/

~interludeOhm.tpt = (

	main: 6,
	toggle: 14,

	vol: 22,

	makeOSC: { | self |
		OSCdef(\interludeTptOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \interludeTptTop } { self.spawn(val); }
			{ id == \interludeTptMute } { self.toggleOhm(val); }
		}, \improvControl, ~scLang);

		OSCdef(\interludeTptOhmRestore, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \interludeTptToggle } { if ( val == 1, { self.makeToggleMIDI; }) }
			{ id == \interludeTptVol } { if(val == 1, { self.makeVol; }) }
		}, \restoreOhmImprov, ~scLang);

		self;
	},

	killOSC: { | self |
		OSCdef(\interludeTptOhm).free;
		OSCdef(\interludeTptOhmRestore).free;
		self;
	},


	spawn: { | self, state |
		if( state == 1, { self.init; }, { self.kill; } );
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

	},

	killButtons: { | self |
		self.topOhm(0);
		self.killToggle;
	},

	topOhm: { | self, val |
		if( val == 1,
			{
				~ohm.turnWhite(self.main);
				~restoreOhm.improv.page.put(self.main, \white);
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
		~restoreOhm.improv.interludeTptToggle = 1;
		self;
	},

	killToggle: { | self |
		~ohm.turnOff(self.toggle);
		~restoreOhm.improv.page.put(self.toggle, \off);
		self.killToggleMIDI;
		~restoreOhm.improv.interludeTptToggle = 0;
		self;
	},

	makeToggleMIDI: { | self |
		MIDIdef.noteOn(\interludeTptToggle, {
			~improv.interludeTpt.muteToggle;
			~scLang.sendMsg(\improvControl, \interludeTptMute, ~improv.interludeTpt.muteState);
		}, self.toggle);
		self;
	},

	killToggleMIDI: { | self |
		MIDIdef(\interludeTptToggle).free;
		self;
	},

	toggleOhm: { | self, val |
		case
		{ val == 0 } { ~ohm.turnRed(self.toggle); ~restoreOhm.improv.page.put(self.toggle, \red); }
		{ val == 1 } { ~ohm.turnGreen(self.toggle); ~restoreOhm.improv.page.put(self.toggle, \green); }
	},

	makeFaders: { | self |
		self.makeVol;
		self;
	},

	killFaders: { | self |
		self.killVol;
		self;
	},

	makeVol: { | self |
		MIDIdef.cc(\interludeTptVol, { | val |
			var amp = val.linlin(0, 127, 0, 0.dbamp);
			~improv.interludeTpt.fader.set(\amp, amp);
		}, self.vol);
		~restoreOhm.improv.interludeTptVol = 1;
		self;
	},

	killVol: { | self |
		MIDIdef(\interludeTptVol).free;
		~restoreOhm.improv.poppyVol = 0;
		self;
	},

	makeDials: { | self |
		self;
	},

	killDials: { | self |
		self;
	},
)