/*
Monday, July 15th 2013
prm
*/

{
	s.sync;

  ~page.improv = ( );
  ~improvOhm.huge = ( );

	//"/huge/hugeOhm.scd".loadRelative;
	"/huge/hugePage.scd".loadRelative;
	"/huge/outputSet.scd".loadRelative;
	"/huge/presets.scd".loadRelative;
	"/huge/controls.scd".loadRelative;

	s.sync;

  ~restoreOhm.improv = ( );
	~restoreOhm.improv.huge = ( );
	~restoreOhm.improv.huge.page = Array.fill(81, nil);
	//~improvOhm.huge.makeOSC;

}.fork;