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

	//soundcheck:
	~ohm.turnLavender(56);
	MIDIdef.noteOn(\soundcheck, { | vel, note | ~mixer[\soundcheckMake].value(note); }, 56);
};
