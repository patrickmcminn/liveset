/*
Tuesday, July 16th 2013
controls.scd
prm
*/

~improvOhm.huge.controls = (

	state: 0,

	vol: 14,
	subVol: 15,
	shiftVol: 22,
	grainVol: 23,

	cutoffRate: 17,
	cutoffLo: 16,
	cutoffHi: 9,
	res: 8,

  cutoff: 19,
  delayAmp: 18,
	delayTime: 11,
	feedback: 10,

	verbMix: 21,
	modFreq: 20,
	trigLo: 13,
	trigHi: 12,

	init: { | self |
		self.makeFaders;
		self.makeDials;
		self.state = 1;
		self;
	},

	kill: { | self |
		self.killFaders;
		self.killDials;
		self.state = 0;
		self;
	},

	makeFaders: { | self |
		self.makeVolume;
		self.makeSubVolume;
		self.makeShiftVolume;
		self.makeGrainVolume;
		self;
	},

	killFaders: { | self |
		self.killVolume;
		self.killSubVolume;
		self.killShiftVolume;
		self.killGrainVolume;
		self;
	},

	makeVolume: { | self |
		MIDIdef.cc(\hugeVolume, { | val |
			var amp = val.linlin(0, 127, 0, -2.dbamp);
			~improv.huge.main.set(\amp, amp);
		}, self.vol);
		self;
	},

	killVolume: { | self |
		MIDIdef(\hugeVolume).free;
		self;
	},

	makeSubVolume: { | self |
		MIDIdef.cc(\hugeSubVolume, { | val |
			var amp = val.linlin(0, 127, 0, 1);
			~improv.huge.main.set(\subAmp, amp);
		}, self.subVol);
		self;
	},

	killSubVolume: { | self |
		MIDIdef(\hugeSubVolume).free;
		self;
	},

	makeShiftVolume: { | self |
		MIDIdef.cc(\hugeShiftVolume, { | val |
			var amp = val.linlin(0, 127, 0, 1);
			~improv.huge.main.set(\shiftAmp, amp);
		}, self.shiftVol);
		self;
	},

	killShiftVolume: { | self |
		MIDIdef(\hugeShiftVolume).free;
		self;
	},

	makeGrainVolume: { | self |
		MIDIdef.cc(\hugeGrainVolume, { | val |
			var amp = val.linlin(0, 127, 0, -12.dbamp);
			~improv.huge.main.set(\grainAmp, amp);
		}, self.grainVol);
		self;
	},

	killGrainVolume: { | self |
		MIDIdef(\hugeGrainVolume).free;
		self;
	},

	makeDials: { | self |
		//self.makeDist;
		self.makeCutoff;
    self.makeVerbMix;
		self.makeModFreq;
		self.makeTrigLo;
		self.makeTrigHi;
		//self.makeRateLo;
		//self.makeRateHi;
		self.makeCutoffLo;
		self.makeCutoffHi;
		self.makeCutoffRate;
		self.makeRes;
    self.makeDelayAmp;
		self.makeDelayTime;
    self.makeFeedback;
		self;
	},

	killDials: { | self |
		self.killDist;
    self.killCutoff;
		self.killVerbMix;
		self.killModFreq;
		self.killTrigLo;
		self.killTrigHi;
		//self.killRateLo;
		//self.killRateHi;
		self.killCutoffLo;
		self.killCutoffHi;
		self.killCutoffRate;
		self.killRes;
		self.killDelayTime;
    self.killFeedback;
    self.killDelayAmp;
		self;
	},

	makeDist: { | self |
		MIDIdef.cc(\hugeDist, { | val |
			var dist = val.linexp(0, 127, 1, 10000);
			~improv.huge.main.set(\dist, dist);
		}, self.dist);
		self;
		self;
	},

	killDist: { | self |
		MIDIdef(\hugeDist).free;
		self;
	},

	makeCutoff: { | self |
		MIDIdef.cc(\hugeCutoff, { | val |
			var cutoff = val.linexp(0, 127, 100, 7000);
			~improv.huge.main.set(\cutoff, cutoff);
		}, self.cutoff);
		self;
		self;
	},

	killCutoff: { | self |
		MIDIdef(\hugeCutoff).free;
		self;
	},

	makeModFreq: { | self |
		MIDIdef.cc(\hugeModFreq, { | val |
			var freq = val.linexp(0, 127, 0.05, 100);
			~improv.huge.main.set(\modFreq, freq);
		}, self.modFreq);
		self;
	},

	killModFreq: { | self |
		MIDIdef(\hugeModFreq).free;
		self;
	},

	makeTrigLo: { | self |
		MIDIdef.cc(\hugeTrigLo, { | val |
			var lo = val.linexp(0, 127, 1.0, 50.0);
			~improv.huge.main.set(\trigLo, lo);
		}, self.trigLo);
		self;
	},

	killTrigLo: { | self |
		MIDIdef(\hugeTrigLo).free;
		self;
	},

	makeTrigHi: { | self |
		MIDIdef.cc(\hugeTrigHi, { | val |
			var hi = val.linexp(0, 127, 5.0, 100.0);
			~improv.huge.main.set(\trigHi, hi);
		}, self.trigHi);
		self;
	},

	killTrigHi: { | self |
		MIDIdef(\hugeTrigHi).free;
		self;
	},

	makeRateLo: { | self |
		MIDIdef.cc(\hugeRateLo, { | val |
			var lo = val.linexp(0, 127, 1, 25);
			~improv.huge.main.set(\rateLo, lo);
		}, self.rateLo);
		self;
	},

	killRateLo: { | self |
		MIDIdef(\hugeRateLo).free;
		self;
	},

	makeRateHi: { | self |
		MIDIdef.cc(\hugeRateHi, { | val |
			var hi = val.linexp(0, 127, 1, 500);
			~improv.huge.main.set(\rateHi, hi);
		}, self.rateHi);
		self;
	},

	killRateHi: { | self |
		MIDIdef(\hugeRateHi).free;
		self;
	},

	makeCutoffLo: { | self |
		MIDIdef.cc(\hugeCutoffLo, { | val |
			var lo = val.linlin(0, 127, 150, 4000);
			~improv.huge.main.set(\cutoffLo, lo);
		}, self.cutoffLo);
		self;
	},

	killCutoffLo: { | self |
		MIDIdef(\hugeCutoffLo).free;
		self;
	},

	makeCutoffHi: { | self |
		MIDIdef.cc(\hugeCutoffHi, { | val |
			var hi = val.linlin(0, 127, 500, 10000);
			~improv.huge.main.set(\cutoffHi, hi);
		}, self.cutoffHi);
		self;
	},

	killCutoffHi: { | self |
		MIDIdef(\hugeCutoffHi).free;
		self;
	},

	makeCutoffRate: { | self |
		MIDIdef.cc(\hugeCutoffRate, { | val |
			var rate = val.linlin(0, 127, 0.1, 100);
			~improv.huge.main.set(\cutoffChangeRate, rate);
		}, self.cutoffRate);
		self;
	},

	killCutoffRate: { | self |
		MIDIdef(\hugeCutoffRate).free;
		self;
	},

	makeRes: { | self |
		MIDIdef.cc(\hugeRes, { | val |
			var res = val.linlin(0, 127, 1, 0.1);
			~improv.huge.main.set(\res, res);
		}, self.res);
		self;
	},

	killRes: { | self |
		MIDIdef(\hugeRes).free;
		self;
	},

	makeDelayTime: { | self |
		MIDIdef.cc(\hugeDelayTime, { | val |
			var time = val.linlin(0, 127, 0, 1.5);
			~improv.huge.main.set(\delayTime, time);
		}, self.delayTime);
		self;
	},

	killDelayTime: { | self |
		MIDIdef(\hugeDelayTime).free;
		self;
	},

  makeDelayAmp: { | self |
    MIDIdef.cc(\hugeDelayMix, { | val |
      var amp = val.linlin(0, 127, 0, 1);
      ~improv.huge.main.set(\delayAmp, amp);
    }, self.delayAmp);
  },

  killDelayAmp: { | self | MIDIdef(\hugeDelayMix).free; },

  makeFeedback: { | self |
    MIDIdef.cc(\hugeDelayFeedback, { | val |
      var fb = val.linlin(0, 127, 0, 0.5);
      ~improv.huge.main.set(\feedback, fb);
    }, self.feedback);
  },

  killFeedback: { | self | MIDIdef(\hugeDelayFeedback).free; },

  makeVerbMix: { | self |
    MIDIdef.cc(\hugeVerbMix, { | val |
      var mix = val.linlin(0, 127, 0, 1);
      ~improv.huge.main.set(\verbMix, mix);
    }, self.verbMix);
  },

  killVerbMix: { | self | MIDIdef(\hugeVerbMix).free; }

)