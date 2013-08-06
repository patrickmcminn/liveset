/*
Monday, July 15th 2013
poppyOhm.scd
prm
*/

~interludeOhm.backing = (

	main: 0,
	stop: 8,
	dist: 16,

	texture: [1, 9, 17, 25, 2, 10, 18, 26, 3, 11, 19],

	shot: [4, 12, 20, 5, 13, 21, 6],

	vol: 15,

	makeOSC: { | self |
		OSCdef(\interludeBackingOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \backingTop} { self.spawn(val); }
		}, \interludeControl, ~scLang);

		OSCdef(\interludeBackingOhmRestore, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \backingButtons } { if( val == 1,
				{ self.makeStopMIDI; self.makeDistMIDI; self.makeTextureMIDI; self.makeShotMIDI; }) }
			{ id == \backingVol } { if ( val == 1, { self.makeVol }); }

		}, \restoreOhmInterlude, ~scLang);

		self;
	},

	killOSC: { | self |
		OSCdef(\interludeBackingOhm).free;
		OSCdef(\interludeBackingOhmRestore).free;
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
		self.makeStop;
		self.makeDist;
		self.makeTextureButtons;
		self.makeShotButtons;
		~restoreOhm.interlude.backingButtons = 1;

	},

	killButtons: { | self |
		self.topOhm(0);
		self.killStop;
		self.killDist;
		self.killTextureButtons;
		self.killShotButtons;
		~restoreOhm.interlude.backingButtons = 0;
	},


	topOhm: { | self, val |
		if( val == 1,
			{
				~ohm.turnWhite(self.main);
				~restoreOhm.improv.page.put(self.main, \white);
			},
			{
				~ohm.turnRed(self.main);
				~restoreOhm.improv.page.put(self.main, \red);
			}
		);
		self;
	},

	makeStop: { | self |
		~ohm.turnRed(self.stop);
		~restoreOhm.improv.page.put(self.stop, \red);
		self.makeStopMIDI;
		self;
	},

	killStop: { | self |
		~ohm.turnOff(self.stop);
		~restoreOhm.improv.page.put(self.stop, \off);
		self.killStopMIDI;
		self;
	},

	makeStopMIDI: { | self |
		MIDIdef.noteOn(\textureStop, {
			~interlude.backing.textureStop;
			~scLang.sendMsg(\interludeControl, \stop); }, self.stop);
		self;
	},

	killStopMIDI: { | self |
		MIDIdef(\textureStop).free;
		self;
	},

	stopOhm: { | self |
		self.texture.do({ | num, i |
			~ohm.turnCyan(self.texture[num]);
			~restoreOhm.interlude.page.put(self.texture[num], \cyan);
		});
	},

	makeDist: { | self |
		~ohm.turnPurple(self.dist);
		~restoreOhm.interlude.page.put(self.dist, \purple);
		self.makeDistMIDI;
		self;
	},

	killDist: { | self |
		~ohm.turnOff(self.dist);
		~restoreOhm.interlude.page.put(self.dist, \off);
		self.killDistMIDI;
		self;
	},

	makeDistMIDI: { | self |
		MIDIdef.noteOn(\backingDistOn, {
			~interlude.backing.texture.set(\amp, 100);
			~scLang.sendMsg(\interludeControl, \dist, 1);
		}, self.dist);
		MIDIdef.noteOff(\backingDistOff, {
			~interlude.backing.texture.set(\amp, 1);
			~scLang.sendMsg(\interludeControl, \dist, 0);
		}, self.dist);
		self;
	},

	killDistMIDI: { | self |
		MIDIdef(\backingDistOn).free;
		MIDIdef(\backingDistOff).free;
		self;
	},

	distOhm: { | self, val |
		if( val == 1, { ~ohm.turnRed(self.dist) }, { ~ohm.turnPurple(self.dist) });
		self;
	},

	makeTextureButtons: { | self |
		self.texture.do({ | num, i |
			~ohm.turnCyan(self.texture[num]);
			~restoreOhm.interlude.page.put(self.texture[num], \cyan);
		});
		self.makeTextureMIDI;
		self;
	},

	killTextureButtons: { | self |
		self.texture.do({ | i |
			~ohm.turnOff(self.texture[i]);
			~restoreOhm.interlude.page.put(self.texture[i], \off);
		});
		self.killTextureMIDI;
		self;
	},

	makeTextureMIDI: { | self |
		self.texture.do({ | num, i |
			MIDIdef.noteOn("texture" ++ (i + 1), {
				~interlude.backing.playTexture(i + 1);
				~scLang.sendMsg(\interludeControl, \texture, num);
			}, num);
		});
		self;
	},

	killTextureMIDI: { | self |
		self.texture.do({ | num, i |
			MIDIdef("texture" ++ (i + 1)).free;
		});
	},

	textureOhm: { | self, val |
		self.texture.do({ | i |
			~ohm.turnCyan(self.texture[i]);
			~restoreOhm.interlude.page.put(self.texture[num], \cyan);
		});
		~ohm.turnGreen(val);
		~restoreOhm.interlude.page.put(val, \green);
	},

	makeShotButtons: { | self |
		self.shot.do({ | num, i |
			~ohm.turnYellow(self.shot[num]);
			~restoreOhm.interlude.page.put(self.shot[num], \yellow);
		});
		self.makeShotMIDI;
		self;
	},

	killShotButtons: { | self |
		self.shot.do({ | num, i |
			~ohm.turnOff(self.shot[num]);
			~restoreOhm.interlude.page.put(self.shot[num], \off);
		});
		self.killShotMIDI;
		self;
	},

	makeShotMIDI: { | self |
		self.shot.do({ | num, i |
			MIDIdef.noteOn("shot" ++ (i + 1), {
				~interlude.backing.playShot(i + 1);
				~scLang.sendMsg(\interludeControl, \shot, (i + 1));
			}, num);
		});
		self;
	},

	killShotMIDI: { | self |
		self.shot.do({ | num, i | MIDIdef("shot" ++ (i + 1)).free; });
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
		MIDIdef.cc(\interludeBackingVol, { | val |
			var amp = val.linlin(0, 127, 0, 0.dbamp);
			~interlude.backing.fader.set(\amp, amp);
		}, self.vol);
		~restoreOhm.interlude.backingVol = 1;
		self;
	},

	killVol: { | self |
		MIDIdef(\interludeBackingVol).free;
		~restoreOhm.interlude.backingVol = 0;
		self;
	},

	makeDials: { | self |
		self;
	},

	killDials: { | self |
		self;
	},
)