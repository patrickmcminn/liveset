/*
Monday, July 15th 2013
tptOhm.scd
prm
*/

~interludeOhm.tpt = (

	main: 7,
	toggle: 15,

	vol: 14,

	makeOSC: { | self |
		OSCdef(\interludeTptOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \tptTop } { self.spawn(val); }
			{ id == \tptMute } { self.toggleOhm(val); }
		}, \interludeControl, ~scLang);

		OSCdef(\interludeTptOhmRestore, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \tptToggle } { if ( val == 1, { self.makeToggleMIDI; }) }
			{ id == \tptVol } { if(val == 1, { self.makeVol; }) }
		}, \restoreOhmInterlude, ~scLang);

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
				~ohm.turnBlue(self.main);
				~restoreOhm.interlude.page.put(self.main, \blue);
			},
			{
				~ohm.turnRed(self.main);
				~restoreOhm.interlude.page.put(self.main, \red);
			}
		);
		self;
	},

	makeToggle: { | self |
		~ohm.turnGreen(self.toggle);
		~restoreOhm.interlude.page.put(self.toggle, \green);
		self.makeToggleMIDI;
		~restoreOhm.interlude.tptToggle = 1;
		self;
	},

	killToggle: { | self |
		~ohm.turnOff(self.toggle);
		~restoreOhm.interlude.page.put(self.toggle, \off);
		self.killToggleMIDI;
		~restoreOhm.interlude.tptToggle = 0;
		self;
	},

	makeToggleMIDI: { | self |
		MIDIdef.noteOn(\interludeTptToggle, {
			~interlude.tpt.muteToggle;
			~scLang.sendMsg(\interludeControl, \tptMute, ~interlude.tpt.muteState);
		}, self.toggle);
		self;
	},

	killToggleMIDI: { | self |
		MIDIdef(\interludeTptToggle).free;
		self;
	},

	toggleOhm: { | self, val |
		case
		{ val == 0 } { ~ohm.turnRed(self.toggle); ~restoreOhm.interlude.page.put(self.toggle, \red); }
		{ val == 1 } { ~ohm.turnGreen(self.toggle); ~restoreOhm.interlude.page.put(self.toggle, \green); }
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
			~interlude.tpt.fader.set(\amp, amp);
		}, self.vol);
		~restoreOhm.interlude.tptVol = 1;
		self;
	},

	killVol: { | self |
		MIDIdef(\interludeTptVol).free;
		~restoreOhm.interlude.tptVol = 0;
		self;
	},

	makeDials: { | self |
		self;
	},

	killDials: { | self |
		self;
	},
)