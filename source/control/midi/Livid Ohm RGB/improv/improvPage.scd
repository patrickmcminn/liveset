/*
Sunday, January 13th 2012
improvPage.scd
prm
*/

var poppy, huge;
poppy = 3;
huge = 5;

~restoreOhm[\improv] = ( );
~restoreOhm[\improv].page = Array.fill(81, nil);
~page.improv = ( );

~page.improv.top = {
	~ohm.clearAll;
	~ohm.addEssential;

	~ohm.turnGreen(0);
	MIDIdef.noteOn(\gendy, { ~scLang.sendMsg(\gendy, \main) }, 0);

	~ohm.turnGreen(1);
	MIDIdef.noteOn(\pings, { ~scLang.sendMsg(\pings, \main) }, 1);

	~ohm.turnYellow(2);
	MIDIdef.noteOn(\improvNoiseSynth, { ~scLang.sendMsg(\improvNoiseSynth, \main) }, 2);

	~ohm.turnWhite(poppy);
	MIDIdef.noteOn(\improvPoppy, { ~improv.poppy.spawn; }, poppy);

	~ohm.turnCyan(huge);
	MIDIdef.noteOn(\improvHuge, { ~improv.huge.spawn; }, huge);

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

		//legacy colors:
		{ color == \pink } { ~ohm.turnPink(note) ; }
		{ color == \lavender } { ~ohm.turnLavender(note); }
	});

};
