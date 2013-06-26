/*
Saturday, June 15th 2013
Basement of the Pink Palace,
Baltimore, MD
changer.scd
prm
*/

var changer = 72;

OSCdef(\changerOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \changer } { ~structureOhm.changer.value }
}, \control, ~scLang);

OSCdef(\changerOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	case
	{ id == \changer } { ~structureOhmMidi.changer.value; }
}, \restoreOhm, ~scLang);

~structureOhm.changer = r {

	~scLang.sendMsg(\control, \looper);
	~restoreOhm.structure.page.put(changer, \blue);
	~ohm.turnBlue(changer).yield;


	loop {
		~scLang.sendMsg(\control, \looper);
		~scLang.sendMsg(\control, \looperCtrl);
		~restoreOhm.structure.page.put(changer, \pink);
		~ohm.turnPink(changer).yield;

		~scLang.sendMsg(\control, \looperCtrl);
		~scLang.sendMsg(\control, \loopFree);
		~restoreOhm.structure.page.put(changer, \red);
		~ohm.turnRed(changer).yield;

		~scLang.sendMsg(\control, \loopFree);
		~scLang.sendMsg(\control, \looper);
		~restoreOhm.structure.page.put(changer, \blue);
		~ohm.turnBlue(changer).yield;

/*		~scLang.sendMsg(\control, \momentary);
		~restoreOhm.structure.page.put(changer, \green);
		~ohm.turnGreen(changer).yield;

		~scLang.sendMsg(\control, \toggle);
		~restoreOhm.structure.page.put(changer, \purple);
		~ohm.turnPurple(changer).yield;*/
	}
};

~structureOhmMidi.changer = (
	init: { | self |
		MIDIdef.noteOn(\changer, { ~scLang.sendMsg(\control, \changer); }, changer);
		self;
	},

	kill: { | self |
		MIDIdef(\changer).free;
	},
);
		