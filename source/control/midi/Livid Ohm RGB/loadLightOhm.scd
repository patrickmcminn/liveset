/*
Sunday, June 30th 2013
loadLightOhm.scd
prm
*/


{
	s.sync;
	"/light/Load multiFreeze.scd".loadRelative;


	s.sync;
	~restoreOhm.light = ( );
	~restoreOhm.light.page = Array.fill(81, nil);

}.fork;




