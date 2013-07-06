/*
Sunday, June 30th 2013
Load multiFreeze.scd
prm
*/

{
	s.sync;
	~restoreOhm.light.multiFreeze = ( );
	~restoreOhm.light.multiFreeze.page = Array.fill(81, nil);

	s.sync;
	"/multiFreeze/multiFreezeOhm.scd".loadRelative;
	"/multiFreeze/multiFreezePage.scd".loadRelative;
	"/multiFreeze/interface.scd".loadRelative;
	"/multiFreeze/controls.scd".loadRelative;
	"/multiFreeze/outputSet.scd".loadRelative;
	"/multiFreeze/presets.scd".loadRelative;

	s.sync;
	~lightOhm.multiFreeze.makeOSC;
}.fork;