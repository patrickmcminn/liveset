/*
Monday, July 15th 2013
Load interludeTpt.scd
prm
*/

{
	s.sync;

	"/interludeTpt/interludeTptOhm.scd".loadRelative;

	s.sync;

	~restoreOhm.improv.interludeTpt = ( );
	~restoreOhm.improv.interludeTpt.page = Array.fill(81, nil);
	~improvOhm.interludeTpt.makeOSC;

}.fork;