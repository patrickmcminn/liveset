/*
Monday, August 5th 2013
backing.scd
prm
*/

~interlude.backing = (

	state: 0,
	muteState: 1,
	playState: 0,

	in: ~inst.mic,
	out: ~mixer.s2,

	spawn: { | self |
		if( self.state == 0, { self.init }, { self.kill });
		self;
	},

	init: { | self |
		self.state = 1;
		self.makeBuffers;
		self.makeBusses;
		self.makeSynths;
		self;
	},

	kill: { | self |
		self.state = 0;
		self.stopTexture;
		self.killBuffers;
		self.killBusses;
		self.killSynths;
		self;
	},

	makeBuffers: { | self |
		var path = "/Users/patrickmcminn/Documents/Music/Current Work/Patrick McMinn/liveset/data/sampled/Interlude/";
		self.textureBuf = [
			Buffer.read(s, path ++ "texture01.aif"),
			Buffer.read(s, path ++ "texture02.aif"),
			Buffer.read(s, path ++ "texture03.aif"),
			Buffer.read(s, path ++ "texture04.aif"),
			Buffer.read(s, path ++ "texture05.aif"),
			Buffer.read(s, path ++ "texture06.aif"),
			Buffer.read(s, path ++ "texture07.aif"),
			Buffer.read(s, path ++ "texture08.aif"),
			Buffer.read(s, path ++ "texture09.aif"),
			Buffer.read(s, path ++ "texture10.aif"),
			Buffer.read(s, path ++ "texture11.aif")
		];
		self.shotBuf = [
			Buffer.read(s, path ++ "shot01.aif"),
			Buffer.read(s, path ++ "shot02.aif"),
			Buffer.read(s, path ++ "shot03.aif"),
			Buffer.read(s, path ++ "shot04.aif"),
			Buffer.read(s, path ++ "shot05.aif"),
			Buffer.read(s, path ++ "shot06.aif"),
			Buffer.read(s, path ++ "shot07.aif")
		];
		self;
	},

	killBuffers: { | self |
		self.textureBuf.size.do({ | i | self.textureBuf[i].free; });
		self.shotBuf.size.do({ | i | self.shotBuf[i].free; });
		self;
	},

	makeBusses: { | self |
		self.mainBus = Bus.audio;
		self.faderBus = Bus.audio(s, 2);
		self;
	},

	killBusses: { | self |
		self.mainBus.free;
		self.faderBus.free;
		self;
	},

	makeSynths: { | self |
		self.inFader = Synth.tail(~group.fx, \fader, [\in, self.in, \out, self.mainBus]);
		self.fader = Synth.tail(~group.fx, \stereoFader, [\in, self.faderBus, \out, self.out, \amp, -6.dbamp]);
		self;
	},

	killSynths: { | self |
		self.inFader.free;
		self.fader.free;
		self;
	},

	stopTexture: { | self |
		if( self.playState == 1,
			{
				self.texture.free;
				self.playState = 0;
		});
		self;
	},

	playTexture: { | self, num |
		if ( self.playState == 0,
			{
				self.texture = Synth.before(self.fader, \bufferGranAmp, [\in, self.mainBus, \out, self.faderBus,
					\buffer, self.textureBuf[num-1], \amp, 1, \env, ~grainBufs.gabWide]);
			},
			{
				self.texture.set(\buffer, self.textureBuf[num-1]);
			}
		);
		self.playState = 1;
		self;
	},

	playShot: { | self, num |
		Synth.before(self.fader, \playBufStereo, [\bufName, self.shotBuf[num-1],
			\sustain, self.shotBuf[num-1].numFrames/s.sampleRate, \out, self.faderBus]);
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
	}

)