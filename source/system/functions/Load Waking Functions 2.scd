/*
Wednesday, March 13th 2013
Load Waking Functions.scd
prm
*/

// create function dictionary for waking functions
~waking = ( );

"/waking/chordOne.scd".loadRelative;
"/waking/chordOneLow.scd".loadRelative;
"/waking/chordOneHigh.scd".loadRelative;

"/waking/chordTwo.scd".loadRelative;
"/waking/chordTwoLow.scd".loadRelative;
"/waking/chordTwoHigh.scd".loadRelative;

"/waking/filterA.scd".loadRelative;
"/waking/filterB.scd".loadRelative;
"/waking/filterC.scd".loadRelative;

"/waking/init.scd".loadRelative;