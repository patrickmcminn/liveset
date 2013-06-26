/*
Wednesday, March 27th 2013
init.scd
prm
*/

~waking.init = {
	~waking.chordOne.makeOSC;
	~waking.chordOneHigh.makeOSC;
	~waking.chordOneLow.makeOSC;
	~waking.chordTwo.makeOSC;
	~waking.chordTwoHigh.makeOSC;
	~waking.chordTwoLow.makeOSC;

	~waking.chordOne.spawn;
	~waking.chordOneHigh.spawn;
	~waking.chordOneLow.spawn;
	~waking.chordTwo.spawn;
	~waking.chordTwoHigh.spawn;
	~waking.chordTwoLow.spawn;
};

