/*
Monday, July 15th 2013
poppyOhm.scd
prm
*/

~improvOhm.poppy = (

	main: 3,
	toggle: 11,
	trigger: 4,
	resetter: 12,

	vol: 14,
	playVol: 12,
	trigRate: 10,
	lengthLo: 18,
	lengthHi: 11,

	makeOSC: { | self |
		OSCdef(\poppyOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \poppyTop } { self.spawn(val); }
			{ id == \poppyMute } { self.toggleOhm(val); }
			{ id == \poppyTrigger } { self.triggerOhm(val); }

		}, \improvControl, ~scLang);

		OSCdef(\poppyOhmRestore, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \poppyToggle } { if ( val == 1, { self.makeToggleMIDI; }) }
			{ id == \poppyTrigger } { if ( val == 1, { self.makeTriggerMIDI; }) }
			{ id == \poppyReset } { if( val == 1, { self.makeResetMIDI; }) }
			{ id == \poppyVol } { if(val == 1, { self.makeVol; }) }
			{ id == \poppyTrigRate } { if(val == 1, { self.makeTrigRate; }) }
			{ id == \poppyPlayVol } { if (val == 1, { self.makePlayVol;} ) }
			{ id == \poppyLengthLo } { if ( val == 1, { self.makeLengthLo; } ) }
			{ id == \poppyLengthHi } { if ( val == 1, { self.makeLengthHil } ) }

		}, \restoreOhmImprov, ~scLang);

		self;
	},

	killOSC: { | self |
		OSCdef(\poppyOhm).free;
		OSCdef(\poppyOhmRestore).free;
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
		self.makeTrigger;
		self.makeReset;

	},

	killButtons: { | self |
		self.topOhm(0);
		self.killToggle;
		self.killTrigger;
		self.killReset;
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
		~restoreOhm.improv.poppyToggle = 1;
		self;
	},

	killToggle: { | self |
		~ohm.turnOff(self.toggle);
		~restoreOhm.improv.page.put(self.toggle, \off);
		self.killToggleMIDI;
		~restoreOhm.improv.poppyToggle = 0;
		self;
	},

	makeToggleMIDI: { | self |
		MIDIdef.noteOn(\poppyToggle, { ~improv.poppy.muteToggle }, self.toggle);
		self;
	},

	killToggleMIDI: { | self |
		MIDIdef(\poppyToggle).free;
		self;
	},

	toggleOhm: { | self, val |
		case
		{ val == 0 } { ~ohm.turnRed(self.toggle); ~restoreOhm.improv.page.put(self.toggle, \red); }
		{ val == 1 } { ~ohm.turnGreen(self.toggle); ~restoreOhm.improv.page.put(self.toggle, \green); }
	},

	makeTrigger: { | self |
		~ohm.turnRed(self.trigger);
		~restoreOhm.improv.page.put(self.trigger, \red);
		self.makeTriggerMIDI;
		~restoreOhm.improv.poppyTrigger = 1;
		self;
	},

	killTrigger: { | self |
		~ohm.turnOff(self.trigger);
		~restoreOhm.improv.page.put(self.trigger, \off);
		self.killTriggerMIDI;
		~restoreOhm.improv.poppyTrigger = 0;
		self;
	},

	makeTriggerMIDI: { | self |
		MIDIdef.noteOn(\poppyTrigger, { ~improv.poppy.triggerToggle; }, self.trigger);
		self;
	},

	killTriggerMIDI: { | self |
		MIDIdef(\poppyTrigger).free;
		self;
	},

	triggerOhm: { | self, val |
		case
		{ val == 0 } { ~ohm.turnRed(self.trigger); ~restoreOhm.improv.page.put(self.trigger, \red); }
		{ val == 1 } { ~ohm.turnWhite(self.trigger); ~restoreOhm.improv.page.put(self.trigger, \white); }
	},

	makeReset: { | self |
		~ohm.turnPurple(self.resetter);
		~restoreOhm.improv.page.put(self.resetter, \purple);
		self.makeResetMIDI;
		~restoreOhm.improv.poppyReset = 1;
		self;
	},

	killReset: { | self |
		~ohm.turnOff(self.resetter);
		~restoreOhm.improv.page.put(self.resetter, \off);
		self.killResetMIDI;
		~restoreOhm.improv.poppyReset = 0;
		self;
	},

	makeResetMIDI: { | self |
		MIDIdef.noteOn(\poppyReset, { ~improv.poppy.clearBuffer; }, self.resetter);
		self;
	},

	killResetMIDI: { | self |
		MIDIdef(\poppyReset).free;
		self;
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
		MIDIdef.cc(\poppyVol, { | val |
			var amp = val.linlin(0, 127, 0, 4.dbamp);
			~improv.poppy.fader.set(\amp, amp);
		}, self.vol);
		~restoreOhm.improv.poppyVol = 1;
		self;
	},

	killVol: { | self |
		MIDIdef(\poppyVol).free;
		~restoreOhm.improv.poppyVol = 0;
		self;
	},

	makeDials: { | self |
		self.makePlayVol;
		self.makeTrigRate;
		self.makeLengthLo;
		self.makeLengthHi;
		self;
	},

	killDials: { | self |
		self.killPlayVol;
		self.killTrigRate;
		self;
	},

	makePlayVol: { | self |
		MIDIdef.cc(\poppyPlayVol, { | val |
			var amp = val.linlin(0, 127, 0, 1);
			~improv.poppy.playVol = amp;
		}, self.playVol);
		~restoreOhm.improv.poppyPlayVol = 1;
		self;
	},

	killPlayVol: { | self |
		MIDIdef(\poppyPlayVol).free;
		~restoreOhm.improv.poppyPlayVol = 0;
		self;
	},

	makeTrigRate: { | self |
		MIDIdef.cc(\poppyTrigRate, { | val |
			var rate = val.linlin(0, 127, 0, 3);
			~improv.poppy.changeTrigRate(rate);
		}, self.trigRate);
		~restoreOhm.improv.poppyTrigRate = 1;
		self;
	},

	killTrigRate: { | self |
		MIDIdef(\poppyTrigRate).free;
		~restoreOhm.improv.poppyTrigRate = 0;
		self;
	},

	makeLengthLo: { | self |
		MIDIdef.cc(\poppyLengthLo, { | val |
			var length = val.linlin(0, 127, 0.01, 4);
			~improv.poppy.lengthLo = length;
		}, self.lengthLo);
		~restoreOhm.improv.poppyLengthLo = 1;
		self;
	},

	killLengthLo: { | self |
		MIDIdef(\poppyLengthLo).free;
		~restoreOhm.improv.poppyLengthLo = 0;
		self;
	},

	makeLengthHi: { | self |
		MIDIdef.cc(\poppyLengthHi, { | val |
			var length = val.linlin(0, 127, 0.5, 5);
			~improv.poppy.lengthHi = length;
		}, self.lengthHi);
		~restoreOhm.improv.poppyLengthHi = 1;
		self;
	},

	killLengthHi: { | self |
		MIDIdef(\poppyLengthHi).free;
		~restoreOhm.improv.poppyLengthHi = 1;
		self;
	},
)