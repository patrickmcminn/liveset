/*
Sunday, June 20th 2013
multiFreezePage.scd
prm
*/


~page.light.multiFreeze = {
	~ohm.clearAll;
	~ohm.addEssential;

	// functions go here
	~scLang.sendMsg(\lightControl, \multiFreezeInterface);
	~scLang.sendMsg(\lightControl, \multiFreezeControls);
	~scLang.sendMsg(\lightControl, \multiFreezeOutput);
	~lightOhm.multiFreeze.presets.init;

	~restoreOhm.light.multiFreeze.keysValuesDo({ | name, state |  ~scLang.sendMsg(\restoreOhmMultiFreeze, name, state); });

	{
		~restoreOhm.light.multiFreeze.page.do({ | color, note |
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
	}.defer(0.05);

};