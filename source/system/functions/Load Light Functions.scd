/*
Friday, June 28th 2013
Load Light Functions.scd
prm
*/
{
	s.sync;
	// create function dictionary for Light Functions
	~light = ( );

	s.sync;
	// load functions:
	"/light/multiFreeze.scd".loadRelative;

	s.sync;
	~light.multiFreeze.makeOSC;
}.fork;



