/*
Sunday, January 13th 2012
improvPage.scd
prm
*/

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

	~restoreOhm[\improv].keysValuesDo({ | name, state |  ~scLang.sendMsg(\restoreOhm, name, state); });

	~restoreOhm[\improv].page.do({ | color, note |
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

};
