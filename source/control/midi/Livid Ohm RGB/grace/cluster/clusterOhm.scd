/*
Monday, July 15th 2013
poppyOhm.scd
prm
*/

~graceOhm.cluster = (

	main: 2,
	toggle: 10,
	playCluster: 18,
  clusterTran: 26,

	vol: 22,
	cutoff: 20,

	makeOSC: { | self |
		OSCdef(\graceClusterOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \clusterTop } { self.spawn(val); }
			{ id == \clusterMute } { self.toggleOhm(val); }
			{ id == \clusterPlay } { self.playOhm(val); }
      { id == \clusterTran } { self.tranOhm(val); }

		}, \graceControl, ~scLang);

		OSCdef(\graceClusterOhmRestore, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \clusterToggle } { if ( val == 1, { self.makeToggleMIDI; }) }
			{ id == \clusterPlay } { if ( val == 1, { self.makeClusterMIDI; }) }
      { id == \clusterTran } { if ( val == 1, { self.makeTranMIDI; }) }
			{ id == \clusterVol } { if (val == 1, { self.makeVol;} ) }
			{ id == \clusterCutoff } { if ( val == 1, { self.makeCutoff; } ) }

		}, \restoreOhmGrace, ~scLang);

		self;
	},

	killOSC: { | self |
		OSCdef(\graceClusterOhm).free;
		OSCdef(\graceClusterOhmRestore).free;
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
		self.makeClusterPlay;
    self.makeTran;


	},

	killButtons: { | self |
		self.topOhm(0);
		self.killToggle;
		self.killClusterPlay;
    self.killTran;
	},

	topOhm: { | self, val |
		if( val == 1,
			{
				~ohm.turnPurple(self.main);
				~restoreOhm.grace.page.put(self.main, \purple);
			},
			{
				~ohm.turnRed(self.main);
				~restoreOhm.grace.page.put(self.main, \red);
			}
		);
		self;
	},

	makeToggle: { | self |
		~ohm.turnRed(self.toggle);
		~restoreOhm.grace.page.put(self.toggle, \red);
		self.makeToggleMIDI;
		~restoreOhm.grace.clusterToggle = 1;
		self;
	},

	killToggle: { | self |
		~ohm.turnOff(self.toggle);
		~restoreOhm.grace.page.put(self.toggle, \off);
		self.killToggleMIDI;
		~restoreOhm.grace.clusterToggle = 0;
		self;
	},

	makeToggleMIDI: { | self |
		MIDIdef.noteOn(\graceClusterToggle, {
			~grace.cluster.toggleMute;
			~scLang.sendMsg(\graceControl, \clusterMute, ~grace.cluster.muteState);
		}, self.toggle);
		self;
	},

	killToggleMIDI: { | self |
		MIDIdef(\graceClusterToggle).free;
		self;
	},

	toggleOhm: { | self, val |
		case
		{ val == 1 } { ~ohm.turnRed(self.toggle); ~restoreOhm.grace.page.put(self.toggle, \red); }
		{ val == 0 } { ~ohm.turnGreen(self.toggle); ~restoreOhm.grace.page.put(self.toggle, \green); }
	},

	makeClusterPlay: { | self |
		~ohm.turnBlue(self.playCluster);
		~restoreOhm.grace.page.put(self.playCluster, \blue);
		self.makeClusterMIDI;
		~restoreOhm.grace.clusterPlay = 1;
		self;
	},

	killClusterPlay: { | self |
		~ohm.turnOff(self.playCluster);
		~restoreOhm.grace.page.put(self.playCluster, \off);
		self.killClusterMIDI;
		~restoreOhm.grace.clusterPlay = 0;
		self;
	},

	makeClusterMIDI:{ | self |
		MIDIdef.noteOn(\graceClusterPlay, {
			~grace.cluster.toggleCluster;
			~scLang.sendMsg(\graceControl, \clusterPlay, ~grace.cluster.playState);
		}, self.playCluster);
		self;
	},

	killClusterMIDI: { | self |
		MIDIdef(\graceClusterPlay).free;
		self;
	},

	playOhm: { | self, val |
		case
		{ val == 1 } { ~ohm.turnGreen(self.playCluster); ~restoreOhm.grace.page.put(self.playCluster, \green); }
		{ val == 0 } { ~ohm.turnRed(self.playCluster); ~restoreOhm.grace.page.put(self.playCluster, \red); }
	},

  makeTran: { | self |
    ~ohm.turnPurple(self.clusterTran);
    ~restoreOhm.grace.page.put(self.clusterTran, \purple);
    self.makeTranMIDI;
    ~restoreOhm.grace.clusterTran = 1;
    self;
  },

  killTran: { | self |
    ~ohm.turnOff(self.clusterTran);
    ~restoreOhm.grace.page.put(self.clusterTran, \off);
    self.killTranMIDI;
    ~restoreOhm.grace.clusterTran = 0;
    self;
  },

  makeTranMIDI: { | self |
    MIDIdef.noteOn(\graceClusterTran, {
      ~grace.cluster.toggleTransition;
      ~scLang.sendMsg(\graceControl, \clusterTran, ~grace.cluster.transitionState);
    }, self.clusterTran);
    self;
  },

  killTranMIDI: { | self |
    MIDIdef(\graceClusterTran).free;
    self;
  },

  tranOhm: { | self, val |
    case
    { val == 1 } { ~ohm.turnYellow(self.clusterTran); ~restoreOhm.grace.page.put(self.clusterTran, \yellow); }
    { val == 0 } { ~ohm.turnRed(self.clusterTran); ~restoreOhm.grace.page.put(self.clusterTran, \red); }
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
		MIDIdef.cc(\graceClusterVol, { | val |
			var amp = val.linlin(0, 127, 0, -6.dbamp);
			~grace.cluster.fader.set(\amp, amp);
		}, self.vol);
		~restoreOhm.grace.clusterVol = 1;
		self;
	},

	killVol: { | self |
		MIDIdef(\graceClusterVol).free;
		~restoreOhm.grace.clusterVol = 0;
		self;
	},

	makeDials: { | self |
		self.makeCutoff;
		self;
	},

	killDials: { | self |
		self.killCutoff;
		self;
	},

	makeCutoff: { | self |
		MIDIdef.cc(\clusterCutoff, { | val |
			var cutoff = val.linlin(0, 127, 400, 15000);
			~grace.cluster.filter.set(\cutoff, cutoff);
		}, self.cutoff);
		~restoreOhm.grace.clusterCutoff = 1;
		self;
	},

	killCutoff: { | self |
		MIDIdef(\clusterCutoff).free;
		~restoreOhm.grace.clusterCutoff = 0;
		self;
	},
);