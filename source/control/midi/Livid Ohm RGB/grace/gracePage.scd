/*
Monday, September 2nd 2013
gracePage.scd
prm
*/

var poppy, cluster, bassline;
poppy = 0;
cluster = 2;
bassline = 3;

~page.grace = ( );

~page.grace.top = {
	~ohm.clearAll;
	~ohm.addEssential;

	// functions:

	~ohm.turnBlue(poppy);
	MIDIdef.noteOn(\gracePoppy, {
		~grace.poppy.spawn;
		~scLang.sendMsg(\graceControl, \poppyTop, ~grace.poppy.state);
	}, poppy);

	~ohm.turnWhite(cluster);
	MIDIdef.noteOn(\graceCluster, {
		~grace.cluster.spawn;
		~scLang.sendMsg(\graceControl, \clusterTop, ~grace.cluster.state);
	}, cluster);

	~ohm.turnYellow(bassline);
	MIDIdef.noteOn(\graceBassline, {
		~grace.bassline.spawn;
		~scLang.sendMsg(\graceControl, \basslineTop, ~grace.bassline.state);
	}, bassline);

	~restoreOhm.grace.keysValuesDo({ | name, state | ~scLang.sendMsg(\restoreOhmGrace, name, state); });

	~restoreOhm.grace.page.do({ | color, note |
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
