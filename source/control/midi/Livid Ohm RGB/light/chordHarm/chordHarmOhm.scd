/*
Tuesday, July 9th 2013
chordHarmOhm.scd
prm
*/

~lightOhm.chordHarm = (

	main: 2,
	toggle: 10,
	octave: 3,
	third: 11,
	fifth: 19,

	vol: 14,


	makeOSC: { | self |
		OSCdef(\chordHarmOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \chordHarmTop } { self.spawn(val); }
			{ id == \chordHarmMute } { self.toggleOhm(val); }
			//{ id == \chordHarmChangeOutput } { self.changeOutput(val); }
			{ id == \chordHarmMajor } { self.majorOhm; }
			{ id == \chordHarmMinor } { self.minorOhm; }
			{ id == \chordHarmp4 } { self.p4Ohm; }
			{ id == \chordHarmtt } { self.ttOhm; }
			{ id == \chordHarmOctave } { self.octaveOhm }
			{ id == \chordHarmMajor7 } { self.major7Ohm; }
		}, \lightControl, ~scLang);
	},

	killOSC: { | self |
		OSCdef(\chordHarmOhm).free;
		self;
	},

	spawn: { | self, state |
		if ( state == 1, { self.init; }, { self.kill });
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
		self.makeOctave;
		self.makeThird;
		self.makeFifth;
		self;
	},

	killButtons: { | self |
		self.topOhm(0);
		self.killToggle;
		self.killOctave;
		self.killThird;
		self.killFifth;
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

	makeDials: { | self |

		self;
	},

	killDials: { | self |

		self;
	},

	topOhm: { | self, val |
		if( val == 1,
			{
				~ohm.turnBlue(self.main);
				~restoreOhm.light.page.put(self.main, \blue);
			},
			{
				~ohm.turnRed(self.main);
				~restoreOhm.light.page.put(self.main, \red);
			}
		);
		self;
	},

	makeToggle: { | self |
		~ohm.turnGreen(self.toggle);
		~restoreOhm.light.page.put(self.toggle, \green);
		self.makeToggleMIDI;
		~restoreOhm.light.chordHarmToggle = 1;
		self;
	},

	killToggle: { | self |
		~ohm.turnOff(self.toggle);
		~restoreOhm.light.page.put(self.toggle, \off);
		self.killToggleMIDI;
		~restoreOhm.light.chordHarmToggle = 0;
		self;
	},

	makeOctave: { | self |
		~ohm.turnBlue(self.octave);
		~restoreOhm.light.page.put(self.octave, \blue);
		self.makeOctaveMIDI;
		self.makeMajor7MIDI;
		~restoreOhm.light.chordHarmOctave = 1;
		self;
	},

	killOctave: { | self |
		~ohm.turnOff(self.octave);
		~restoreOhm.light.page.put(self.octave, \off);
		self.killOctaveMIDI;
		self.killMajor7MIDI;
		~restoreOhm.light.chordHarmOctave = 0;
	},

	makeThird: { | self |
		~ohm.turnPurple(self.third);
		~restoreOhm.light.page.put(self.third, \purple);
		self.makeMajorMIDI;
		self.makeMinorMIDI;
		~restoreOhm.light.chordHarmThird = 1;
		self;
	},

	killThird: { | self |
		~ohm.turnOff(self.third);
		~restoreOhm.light.page.put(self.third, \off);
		self.killMaiorMIDI;
		self.killMinorMIDI;
		~restoreOhm.light.chordHarmThird = 0;
	},

	makeFifth: { | self |
		~ohm.turnCyan(self.fifth);
		~restoreOhm.light.page.put(self.fifth, \cyan);
		self.makep4MIDI;
		self.makettMIDI;
		~restoreOhm.light.chordHarmFifth = 1;
		self;
	},

	killFifth: { | self |
		~ohm.turnOff(self.fifth);
		~restoreOhm.light.page.put(self.fifth, \off);
		self.killp4MIDI;
		self.killttMIDI;
		~restoreOhm.light.chordHarmFifth = 0;
	},

	makeToggleMIDI: { | self |
		MIDIdef.noteOn(\chordHarmToggle, { ~light.chordHarm.muteToggle; }, self.toggle);
		self;
	},

	killToggleMIDI: { | self |
		MIDIdef(\chordHarmToggle).free;
		self;
	},

	toggleOhm: { | self, val |
		case
		{ val == 0 } { ~ohm.turnRed(self.toggle); }
		{ val == 1 } { ~ohm.turnWhite(self.toggle); }
	},

	makeOctaveMIDI: { | self |
		MIDIdef.noteOff(\chodHarmOctave, { ~light.chordHarm.octave; }, self.octave);
		self;
	},

	killOctaveMIDI: { | self |
		MIDIdef(\chordHarmOctave).free;
		self;
	},

	makeMajor7MIDI: { | self |
		MIDIdef.noteOn(\chordHarmM7, { ~light.chordHarm.major7; }, self.octave);
		self;
	},

	killMajor7MIDI: { | self |
		MIDIdef(\chordHarmM7).free;
		self;
	},

	octaveOhm: { | self |
		~ohm.turnBlue(self.octave);
		self;
	},

	major7Ohm: { | self |
		~ohm.turnYellow(self.octave);
		self;
	},

	makeMajorMIDI: { | self |
		MIDIdef.noteOn(\chordHarmMajor, { ~light.chordHarm.majorChord; }, self.third);
		self;
	},

	killMajorMIDI: { | self |
		MIDIdef(\chordHarmMajor).free;
		self;
	},

	makeMinorMIDI: { | self |
		MIDIdef.noteOff(\chordHarmMinor, { ~light.chordHarm.minorChord; }, self.third);
		self;
	},

	killMinorMIDI: { | self |
		MIDIdef(\chordHarmMinor).free;
		self;
	},

	majorOhm: { | self |
		~ohm.turnYellow(self.third);
		self;
	},

	minorOhm: { | self |
		~ohm.turnPurple(self.third);
		self;
	},

	makep4MIDI: { | self |
		MIDIdef.noteOff(\chordHarmp4, { ~light.chordHarm.p4; }, self.fifth);
		self;
	},

	killp4MIDI: { | self |
		MIDIdef(\chordHarmp4).free;
		self;
	},

	makettMIDI: { | self |
		MIDIdef.noteOn(\chordHarmtt, { ~light.chordHarm.tt; }, self.fifth);
		self;
	},

	killttMIDI: { | self |
		MIDIdef(\chordHarmtt).free;
		self;
	},

	p4Ohm: { | self |
		~ohm.turnCyan(self.fifth);
		self;
	},

	ttOhm: { | self |
		~ohm.turnWhite(self.fifth);
		self;
	},

	makeVol: { | self |
		MIDIdef.cc(\chordHarmVol, { | val |
			var amp = val.linlin(0, -2.dbamp);
			~light.chordHarm.fader.set(\amp, amp);
		}, self.vol);
		~restoreOhm.light.chordHarmVol = 1;
		self;
	},

	killVol: { | self |
		MIDIdef(\chordHarmVol).free;
		~restoreOhm.light.chordHarmVol = 0;
		self;
	}
)