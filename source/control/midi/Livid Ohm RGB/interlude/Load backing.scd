/*
Monday, July 15th 2013
Load backing.scd
prm
*/

{
	s.sync;

	"/backing/backingOhm.scd".loadRelative;

	s.sync;

	~restoreOhm.interlude.backing = ( );
	~restoreOhm.interlude.backing.page = Array.fill(81, nil);
	~interludeOhm.backing.makeOSC;

}.fork;