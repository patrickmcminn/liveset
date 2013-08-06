/*
Sunday, January 13th 2012
improvPage.scd
prm
*/

var backing, tpt;
backing = 0;
tpt = 7;

~page.interlude = ( );

~page.interlude.top = {
	~ohm.clearAll;
	~ohm.addEssential;

	// functions:

	~ohm.turnBlue(backing);
	MIDIdef(\interludeBacking, {
		~interlude.backing.spawn;
		~scLang.sendMsg(\interludeControl, \backingTop, ~interlude.backing.state);
	}, backing);

	~ohm.turnWhite(tpt);
	MIDIdef(\interludeTpt, {
		~interlude.tpt.spawn;
		~scLang.sendMsg(\interludeControl, \tptTop, ~interlude.tpt.state);
	}, tpt);

	~restoreOhm[\improv].keysValuesDo({ | name, state |  ~scLang.sendMsg(\restoreOhm, name, state); });
	~restoreOhm.improv.keysValuesDo({ | name, state | ~scLang.sendMsg(\restoreOhmImprov, name, state); });

	~restoreOhm[\improv].page.do({ | color, note |
		case
		{ color == \off } { ~ohm.turnOff(note); }
		{ color == \blue } { ~ohm.turnBlue(note); }
		{ color == \red } { ~ohm.turnRed(note); }
		{ color == \purple } { ~ohm.turnPurple(note); }
		{ color == \green } { ~ohm.turnGreen(note); }
		{ color == \yellow } { ~ohm.turnYellow(note); }
		{ color == \cyan } { ~ohm.turnCyan(note); }
		{ color == \white } { ~ohm.turnWhite(note); }
	});

};
