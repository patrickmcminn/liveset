/*
Tuesday, July 16th 2013
hugePage.scd
prm
*/

~page.improv.huge = {
	~ohm.clearAll;
	~ohm.addEssential;

	~improvOhm.huge.controls.init;
	~improvOhm.huge.outputSet.init;
	~improvOhm.huge.presets.init;

	~restoreOhm.improv.huge.keysValuesDo({ | name, state |  ~scLang.sendMsg(\restoreOhmHuge, name, state); });

	~restoreOhm.improv.huge.page.do({ | color, note |
		case
		{ color == \off } { ~ohm.turnOff(note); }
		{ color == \blue } { ~ohm.turnBlue(note); }
		{ color == \red } { ~ohm.turnRed(note); }
		{ color == \purple } { ~ohm.turnPurple(note); }
		{ color == \green } { ~ohm.turnGreen(note); }
		{ color == \yellow } { ~ohm.turnYellow(note); }
		{ color == \cyan } { ~ohm.turnCyan(note); }
		{ color == \white } { ~ohm.turnWhite(note); }

		//legacy colors:
		{ color == \pink } { ~ohm.turnPink(note) ; }
		{ color == \lavender } { ~ohm.turnLavender(note); }
	});

};