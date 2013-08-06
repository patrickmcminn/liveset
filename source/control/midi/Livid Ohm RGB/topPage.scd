/*
Thursday, September 20th
topBranch.scd
prm
defines function for making the top layer of the tree
*/

~page[\top] = {
	~ohm.clearAll;
	~ohm.addEssential;

	// Connections
	~ohm.turnBlue(0);
	MIDIdef.noteOn(\connectionsBranch, { ~scLang.sendMsg(\page, \connections) }, 0 );

	// The Boy who Tired of Sitting Still:
	~ohm.turnLavender(1);
	MIDIdef.noteOn(\theBoyBranch, { ~scLang.sendMsg(\page,  \boy)}, 1);

	// Where the Birds Must be Drunk to be Amidst the Unknown Spray and Skies
	~ohm.turnPurple(2);
	MIDIdef.noteOn(\birdsBranch, { ~scLang.sendMsg(\page, \birds) }, 2);

	// various other functions
	~ohm.turnCyan(3);
	MIDIdef.noteOn(\improvBranch, { ~scLang.sendMsg(\page, \improv) }, 3);

	// Light
	~ohm.turnYellow(4);
	MIDIdef.noteOn(\lightBranch, { ~scLang.sendMsg(\page, \light) }, 4);

	//Interlude
	~ohm.turnGreen(5);
	MIDIdef.noteOn(\interludeBranch, { ~page.interlude.top; }, 5);

	// input volume:
	MIDIdef.cc(\inputVol, { | val |
		var amp = val.linlin(0, 127, 0, 1);
		~scLang.sendMsg(\mixer, \input, amp);
	}, 14);
};
