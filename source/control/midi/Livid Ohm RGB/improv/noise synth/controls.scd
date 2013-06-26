/*
Sunday, June 23rd 2013
controls.scd
prm
*/

var vol;
var atk, dec, sus, rel, atkCoarse, relCoarse;
var cutoff, res, trem, tremToggle;

vol = 14;

atk = 19;
dec = 18;
sus = 11;
rel = 10;

atkCoarse = 9;
relCoarse = 8;

cutoff = 20;
res = 13;
trem = 12;
tremToggle = 64;


~improvOhm.noiseSynth.controls = (

	toggleState: 0,

	init: { | self |
		self.makeDials;
		self.makeFaders;
		self;
	},

	kill: { | self |
		self.killDials;
		self.killFaders;
		self;
	},

	makeFaders: { | self |
		MIDIdef.cc(\improvNoiseSynthVol, { | val |
			var vol = val.linlin(0, 127, 0, -2.dbamp);
			~scLang.sendMsg(\improvNoiseSynth, \volume, vol);
		}, vol);
		self;
	},

	killFaders: { | self |
		MIDIdef(\improvNoiseSynthVol).free;
		self;
	},

	makeDials: { | self |
		self.makeADSR;
		self.makeFilterDials;
		self.makeTrem;
		self;
	},

	killDials: { | self |
		self.killADSR;
		self.killFilterDials;
		self.killTrem;
		self;
	},

	makeADSR: { | self |
		MIDIdef.cc(\improvNoiseSynthAttack, { | val |
			var attack = val.linlin(0, 127, 0.01, 1.5);
			~scLang.sendMsg(\improvNoiseSynth, \atk, attack);
		}, atk);
		MIDIdef.cc(\improvNoiseSynthDecay, { | val |
			var decay = val.linlin(0, 127, 0, 3);
			~scLang.sendMsg(\improvNoiseSynth, \dec, decay);
		}, dec);
		MIDIdef.cc(\improvNoiseSynthSustain, { | val |
			var sustain = val.linlin(0, 127, 0.0, 1.0);
			~scLang.sendMsg(\improvNoiseSynth, \sus, sustain);
		}, sus);
		MIDIdef.cc(\improvNoiseSynthRelease, { | val |
			var release = val.linlin(0, 127, 0.01, 3);
			~scLang.sendMsg(\improvNoiseSynth, \rel, release);
		}, rel);
		MIDIdef.cc(\improvNoiseSynthAttackCoarse, { | val |
			var attack = val.linexp(0, 127, 0.01, 15);
			~scLang.sendMsg(\improvNoiseSynth, \atk, attack);
		}, atkCoarse);
		MIDIdef.cc(\improvNoiseSynthReleaseCourse, { | val |
			var release = val.linexp(0, 127, 0.01, 60);
			~scLang.sendMsg(\improvNoiseSynth, \rel, release);
		}, relCoarse);
		self;
	},

	killADSR: { | self |
		MIDIdef(\improvNoiseSynthAttack).free;
		MIDIdef(\improvNoiseSynthDecay).free;
		MIDIdef(\improvNoiseSynthSustain).free;
		MIDIdef(\improvNoiseSynthRelease).free;
		MIDIdef(\improvseNoisSynthAttackCourse).free;
		MIDIdef(\improvNoisSynthReleaseCourse).free;
		self;
	},

	makeFilterDials: { | self |
		MIDIdef.cc(\improvNoiseSynthCutoff, { | val |
			var cutoff = val.linexp(0, 127, 200, 150000);
			~scLang.sendMsg(\improvNoiseSynth, \cutoff, cutoff);
		}, cutoff);
		MIDIdef.cc(\improvNoiseSynthRes, { | val |
			var res = val.linlin(0, 127, 0, 4);
			~scLang.sendMsg(\improvNoiseSynth, \res, res);
		}, res);
		self;
	},

	killFilterDials: { | self |
		MIDIdef(\improvNoiseSynthCutoff).free;
		MIDIdef(\improvNoiseSynthRes).free;
		self;
	},

	makeTremDial: { | self |
		MIDIdef.cc(\improvNoiseSynthTremolo, { | val |
			var trem = val.linlin(0, 127, 0.1, 50);
			~scLang.sendMsg(\improvNoiseSynth, \trem, trem);
		}, trem);
		self;
	},

	killTremDial: { | self |
		MIDIdef(\improvNoiseSynthTremolo).free;
		self;
	},
)