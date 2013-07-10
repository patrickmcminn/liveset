/*
Wednesday, July 10th 2013
Load chordHarm.scd
prm
*/


{
	s.sync;
	~restoreOhm.light.chordHarmOhm = ( );
	~restoreOhm.light.chordHarmOhm.page = Array.fill(81, nil);

	s.sync;
	"/chordHarm/chordHarmOhm.scd".loadRelative;

	s.sync;
	~lightOhm.chordHarm.makeOSC;

}.fork;