/*
Tuesday, August 6th 2013
loadInterludeOhm.scd
prm
*/


{
	s.sync;
	~interludeOhm = ( );
	~restoreOhm.interlude = ( );
	~restoreOhm.interlude.page = Array.fill(81, nil);

	s.sync;
	"/interlude/interludePage.scd".loadRelative;
	"/interlude/Load backing.scd".loadRelative;
	"interlude/Load tpt.scd".loadRelative;

}.fork;



