/*
Sunday, June 30th 2013
lightPage.scd
prm
*/

~page.light = ( );

~page.light.top = {
	~ohm.clearAll;
	~ohm.addEssential;

	// page defs go here

	~restoreOhm.light.keysValuesDo({ | name, state |  ~scLang.sendMsg(\restoreOhmLight, name, state); });

	~restoreOhm.light.page.do({ | color, note |
		case
		{ color == \off } { ~ohm.turnOff(note); }
		{ color == \lavender } { ~ohm.turnLavender(note); }
		{ color == \blue } { ~ohm.turnBlue(note); }
		{ color == \pink } { ~ohm.turnPink(note) ; }
		{ color == \red } { ~ohm.turnRed(note); }
		{ color == \purple } { ~ohm.turnPurple(note); }
		{ color == \green } { ~ohm.turnGreen(note); }
		{ color == \yellow } { ~ohm.turnYellow(note); }
	});