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
	MIDIdef(\theBoyBranch, { }, 1);

	// Where the Birds Must be Drunk to be Amidst the Unknown Spray and Skies
	~ohm.turnPurple(2);
	MIDIdef(\birdsBranch, {  }, 2);

	// Free Play:
	~ohm.turnPink(3);
	MIDIdef(\freeBranch, { }, 3);
};
