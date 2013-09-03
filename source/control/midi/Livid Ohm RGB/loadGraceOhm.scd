/*
Tuesday, August 6th 2013
loadInterludeOhm.scd
prm
*/


{
	s.sync;
	~graceOhm = ( );
	~restoreOhm.grace = ( );
	~restoreOhm.grace.page = Array.fill(81, nil);

	s.sync;
	"/grace/gracePage.scd".loadRelative;
	"/grace/Load poppy.scd".loadRelative;
	"/grace/Load cluster.scd".loadRelative;
	"/grace/Load bassline.scd".loadRelative;

}.fork;



