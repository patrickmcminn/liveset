/*
Wednesday, December 12th 2012
loadImprovOhm.scd
prm
*/


{
	s.sync;
	~interludeOhm = ( );
	~restoreOhm.interlude = ( );
	~restoreOhm.interlude.page = Array.fill(81, nil);

	s.sync;
	"/improv/interludePage.scd".loadRelative;

}.fork;



