/*
noiseSynthOhm.scd
Sunday, June 23rd 2013
prm
*/

var val, page;
val = 2;
page = 10;

~improvOhm.noiseSynth = (

	state: 0,

	spawn: { | self |
		if( self.state == 0, { self.init }, { self.kill });
		self;
	},

	init: { | self |
		self.state = 1;
		self.makeButtons;
		self;
	},

	kill: { | self |
		self.state = 0;
		self.killButtons;
		self;
	},

	makeOSC: { | self |
		OSCdef(\improvNoiseSynthOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \improvNoiseSynth } { self.spawn; }
			{ id == \improvNoiseSynthPage } { ~page.improv.noiseSynth.value; }
			{ id == \noiseSynthKeyboard } { ~improvOhm.noiseSynth.keyboard.init; }
			{ id == \improvNoiseSynthControls } { ~improvOhm.noiseSynth.controls.init; }
			{ id == \improvNoiseSynthOutput } { ~improvOhm.noiseSynth.outputSet.init; }
			{ id == \improvNoiseSynthChangeOutput } { ~improvOhm.noiseSynth.outputSet.changeOutput(val); }

		}, \control, ~scLang);

		OSCdef(\improvNoiseSynthRestore, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \noiseSynthPage } {
				if ( val == 1, { self.makePageButton; });}
		}, \restoreOhm );
		self;
	},

	killOSC: { | self |
		OSCdef(\improvNoiseSynthOhm).free;
		OSCdef(\improvNoiseSynthRestore).free;
		self;
	},

	makeButtons: { | self |
		self.makeMainButton;
		self.makePageButton;
		self;
	},

	killButtons: { | self |
		self.killMainButton;
		self.killPageButton;
		self;
	},

	makeMainButton: { | self |
		~ohm.turnBlue(val);
		~restoreOhm.improv.page.put(val, \blue);
		self;
	},

	killMainButton: { | self |
		~ohm.turnRed(val);
		~restoreOhm.improv.page.put(val, \red);
		self;
	},

	makePageButton: { | self |
		~restoreOhm.improv.noiseSynthPage = 1;
		~ohm.turnPurple(page);
		~restoreOhm.improv.page.put(page, \purple);
		MIDIdef.noteOn(\improvNoiseSynthPage, { ~scLang.sendMsg(\control, \improvNoiseSynthPage); }, page);
		self;
	},

	killPageButton: { | self |
		~restoreOhm.improv.noiseSynthPage = 0;
		~ohm.turnOff(page);
		~restoreOhm.improv.page.put(page, \off);
		MIDIdef(\improvNoiseSynthPage).free;
		self;
	},

)