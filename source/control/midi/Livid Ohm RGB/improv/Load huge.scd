/*
Monday, July 15th 2013
poppyOhm.scd
prm
*/

{
	s.sync;

	"/huge/hugeOhm.scd".loadRelative;
	"/huge/hugePage.scd".loadRelative;
	"/huge/outputSet.scd".loadRelative;
	"/huge/presets.scd".loadRelative;
	"/huge/controls.scd".loadRelative;

	s.sync;

	~restoreOhm.improv.huge = ( );
	~restoreOhm.improv.huge.page = Array.fill(81, nil);
	~improvOhm.huge.makeOSC;

}.fork;