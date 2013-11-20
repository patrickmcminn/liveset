/*
Tuesday, November 19th 2013
pitchSequencer.scd
prm
*/

~grace.pitchSequencer = (

  state: 0,
	muteState: 0,
	output: ~mixer.s3,
  input: ~inst.mic,

  shiftArray1: nil,
  durArray1: nil,
  ampArray1: nil,

  shiftArray2: nil,
  durArray2: nil,
  ampArray2: nil,


	spawn: { | self |
		if( self.state == 0, { self.init; }, { self.kill; });
		self;
	},

	init: { | self |
		{
      self.makeGroups;
      self.makeBuffers;
      self.makeBusses;
      self.makeSynths;
      0.1.wait;
      self.makeShiftArray1;
      self.makeShiftArray2;
      self.makeDurArray;
      self.state = 1;
      self;
    }.fork;
	},

	kill: { | self |
		self.killGroups;
		self.killBuffers;
		self.killSynths;
    self.killBusses;
		self.state = 0;
		self;
	},

	makeGroups: { | self |

		self;
	},

	killGroups: { | self |

		self;
	},

	makeBusses: { | self |
    self.verbBus = Bus.audio;
    self.pitchBus = Bus.audio;
    self.faderBus = Bus.audio;
		self;
	},

	killBusses: { | self |
    self.verbBus.free;
    self.pitchBus.free;
    self.faderBus.free;
		self;
	},

	makeSynths: { | self |
    self.inFader = Synth.tail(~group.fx, \fader, [\in, self.input, \out, self.verbBus, \amp, 1]);
    self.verb = Synth.tail(~group.fx, \reverb1, [\in, self.verbBus, \out, self.pitchBus, \amp, 3.dbamp,
        \mix, 0.35, \room, 0.88, \damp, 0.9]);
    self.fader = Synth.tail(~group.fx, \pan, [\in, self.faderBus, \out, self.output, \amp, -6.dbamp]);
    self.sequencer1 = ShiftSequencer(self.pitchBus, self.faderBus, 1, 106.6, self.fader, \addBefore);
    self.sequencer2 = ShiftSequencer(self.pitchBus, self.faderBus, 1, 106.6, self.fader, \addBefore);
		self;
	},

	killSynths: { | self |
    self.inFader.free;
    self.verb.free;
    self.sequencer1.free;
    self.sequencer2.free;
    self.fader.free;
		self;
	},

  makeShiftArray1: { | self |
    self.shiftArray1 = [0, -2, 0, 2, 4];
    self.sequencer1.setShiftArray(self.shiftArray1);
    self;
  },

  makeShiftArray2: { | self |
    self.shiftArray2 = [7, 9, 7, 5];
    self.sequencer2.setShiftArray(self.shiftArray2);
    self;
  },

  makeDurArray: { | self |
    self.durArray1 = [1/6];
    self.sequencer1.setDurArray(self.durArray1);
    self.sequencer2.setDurArray(self.durArray1);
    self;
  },

	muteToggle: { | self |
		if( self.muteState == 1, { self.mute; }, { self.unmute; });
		self;
	},

	mute: { | self |
		self.inFader.set(\mute, 0);
		self.muteState = 0;
		self;
	},

	unmute: { | self |
		self.inFader.set(\mute, 1);
		self.muteState = 1;
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
		self;
	},

	set2: { | self |
		self.output = ~mixer.s2;
		self.fader.set(\out, self.output);
		self;
	},

	set3: { | self |
		self.output = ~mixer.s3;
		self.fader.set(\out, self.output);
		self;
	},

);