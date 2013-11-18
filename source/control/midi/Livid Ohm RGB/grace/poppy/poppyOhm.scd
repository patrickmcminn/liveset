/*
Monday, July 15th 2013
poppyOhm.scd
prm
*/

~graceOhm.poppy = (

	main: 0,
	toggle: 8,
	trigger: 1,
	resetter: 9,
  microCluster: 17,

	vol: 14,
	playVol: 12,
	trigRate: 10,
	lengthLo: 18,
	lengthHi: 11,

	makeOSC: { | self |
		OSCdef(\gracePoppyOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \poppyTop } { self.spawn(val); }
			{ id == \poppyMute } { self.toggleOhm(val); }
			{ id == \poppyTrigger } { self.triggerOhm(val); }
      { id == \poppyMicroClusterMute } { self.microClusterOhm(val) }

		}, \graceControl, ~scLang);

		OSCdef(\gracePoppyOhmRestore, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \poppyToggle } { if ( val == 1, { self.makeToggleMIDI; }) }
			{ id == \poppyTrigger } { if ( val == 1, { self.makeTriggerMIDI; }) }
			{ id == \poppyReset } { if( val == 1, { self.makeResetMIDI; }) }
      { id == \poppyMicroCluster } { if( val == 1, { self.makeMicroClusterMIDI; }) }
			{ id == \poppyVol } { if(val == 1, { self.makeVol; }) }
			{ id == \poppyTrigRate } { if(val == 1, { self.makeTrigRate; }) }
			{ id == \poppyPlayVol } { if (val == 1, { self.makePlayVol;} ) }
			{ id == \poppyLengthLo } { if ( val == 1, { self.makeLengthLo; } ) }
			{ id == \poppyLengthHi } { if ( val == 1, { self.makeLengthHil } ) }

		}, \restoreOhmGrace, ~scLang);

		self;
	},

	killOSC: { | self |
		OSCdef(\gracePoppyOhm).free;
		OSCdef(\gracePoppyOhmRestore).free;
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
    self.makeMicroCluster;

	},

	killButtons: { | self |
		self.topOhm(0);
		self.killToggle;
		self.killTrigger;
		self.killReset;
    self.killMicroCluster;
	},

	topOhm: { | self, val |
		if( val == 1,
			{
				~ohm.turnBlue(self.main);
				~restoreOhm.grace.page.put(self.main, \blue);
			},
			{
				~ohm.turnRed(self.main);
				~restoreOhm.grace.page.put(self.main, \red);
			}
		);
		self;
	},

	makeToggle: { | self |
		~ohm.turnGreen(self.toggle);
		~restoreOhm.grace.page.put(self.toggle, \green);
		self.makeToggleMIDI;
		~restoreOhm.grace.poppyToggle = 1;
		self;
	},

	killToggle: { | self |
		~ohm.turnOff(self.toggle);
		~restoreOhm.grace.page.put(self.toggle, \off);
		self.killToggleMIDI;
		~restoreOhm.grace.poppyToggle = 0;
		self;
	},

	makeToggleMIDI: { | self |
		MIDIdef.noteOn(\gracePoppyToggle, { ~grace.poppy.muteToggle }, self.toggle);
		self;
	},

	killToggleMIDI: { | self |
		MIDIdef(\gracePoppyToggle).free;
		self;
	},

	toggleOhm: { | self, val |
		case
		{ val == 0 } { ~ohm.turnRed(self.toggle); ~restoreOhm.grace.page.put(self.toggle, \red); }
		{ val == 1 } { ~ohm.turnGreen(self.toggle); ~restoreOhm.grace.page.put(self.toggle, \green); }
	},

	makeTrigger: { | self |
		~ohm.turnRed(self.trigger);
		~restoreOhm.grace.page.put(self.trigger, \red);
		self.makeTriggerMIDI;
		~restoreOhm.grace.poppyTrigger = 1;
		self;
	},

	killTrigger: { | self |
		~ohm.turnOff(self.trigger);
		~restoreOhm.grace.page.put(self.trigger, \off);
		self.killTriggerMIDI;
		~restoreOhm.grace.poppyTrigger = 0;
		self;
	},

	makeTriggerMIDI: { | self |
		MIDIdef.noteOn(\gracePoppyTrigger, { ~grace.poppy.triggerToggle; }, self.trigger);
		self;
	},

	killTriggerMIDI: { | self |
		MIDIdef(\gracePoppyTrigger).free;
		self;
	},

	triggerOhm: { | self, val |
		case
		{ val == 0 } { ~ohm.turnRed(self.trigger); ~restoreOhm.grace.page.put(self.trigger, \red); }
		{ val == 1 } { ~ohm.turnWhite(self.trigger); ~restoreOhm.grace.page.put(self.trigger, \white); }
	},

	makeReset: { | self |
		~ohm.turnPurple(self.resetter);
		~restoreOhm.grace.page.put(self.resetter, \purple);
		self.makeResetMIDI;
		~restoreOhm.grace.poppyReset = 1;
		self;
	},

	killReset: { | self |
		~ohm.turnOff(self.resetter);
		~restoreOhm.grace.page.put(self.resetter, \off);
		self.killResetMIDI;
		~restoreOhm.grace.poppyReset = 0;
		self;
	},

	makeResetMIDI: { | self |
		MIDIdef.noteOn(\gracePoppyReset, { ~grace.poppy.clearBuffer; }, self.resetter);
		self;
	},

	killResetMIDI: { | self |
		MIDIdef(\gracePoppyReset).free;
		self;
	},

  makeMicroCluster: { | self |
    ~ohm.turnRed(self.microCluster);
    ~restoreOhm.grace.page.put(self.microCluster, \red);
    self.makeMicroClusterMIDI;
    ~restoreOhm.grace.poppyMicroCluster = 1;
    self;
  },

  killMicroCluster: { | self |
    ~ohm.turnOff(self.microCluster);
    ~restoreOhm.grace.page.put(self.microCluster, \off);
    self.killMicroClusterMIDI;
    ~restoreOhm.grace.poppyMicroCluster = 0;
    self;
  },

  makeMicroClusterMIDI: { | self |
    MIDIdef.noteOn(\gracePoppyMicroCluster, { ~grace.poppy.microCluster.tglMuteMicroCluster; }, self.microCluster);
    self;
  },

  killMicroClusterMIDI: { | self |
    MIDIdef(\gracePoppyMicroCluster).free;
    self;
  },

  microClusterOhm: { | self, val |
    if( val == 0,
      { ~ohm.turnRed(self.microCluster); ~restoreOhm.grace.page.put(self.microCluster, \red); },
      { ~ohm.turnWhite(self.microCluster); ~restoreOhm.grace.page.put(self.microCluster, \white); }
    );
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
		MIDIdef.cc(\gracePoppyVol, { | val |
			var amp = val.linlin(0, 127, 0, 4.dbamp);
			~grace.poppy.fader.set(\amp, amp);
		}, self.vol);
		~restoreOhm.grace.poppyVol = 1;
		self;
	},

	killVol: { | self |
		MIDIdef(\gracePoppyVol).free;
		~restoreOhm.grace.poppyVol = 0;
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
		MIDIdef.cc(\gracePoppyPlayVol, { | val |
			var amp = val.linlin(0, 127, 0, 1);
			~grace.poppy.playVol = amp;
		}, self.playVol);
		~restoreOhm.grace.poppyPlayVol = 1;
		self;
	},

	killPlayVol: { | self |
		MIDIdef(\gracePoppyPlayVol).free;
		~restoreOhm.improv.poppyPlayVol = 0;
		self;
	},

	makeTrigRate: { | self |
		MIDIdef.cc(\gracePoppyTrigRate, { | val |
			var rate = val.linlin(0, 127, 0, 3);
			~grace.poppy.changeTrigRate(rate);
		}, self.trigRate);
		~restoreOhm.grace.poppyTrigRate = 1;
		self;
	},

	killTrigRate: { | self |
		MIDIdef(\gracePoppyTrigRate).free;
		~restoreOhm.grace.poppyTrigRate = 0;
		self;
	},

	makeLengthLo: { | self |
		MIDIdef.cc(\gracePoppyLengthLo, { | val |
			var length = val.linlin(0, 127, 0.01, 4);
			~grace.poppy.lengthLo = length;
		}, self.lengthLo);
		~restoreOhm.grace.poppyLengthLo = 1;
		self;
	},

	killLengthLo: { | self |
		MIDIdef(\gracePoppyLengthLo).free;
		~restoreOhm.grace.poppyLengthLo = 0;
		self;
	},

	makeLengthHi: { | self |
		MIDIdef.cc(\gracePoppyLengthHi, { | val |
			var length = val.linlin(0, 127, 0.5, 5);
			~grace.poppy.lengthHi = length;
		}, self.lengthHi);
		~restoreOhm.grace.poppyLengthHi = 1;
		self;
	},

	killLengthHi: { | self |
		MIDIdef(\gracePoppyLengthHi).free;
		~restoreOhm.improv.poppyLengthHi = 1;
		self;
	},
)