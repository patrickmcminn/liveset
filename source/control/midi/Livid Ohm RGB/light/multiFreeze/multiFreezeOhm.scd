/*
Sunday, June 30th 2013
multiFreezeOhm.scd
prm
*/

var main, page;
main = 1;
page = 9;

~lightOhm.multiFreeze = (

	state: 0,

	spawn: { | self |
		if( self.state == 0, { self.init }, { self.kill });
		self;
	},

	init: { | self |
		self.state = 1;
		self.makeButtons;
		self.makeTopControl;
		self;
	},

	kill: { | self |
		self.state = 0;
		self.killButtons;
		self.killTopControl;
		self;
	},

	makeOSC: { | self |

		OSCdef(\lightMultiFreezeOhm, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);
			case
			{ id == \multiFreeze } { self.spawn; }
			{ id == \multiFreezePage } { ~page.light.multiFreeze.value; }
			{ id == \multiFreezeControls } { ~lightOhm.multiFreeze.controls.init; }
			{ id == \multiFreezeinterface } { ~lightOhm.multiFreeze.interface.init; }
			{ id == \multiFreezeOutput } { ~lightOhm.multiFreeze.outputSet.init; }
			{ id == \multiFreezeChangeOutput } { ~lightOhm.multiFreeze.outputSet.changeOutput(val); }

		}, \lightControl, ~scLang);

		OSCdef(\lightMultiFreezeRestore, { | msg |
			var id, val;
			id = msg.at(1);
			val = msg.at(2);

		},\restoreOhmLight, ~scLang);

		self;
	},

	killOSC: { | self |
		OSCdef(\lightMultiFreezeOhm).free;
		OSCdef(\lightMultiFreezeRestorE).free;
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
		~ohm.turnBlue(main);
		~restoreOhm.light.page.put(main, \blue);
		self;
	},

	killMainButtons: { | self |
		~ohm.turnRed(main);
		~restoreOhm.light.page.put(main, \red);
		self;
	},

	makePageButton: { | self |
		MIDIdef.noteOn(\lightMultiFreezePage, { ~scLang.sendMsg(\lightControl, \multiFreezePage); }, page);
		~ohm.turnPurple(page);
		~restoreOhm.light.page.put(page, \purple);
		self;
	},

	killPageButton: { | self |
		MIDIdef(\lightMultiFreezePage).free;
		~ohm.turnOff(page);
		~restoreOhm.light.page.put(page, \off);
		self;
	},

	makeTopControl: { | self |

		self;
	},

	killTopControl: { | self |

		self;
	},
)