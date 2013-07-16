/*
Monday, July 15th 2013
poppyOhm.scd
prm
*/

{
	s.sync;

	"/poppy/hugeOhm.scd".loadRelative;

	s.sync;

	~restoreOhm.improv.huge = ( );
	~restoreOhm.improv.huge.page = Array.fill(81, nil);
	~improvOhm.huge.makeOSC;

}.fork;