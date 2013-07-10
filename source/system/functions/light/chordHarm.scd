/*
Tuesday, July 9th 2013
chordHarm.scd
prm
*/

~light.chordHarm = (

	in: ~inst.mic,
	out: ~mixer.s1,

	state: 0,
	muteState: 1,

	spawn: { | self |
		if ( self.state == 0, { self.init; }, { self.kill });
		self;
	},

	init: { | self |
		self.makeBusses;
		self.makeSynths;
		self.state = 1;
		~scLang.sendMsg(\lightControl, \chordHarmTop, 1);
		self;
	},

	kill: { | self |
		self.killBusses;
		self.killSynths;
		self.state = 0;
		~scLang.sendMsg(\lightControl, \chordHarmTop, 0);
		self;
	},

	makeBusses: { | self |
		self.harmBus = Bus.audio;
		self.verBus = Bus.audio;
		self.faderBus = Bus.audio;
		self;
	},

	killBusses: { | self |
		self.harmBus.free;
		self.verbBus.free;
		self.faderBus.free;
		self;
	},

	makeSynths: { | self |
		self.inFader = Synth(\fader, [\in, self.in, \out, self.harmBus], ~group.fx, \addToTail);
		self.thru = Synth(\fader, [\in, self.harmBus, \out, self.verbBus], ~group.fx, \addToTail);
		self.harm1 = Synth(\pitchShifter, [\in, self.harmBus, \out, self.verbBus, \interval, -12], ~group.fx, \addToTail);
		self.harm2 = Synth(\pitchShifter, [\in, self.harmBus, \out, self.verbBus, \interval, -8], ~group.fx, \addToTail);
		self.harm3 = Synth(\pitchShifter, [\in, self.harmBus, \out, self.verbBus, \interval, -5], ~group.fx, \addToTail);
		self.verb = Synth(\reverb1, [\in, self.verbBus, \out, self.faderBus, \mix, 0.7, \room, 0.8, \damp, 0.4],
			~group.fx, \addToTail);
		self.fader = Synth(\pan, [\in, self.faderBus, \out, self.out, \amp, -6.dbamp],
			~group.fx, \addToTail);
		self;
	},

	killSynths: { | self |
		self.inFader;
		self.thru.free;
		self.harm1.free;
		self.harm2.free;
		self.harm3.free;
		self.verb.free;
		self.fader.free;
		self;
	},

	muteToggle: { | self |
		if( self.muteState == 1, { self.mute; }, { self.unmutel });
		self;
	},

	mute: { | self |
		self.inFader.set(\mute, 0);
		self.muteState = 0;
		~scLang.sendMsg(\lightControl, \chordHarmMute, 0);
		self;
	},

	unmute: { | self |
		self.inFader.set(\mute, 1);
		self.muteState = 1;
		~scLang.sendMsg(\lightControl, \chordHarmMute, 1);
		self;
	},

	setOutput: { | self, output |
		case
		{ output == 1 } { self.set1; }
		{ output == 2 } { self.set2; }
		{ output == 3 } { self.set3; }
	},

	set1: { | self |
		self.output = ~mixer.s1;
		self.fader.set(\out, self.output);
		~scLang.sendMsg(\lightControl, \chordHarmChangeOutput, 1);
		self;
	},

	set2: { | self |
		self.output = ~mixer.s2;
		self.fader.set(\out, self.output);
		~scLang.sendMsg(\lightControl, \chordHarmChangeOutput, 2);
		self;
	},

	set3: { | self |
		self.output = ~mixer.s3;
		self.fader.set(\out, self.output);
		~scLang.sendMsg(\lightControl, \chordHarmChangeOutput, 3);
		self;
	},

	majorChord: { | self |
		self.harm1.set(\interval, -12);
		self.harm2.set(\interval, -8);
		self.harm3.set(\interval, -5);
		~scLang.sendMsg(\lightControl, \chordHarmMajor, 1);
		self;
	},

	minorChord: { | self |
		self.harm1.set(\interval, -12);
		self.harm2.set(\interval, -9);
		self.harm3.set(\interval, -5);
		~scLang.sendMsg(\lightControl, \chordHarmMinor, 1);
		self;
	},

	dimChord: { | self |
		self.harm1.set(\interval, -12);
		self.harm2.set(\interval, -8);
		self.harm3.set(\interval, -6);
		~scLang.sendMsg(\lightControl, \chordHarmDim, 1);
		self;
	},

	augChord: { | self |
		self.harm1.set(\interval, -12);
		self.harm2.set(\interval, -8);
		self.harm3.set(\interval, -4);
		~scLang.sendMsg(\lightControl, \chordHarmAug, 1);
		self;
	},

	p4: { | self |
		self.harm3.set(\interval, -5);
		~scLang.sendMsg(\lightControl, \chordHarmp4), 1;
		self;
	},

	tt: { | self |
		self.harm3.set(\interval, -6);
		~scLang.sendMsg(\lightControl, \chordHarmtt, 1);
		self;
	},

	octave: { | self |
		self.harm1.set(\interval, -12);
		~scLang.sendMsg(\lightcontrol, \chordHarmOctave, 1)
		self;
	},

	major7: { | self |
		self.harm1.set(\interval, -11);
		~scLang.sendMsg(\lightControl, \chordHarmMajor7, 1);
		self;
	},
)