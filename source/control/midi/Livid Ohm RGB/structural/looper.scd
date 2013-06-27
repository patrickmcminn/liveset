/*
Friday, June 14th 2013
looper.scd
prm
*/

var s1Loop, s2Loop, s3Loop, masterLoop;
var s1Vol, s2Vol, s3Vol, masterVol;

s1Loop = 67;
s2Loop = 75;
s3Loop = 68;
masterLoop = 76;

s1Vol = 3;
s2Vol = 1;
s3Vol = 0;
masterVol = 2;


OSCdef(\looperOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \looper } { ~structureOhm.looper.value; }
	{ id == \looperCtrl } { ~structureOhm.looperCtrl.value; }
	{ id == \loopFree } { ~structureOhm.loopFree.value; }
	{ id == \masterLoop } { ~structureOhm.masterLoop.value; }
	{ id == \s1Loop } { ~structureOhm.s1Loop.value; }
	{ id == \s2Loop } { ~structureOhm.s2Loop.value; }
	{ id == \s3Loop } { ~structureOhm.s3Loop.value; }
}, \control, ~scLang);



OSCdef(\looperOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);

	case
	{ id == \looper } {
		if ( val == 1, { ~structureOhmMidi.looper.init; } )
	}

	{ id == \looperCtrl } {
		if (val == 1, { ~structureOhmMidi.looperCtrl.init; } )
	}

	{ id == \loopFree } {
		if ( val == 1, { ~structureOhmMidi.loopFree.init; } )
	}

	{ id == \masterLoop } {
		if ( val == 1, { ~structureOhmMidi.masterLoopGreen.value; } )
	}

	{ id == \s1Loop } {
		if ( val == 1, { ~structureOhmMidi.s1LoopGreen.value; } )
	}

	{ id == \s2Loop } {
		if ( val == 1, { ~structureOhmMidi.s2LoopGreen.value; } )
	}

	{ id == \s3Loop } {
		if ( val == 1, { ~structureOhmMidi.s3LoopGreen.value; } )
	}
}, \restoreOhm, ~scLang);



~structureOhm.looper = r {
	loop{
			~restoreOhm.structure.looper = 1;
			~structureOhmMidi.looper.init;
			~restoreOhm.structure.page.put(s1Loop, \purple);
			~ohm.turnPurple(s1Loop);
			~restoreOhm.structure.page.put(s2Loop, \purple);
			~ohm.turnPurple(s2Loop);
			~restoreOhm.structure.page.put(s3Loop, \purple);
			~ohm.turnPurple(s3Loop);
			~restoreOhm.structure.page.put(masterLoop, \purple);
		["created looper MIDI Funcs on Ohm"].postln;
			~ohm.turnPurple(masterLoop).yield;

			~restoreOhm.structure.looper = 0;
			~structureOhmMidi.looper.kill;
			~restoreOhm.structure.page.put(s1Loop, \off);
			~ohm.turnOff(s1Loop);
			~restoreOhm.structure.page.put(s2Loop, \off);
			~ohm.turnOff(s2Loop);
			~restoreOhm.structure.page.put(s2Loop, \off);
			~ohm.turnOff(s3Loop);
			~restoreOhm.structure.page.put(masterLoop, \off);
		["killed looper MIDI Funcs on Ohm"].postln;
			~ohm.turnOff(masterLoop).yield;
	};
};

~structureOhm.masterLoop = r {
	loop {
		~structureOhmMidi.masterLoopGreen;
		(~restoreOhm.structure.masterLoop = 1).yield;

		~structureOhmMidi.masterLoopPurple.value;
		(~restoreOhm.structure.masterLoop = 0).yield;
	}
};

~structureOhmMidi.masterLoopGreen =  {
		~restoreOhm.structure.page.put(masterLoop, \green);
		~ohm.turnGreen(masterLoop);
	["Ohm: Recording Master"].postln;

};

~structureOhmMidi.masterLoopPurple =  {
		~restoreOhm.structure.page.put(masterLoop, \purple);
		~ohm.turnPurple(masterLoop);
	["Ohm: Stopped Recording Master"].postln;
};

~structureOhm.s1Loop = r {
	loop {
		~structureOhmMidi.s1LoopGreen;
		(~restoreOhm.structure.s1Loop = 1).yield;

		~structureOhmMidi.s1LoopPurple.value;
		(~restoreOhm.structure.s1Loop = 0).yield;
	}
};

~structureOhmMidi.s1LoopGreen =  {
	~restoreOhm.structure.page.put(s1Loop, \green);
	~ohm.turnGreen(s1Loop);
	["Ohm: Recording s1"].postln;

};

~structureOhmMidi.s1LoopPurple =  {
	~restoreOhm.structure.page.put(s1Loop, \purple);
	~ohm.turnPurple(s1Loop);
	["Ohm: Stopped Recording s1"].postln;
};

~structureOhm.s2Loop = r {
	loop {
		~structureOhmMidi.s2LoopGreen;
		(~restoreOhm.structure.s2Loop = 1).yield;

		~structureOhmMidi.s2LoopPurple.value;
		(~restoreOhm.structure.s2Loop = 0).yield;
	}
};

~structureOhmMidi.s2LoopGreen =  {
	~restoreOhm.structure.page.put(s2Loop, \green);
	~ohm.turnGreen(s2Loop);
	["Ohm: Recording s2"].postln;
};

~structureOhmMidi.s2LoopPurple =  {
	~restoreOhm.structure.page.put(s2Loop, \purple);
	~ohm.turnPurple(s2Loop);
	["Ohm: Stopped Recording s2"].postln;
};

~structureOhm.s3Loop = r {
	loop {
		~structureOhmMidi.s3LoopGreen;
		(~restoreOhm.structure.s3Loop = 1).yield;

		~structureOhmMidi.s3LoopPurple.value;
		(~restoreOhm.structure.s3Loop = 0).yield;
	}
};

~structureOhmMidi.s3LoopGreen =  {
	~restoreOhm.structure.page.put(s3Loop, \green);
	~ohm.turnGreen(s3Loop);
	["Ohm:  Recording s3"].postln;
};

~structureOhmMidi.s3LoopPurple =  {
	~restoreOhm.structure.page.put(s3Loop, \purple);
	~ohm.turnPurple(s3Loop);
	["Ohm: Stopped Recording s3"].postln;
};


~structureOhm.looperCtrl = r {
	loop {
		~structureOhmMidi.looperCtrl.init;
		~restoreOhm.structure.page.put(s1Loop, \pink);
		~ohm.turnPink(s1Loop);
		~restoreOhm.structure.page.put(s2Loop, \pink);
		~ohm.turnPink(s2Loop);
		~restoreOhm.structure.page.put(s3Loop, \pink);
		~ohm.turnPink(s3Loop);
		~restoreOhm.structure.page.put(masterLoop, \pink);
		~ohm.turnPink(masterLoop);
		["Ohm: Page to Control Loops"].postln;
		~restoreOhm.structure.looperCtrl = 1.yield;


		~structureOhmMidi.looperCtrl.kill;
		~restoreOhm.structure.page.put(s1Loop, \off);
		~ohm.turnOff(s1Loop);
		~restoreOhm.structure.page.put(s2Loop, \off);
		~ohm.turnOff(s2Loop);
		~restoreOhm.structure.page.put(s3Loop, \off);
		~ohm.turnOff(s3Loop);
		~restoreOhm.structure.page.put(masterLoop, \off);
		~ohm.turnOff(masterLoop);
		["Ohm: Turned Off Page to Control Loops"].postln;
		~restoreOhm.structure.looperCtrl = 0.yield;

	}
};

~structureOhm.loopFree = r {
	loop{
		~structureOhmMidi.loopFree.init;
		~restoreOhm.structure.page.put(s1Loop, \red);
		~ohm.turnRed(s1Loop);
		~restoreOhm.structure.page.put(s2Loop, \red);
		~ohm.turnRed(s2Loop);
		~restoreOhm.structure.page.put(s3Loop, \red);
		~ohm.turnRed(s3Loop);
		~restoreOhm.structure.page.put(masterLoop, \red);
		~ohm.turnRed(masterLoop);
		["Ohm: Page to Free Loops"].postln;
		~restoreOhm.structure.loopFree = 1.yield;

		~structureOhmMidi.loopFree.kill;
		~restoreOhm.structure.page.put(s1Loop, \off);
		~ohm.turnOff(s1Loop);
		~restoreOhm.structure.page.put(s2Loop, \off);
		~ohm.turnOff(s2Loop);
		~restoreOhm.structure.page.put(s3Loop, \off);
		~ohm.turnOff(s3Loop);
		~restoreOhm.structure.page.put(masterLoop, \off);
		~ohm.turnOff(masterLoop);
		["Ohm: Turned Off Page to Free Loops"].postln;
		~restoreOhm.structure.loopFree = 0.yield;
	};
};


~structureOhmMidi.looper = (

	init: { | self |
		self.makeButtons;
		self.makeKnobs;
		self.makeSliders;
		self;
	},

	kill: { | self |
		self.killButtons;
		self.killKnobs;
		self.killSliders;
		self;
	},

	makeButtons: { | self |
		MIDIdef.noteOn(\s1Loop, { ~scLang.sendMsg(\looper, \s1Loop); }, s1Loop);
		MIDIdef.noteOn(\s2Loop, { ~scLang.sendMsg(\looper, \s2Loop); }, s2Loop);
		MIDIdef.noteOn(\s3Loop, { ~scLang.sendMsg(\looper, \s3Loop); }, s3Loop);
		MIDIdef.noteOn(\masterLoop, { ~scLang.sendMsg(\looper, \masterLoop); }, masterLoop);
		self;
	},

	killButtons: { | self |
		MIDIdef(\s1Loop).free;
		MIDIdef(\s2Loop).free;
		MIDIdef(\s3Loop).free;
		MIDIdef(\masterLoop).free;
		self;
	},

	makeKnobs: { | self |

		MIDIdef.cc(\s1LoopVol, { | val |
			var amp = val.linlin(0, 127, 0, -2.dbamp);
			~scLang.sendMsg(\looper, \s1Vol, amp);
		}, s1Vol);

		MIDIdef.cc(\s2LoopVol, { | val |
			var amp = val.linlin(0, 127, 0, -2.dbamp);
			~scLang.sendMsg(\looper, \s2Vol, amp);
		}, s2Vol);

		MIDIdef.cc(\s3LoopVol, { | val |
			var amp = val.linlin(0, 127, 0, -2.dbamp);
			~scLang.sendMsg(\looper, \s3Vol, amp);
		}, s3Vol);

		MIDIdef.cc(\masterLoopVol, { | val |
			var amp = val.linlin(0, 127, 0, -2.dbamp);
			~scLang.sendMsg(\looper, \masterVol, amp);
		}, masterVol);

		self;
	},

	killKnobs: { | self |
		MIDIdef(\s1LoopVol).free;
		MIDIdef(\s2LoopVol).free;
		MIDIdef(\s3LoopVol).free;
		MIDIdef(\masterLoopVol).free;
		self;
	},

	makeSliders: { | self |

		self;
	},

	killSliders: { | self |

		self;
	}
);


~structureOhmMidi.looperCtrl = (
		init: { | self |
		self.makeButtons;
		self.makeKnobs;
		self.makeSliders;
		self;
	},

	kill: { | self |
		self.killButtons;
		self.killKnobs;
		self.killSliders;
		self;
	},

	makeButtons: { | self |
		MIDIdef.noteOn(\s1Beat, { ~scLang.sendMsg(\looper, \s1Beat); }, s1Loop);
		MIDIdef.noteOn(\s2Beat, { ~scLang.sendMsg(\looper, \s2Beat); }, s2Loop);
		MIDIdef.noteOn(\s3Beat, { ~scLang.sendMsg(\looper, \s3Beat); }, s3Loop);
		MIDIdef.noteOn(\masterBeat, { ~scLang.sendMsg(\looper, \masterBeat); }, masterLoop);
		self;
	},

	killButtons: { | self |
		MIDIdef(\s1Beat).free;
		MIDIdef(\s2Beat).free;
		MIDIdef(\s3Beat).free;
		MIDIdef(\masterBeat).free;
		self;
	},

	makeKnobs: { | self |
		MIDIdef.cc(\s1Grain, { | val |
			var size = val.linlin(0, 127, 0, 5).asInteger;
			~scLang.sendMsg(\looper, \s1Grain, size);
		}, s1Vol);
		MIDIdef.cc(\s2Grain, { | val |
			var size = val.linlin(0, 127, 0, 5).asInteger;
			~scLang.sendMsg(\looper, \s2Grain, size);
		}, s2Vol);
		MIDIdef.cc(\s3Grain, { | val |
			var size = val.linlin(0, 127, 0, 5).asInteger;
			~scLang.sendMsg(\looper, \s3Grain, size);
		}, s3Vol);
		MIDIdef.cc(\masterGrain, { | val |
			var size = val.linlin(0, 127, 0, 5).asInteger;
			~scLang.sendMsg(\looper, \masterGrain, size);
		}, masterVol);
		self;
	},

	killKnobs: { | self |
		MIDIdef(\s1Grain).free;
		MIDIdef(\s2Grain).free;
		MIDIdef(\s3Grain).free;
		MIDIdef(\masterGrain).free;
		self;
	},

	makeSliders: { | self |

		self;
	},

	killSliders: { | self |

		self;
	}

);



~structureOhmMidi.loopFree = (

	init: { | self |
		self.makeButtons;
		self.makeKnobs;
		self.makeSliders;
		self;
	},

	kill: { | self |
		self.killButtons;
		self.killKnobs;
		self.killSliders;
		self;
	},

	makeButtons: { | self |
		MIDIdef.noteOn(\s1Reset, { ~scLang.sendMsg(\looper, \s1Reset); }, s1Loop);
		MIDIdef.noteOn(\s2Reset, { ~scLang.sendMsg(\looper, \s2Reset); }, s2Loop);
		MIDIdef.noteOn(\s3Reset, { ~scLang.sendMsg(\looper, \s3Reset); }, s3Loop);
		MIDIdef.noteOn(\masterLoop, { ~scLang.sendMsg(\looper, \masterReset); }, masterLoop);
		self;
	},

	killButtons: { | self |
		MIDIdef(\s1Reset).free;
		MIDIdef(\s2Reset).free;
		MIDIdef(\s3Reset).free;
		MIDIdef(\masterReset).free;
		self;
	},

	makeKnobs: { | self |

		MIDIdef.cc(\s1LoopVol, { | val |
			var amp = val.linlin(0, 127, 0, -2.dbamp);
			~scLang.sendMsg(\looper, \s1Vol, amp);
		}, s1Vol);

		MIDIdef.cc(\s2LoopVol, { | val |
			var amp = val.linlin(0, 127, 0, -2.dbamp);
			~scLang.sendMsg(\looper, \s2Vol, amp);
		}, s2Vol);

		MIDIdef.cc(\s3LoopVol, { | val |
			var amp = val.linlin(0, 127, 0, -2.dbamp);
			~scLang.sendMsg(\looper, \s3Vol, amp);
		}, s3Vol);

		MIDIdef.cc(\masterLoopVol, { | val |
			var amp = val.linlin(0, 127, 0, -2.dbamp);
			~scLang.sendMsg(\looper, \masterVol, amp);
		}, masterVol);

		self;
	},

	killKnobs: { | self |
		MIDIdef(\s1LoopVol).free;
		MIDIdef(\s2LoopVol).free;
		MIDIdef(\s3LoopVol).free;
		MIDIdef(\masterLoopVol).free;
		self;
	},

	makeSliders: { | self |

		self;
	},

	killSliders: { | self |

		self;
	}

);
