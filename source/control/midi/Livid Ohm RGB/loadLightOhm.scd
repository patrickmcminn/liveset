/*
Sunday, June 30th 2013
loadLightOhm.scd
prm
*/


{
	s.sync;
	~lightOhm = ( );
	~restoreOhm.light = ( );
	~restoreOhm.light.page = Array.fill(81, nil);

	s.sync;
	"/light/LightPage.scd".loadRelative;
	"/light/Load multiFreeze.scd".loadRelative;
	"/light/Load chordHarm.scd".loadRelative;

}.fork;




