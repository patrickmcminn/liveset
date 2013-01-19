/*
Monday, January 14th 2012
sustainPedal.scd
prm
*/


~sustainPedal = (

	onsetBus: nil,
	faderBus: nil,

	sustainBuf: nil,

	inFader: nil,
	sustain: nil,
	fader: nil,
	onset: nil,

	sustainArray: nil,

	makeSustainArray: { | self, sustainedNotes = 16 |
		self.sustainArray = Array.newClear(16);
		self;
	},

	makeOSC: { | self, in, out, bufLength = 0.5 release = 15, amp = 0.7, group |
		OSCdef(\sustainPedalTrig, {
			self.synthSpawn(self.cycler, in, out, release, amp, group);
		}, '\tr');
		self;
	},


	freeOSC: { | self |
		OSCdef(\sustainPedalTrig).free;
	},

	makeCycler: { | self |
		r({
			loop {
				var i = 0;
				(i = i + 1).yield;
			}
		});
	},

	cycler: { | self |
		self.makeCycler.next;
		self;
	},

	synthSpawn: { | self, bufName, in, out, bufLength = 0.5, release = 15, amp = 0.7, group |
		var bufRec, sustainer;
		// zero the buffer
		self.sustainBuf.wrapAt(bufName).zero;
		// free synth at index
		self.sustainArray.wrapAt(bufName).free;
		bufRec = Synth(\recordBuf, [\in, in, \bufName, self.sustainBuf.wrapAt(bufName)],
			group, \addToTail);
		sustainer = TempoClock.sched(bufLength, {
			self.sustainArray.wrapPut(bufName,
				Synth(\sustainerPlayer, [\out, out, \bufName, self.sustainBuf.wrapAt(bufName), \release, release,
					\amp, amp], group, \addToTail));
		});
		self;
	},

	makeBusses: { | self |
		self.onsetBus = Bus.audio;
		self;
	},
	freeBusses: { | self |
		self.onsetBus.free;
		self;
	},

	makeBuffers: { | self, sustainedNotes = 16, bufLength = 0.5 |
		self.sustainBuf = Buffer.allocConsecutive(sustainedNotes, s, s.sampleRate * bufLength, 1);
		self;
	},

	freeBuffers: { | self |
		self.sustainBuf.do({ | i | i.free; });
		self;
	},

	makeSynths: { | self, in, group |
		self.inFader = Synth(\fader, [\in, in, \out, self.onsetBus], group, \addToTail);
		self.onset = Synth(\onsetDetectorTrig, [\in, self.onsetBus, \id, 0, \thresh, 0.005, \fastMul, 0.65],
			group, \addToTail);
		self;
	},

	freeSynths: { | self |
		self.inFader.free;
		self.onset.free;
	},

	init: { | self, in, out, group, bufLength = 0.5, sustainedNotes = 16, release = 15, amp = 0.7 |
		self.makeSustainArray(sustainedNotes);
		self.makeBusses;
		self.makeBuffers(sustainedNotes, bufLength);
		self.makeOSC(in, out, bufLength, release, amp, group);
		self.makeSynths(in, group);
		self;
	},

	kill: { | self |
		self.freeBusses;
		self.freeBuffers;
		self.freeOSC;
		self.freeSynths;
		self;
	},

	mute: { | self |
		self.inFader.set(\mute, 0);
		self;
	},

	unmute: { | self |
		self.inFader.set(\mute, 1);
	}


);


~sustainPedal.init(~inst[\mute], ~mixer[\s1])
~sustainPedal.kill

~sustainPedal.makeBusses
~sustainPedal.makeBuffers
~sustainPedal.makeSynths
~sustainPedal.makeSustainArray
~sustainPedal.synthSpawn(0)

~sustainPedal.sustainBuf.at(0)

/*
(
~sustainPedal = {| bufLength = 0.5, sustainedNotes = 16, release 15, amp = 0.7 |
	var cycler, synthTrigger;
	~sustainArray = Array.newClear(sustainedNotes);
	~sustainBufs = Buffer.allocConsecutive(sustainedNotes, s, s.sampleRate * bufLength, 1);
	~sustainBus = Bus.audio;
	 cycler = Routine({	// simple counter
		 var i = 0;
		 loop{
			 i = i + 1;
			 i.yield;
		 };
	 });
	 synthTrigger = { |  bufName |	// takes counter values and spawns Synths w/ different buffers
		 var bufRec, sustainer;
		 ~sustainBufs.wrapAt(bufName).zero;	// zero the buffer
		 ~sustainArray.wrapAt(bufName).free;	// free the Synth in the Array index
		 bufRec = Synth(\recordBuf, [\in, ~ensembleBus, \bufName, ~sustainBufs.wrapAt(bufName)], 			~fx, addAction: \addToTail);
		 sustainer = TempoClock.sched(bufLength, {
			 ~sustainArray.wrapPut(bufName, Synth(\sustainerPlayer,
			 	[\out, ~fxBus, \bufName, ~sustainBufs.wrapAt(bufName), \release, release,
	 		 	\amp, amp], ~fx, addAction: \addToTail))});
	 };
	 p.remove;
	 p = OSCresponderNode(s.addr, '\tr', { synthTrigger.(cycler.value)} ).add;
	 ~onset = Synth(\onsetDetectorTrig, [\in, ~ensembleBus, \id, 0, \thresh, 0.005,
	 		\fastMul, 0.65], ~fx, addAction: \addToTail);
};

~sustainPedalFree = {
	p.remove;
	~onset.free;
	~sustainBufs.do(_.free);
	~sustainArray.size.do({ | i | ~sustainArray.at(i).free; });
	~sustainBus.free;
};
);
*/