/*
Monday, July 15th 2013
poppyOhm.scd
prm
*/

{
	s.sync;

	"/poppy/poppyOhm.scd".loadRelative;

	s.sync;

	~restoreOhm.grace.poppy = ( );
	~restoreOhm.grace.poppy.page = Array.fill(81, nil);
	~graceOhm.poppy.makeOSC;

}.fork;