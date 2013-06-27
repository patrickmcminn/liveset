/*
Sunday, June 23rd 2013
Noise Synth Page.scd
prm
*/

~page.improv.noiseSynth = {
	~ohm.clearAll;
	~ohm.addEssential;

	~scLang.sendMsg(\control, \noiseSynthKeyboard);
	~scLang.sendMsg(\control, \improvNoiseSynthControls);
	~scLang.sendMsg(\control, \improvNoiseSynthOutput);

	~restoreOhm.improv.noiseSynth.keysValuesDo({ | name, state |  ~scLang.sendMsg(\restoreOhm, name, state); });

	~restoreOhm.improv.noiseSynth.page.do({ | color, note |
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
