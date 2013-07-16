/*
Monday, July 15th 2013
poppyOhm.scd
prm
*/

{
	s.sync;

	"/poppy/poppyOhm.scd".loadRelative;

	s.sync;

	~restoreOhm.improv.poppy = ( );
	~restoreOhm.improv.poppy.page = Array.fill(81, nil);
	~improvOhm.poppy.makeOSC;

}.fork;