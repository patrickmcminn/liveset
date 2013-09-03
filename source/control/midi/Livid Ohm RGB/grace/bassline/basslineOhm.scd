/*
Tuesday, September 3rd 2013
basslineOhm.scd
prm
*/

~graceOhm.bassline = (

	main: 3,
	bassline1: 11,
	bassline2: 19,

	vol: 15,

	makeOSC: { | self |
		OSCdef(\graceBasslineOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \basslineTop } { self.spawn(val); }
			{ id == \bassline1 } { self.bassline1Ohm(val); }
			{ id == \bassline2 } { self.bassline2Ohm(val); }

		}, \graceControl, ~scLang);

		OSCdef(\graceBasslineOhmRestore, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \basslineVol } { if(val == 1, { self.makeVol; }) }
			{ id == \bassline1 } { if( val == 1, { self.makeBassline1MIDI; }) }
			{ id == \bassline2 } { if ( val == 1, { self.makeBassline2MIDI; }) }

		}, \restoreOhmGrace, ~scLang);

		self;
	},

	killOSC: { | self |
		OSCdef(\graceBasslineOhm).free;
		OSCdef(\graceBasslineOhmRestore).free;
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
		self.makeBassline1;
		self.makeBassline2;

	},

	killButtons: { | self |
		self.topOhm(0);
		self.killBassline1;
		self.killBassline2;
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

	makeBassline1: { | self |
		~ohm.turnWhite(self.bassline1);
		~restoreOhm.grace.page.put(self.bassline1, \white);
		self.makeBassline1MIDI;
		~restoreOhm.grace.bassline1 = 1;
		self;
	},

	killBassline1: { | self |
		~ohm.turnOff(self.bassline1);
		~restoreOhm.grace.page.put(self.bassline1, \off);
		self.killBassline1MIDI;
		~restoreOhm.grace.bassline1 = 0;
	},

	makeBassline1MIDI: { | self |
		MIDIdef.noteOn(\graceBassline1, {
			~grace.bassline.togglePattern1;
			~scLang.sendMsg(\graceControl, \bassline1, ~grace.bassline.play1State);
		}, self.bassline1);
	},

	killBassline1MIDI: { | self |
		MIDIdef(\graceBassline1).free;
		self;
	},

	bassline1Ohm: { | self, val |
		if( val == 1,
			{ ~ohm.turnGreen(self.bassline1); ~restoreOhm.grace.put(self.bassline1, \green); },
			{ ~ohm.turnRed(self.bassline1); ~restoreOhm.grace.put(self.bassline1, \red); });
		self;
	},

	makeBassline2: { | self |
		~ohm.turnYellow(self.bassline2);
		~restoreOhm.grace.page.put(self.bassline2, \yellow);
		self.makeBassline2MIDI;
		~restoreOhm.grace.bassline2 = 1;
		self;
	},

	killBassline2: { | self |
		~ohm.turnOff(self.bassline2);
		~restoreOhm.grace.page.put(self.bassline2, \off);
		self.killBassline2MIDI;
		~restoreOhm.grace.bassline2 = 0;
	},

	makeBassline2MIDI: { | self |
		MIDIdef.noteOn(\graceBassline2, {
			~grace.bassline.togglePattern2;
			~scLang.sendMsg(\graceControl, \bassline2, ~grace.bassline.play2State);
		}, self.bassline2);
	},

	killBassline2MIDI: { | self |
		MIDIdef(\graceBassline2).free;
		self;
	},

	bassline2Ohm: { | self, val |
		if( val == 1,
			{ ~ohm.turnGreen(self.bassline2); ~restoreOhm.grace.put(self.bassline2, \green); },
			{ ~ohm.turnRed(self.bassline2); ~restoreOhm.grace.put(self.bassline2, \red); });
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
		MIDIdef.cc(\graceBasslineVol, { | val |
			var amp = val.linlin(0, 127, 0, 1);
			~grace.bassline.fader.set(\amp, amp);
		}, self.vol);
		~restoreOhm.grace.basslineVol = 1;
		self;
	},

	killVol: { | self |
		MIDIdef(\graceBasslineVol).free;
		~restoreOhm.grace.basslineVol = 0;
		self;
	},
)