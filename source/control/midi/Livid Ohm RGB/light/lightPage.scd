/*
Sunday, June 30th 2013
lightPage.scd
prm
*/

var multiFreeze;
multiFreeze = 1;

~page.light = ( );

~page.light.top = {
	~ohm.clearAll;
	~ohm.addEssential;

	// page defs go here
	~ohm.turnYellow(multiFreeze);
	MIDIdef.noteOn(\lightMultiFreeze, { ~scLang.sendMsg(\lightMultiFreeze, \main); }, multiFreeze);

	~restoreOhm.light.keysValuesDo({ | name, state |  ~scLang.sendMsg(\restoreOhmLight, name, state); });

	~restoreOhm.light.page.do({ | color, note |
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