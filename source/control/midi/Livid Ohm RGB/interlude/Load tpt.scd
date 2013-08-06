/*
Monday, July 15th 2013
Load interludeTpt.scd
prm
*/

{
	s.sync;

	"/tpt/tptOhm.scd".loadRelative;

	s.sync;

	~restoreOhm.interlude.tpt = ( );
	~restoreOhm.interlude.tpt.page = Array.fill(81, nil);
	~interludeOhm.tpt.makeOSC;

}.fork;