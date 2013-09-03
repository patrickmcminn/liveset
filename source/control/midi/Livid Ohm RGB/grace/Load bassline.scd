/*
Monday, July 15th 2013
poppyOhm.scd
prm
*/

{
	s.sync;

	"/bassline/basslineOhm.scd".loadRelative;

	s.sync;

	~restoreOhm.grace.bassline = ( );
	~restoreOhm.grace.bassline.page = Array.fill(81, nil);
	~graceOhm.bassline.makeOSC;

}.fork;