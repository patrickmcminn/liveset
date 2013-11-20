/*
Wednesday, November 20th 2013
pitchSequencerOhm.scd
prm
*/

~graceOhm.pitchSequencer = (

	main: 2,
	toggle: 3,

	vol: 23,

	makeOSC: { | self |
		OSCdef(\gracePitchSequencerOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \pitchSequencerTop } { self.spawn(val); }
			{ id == \pitchSequencerMute } { self.toggleOhm(val); }

		}, \graceControl, ~scLang);

		OSCdef(\gracePitchSequencerOhmRestore, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \pitchSequencerToggle } { if ( val == 1, { self.makeToggleMIDI; }) }
			{ id == \pitchSequencerVol } { if (val == 1, { self.makeVol;} ) }

		}, \restoreOhmGrace, ~scLang);

		self;
	},

	killOSC: { | self |
		OSCdef(\gracePitchSequencerOhm).free;
		OSCdef(\gracePitchSequencerOhmRestore).free;
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
		~restoreOhm.grace.pitchSequencerToggle = 1;
		self;
	},

	killToggle: { | self |
		~ohm.turnOff(self.toggle);
		~restoreOhm.grace.page.put(self.toggle, \off);
		self.killToggleMIDI;
		~restoreOhm.grace.pitchSequencerToggle = 0;
		self;
	},

	makeToggleMIDI: { | self |
		MIDIdef.noteOn(\gracePitchSequencerToggle, {
			~grace.pitchSequencer.toggleMute;
			~scLang.sendMsg(\graceControl, \pitchSequencerMute, ~grace.pitchSequencer.muteState);
		}, self.toggle);
		self;
	},

	killToggleMIDI: { | self |
		MIDIdef(\gracePitchSequencerToggle).free;
		self;
	},

	toggleOhm: { | self, val |
		case
		{ val == 0 } { ~ohm.turnRed(self.toggle); ~restoreOhm.grace.page.put(self.toggle, \red); }
		{ val == 1 } { ~ohm.turnGreen(self.toggle); ~restoreOhm.grace.page.put(self.toggle, \green); }
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
		MIDIdef.cc(\gracePitchSequencerVol, { | val |
			var amp = val.linlin(0, 127, 0, 6.dbamp);
			~grace.pitchSequencer.fader.set(\amp, amp);
		}, self.vol);
		~restoreOhm.grace.pitchSequencerVol = 1;
		self;
	},

	killVol: { | self |
		MIDIdef(\gracePitchSequencerVol).free;
		~restoreOhm.grace.pitchSequencerVol = 0;
		self;
	},

	makeDials: { | self |
		self;
	},

	killDials: { | self |
		self;
	},
);