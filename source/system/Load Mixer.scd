/*
Tuesday, October 9th 2012
Load Mixer.scd
prm
*/

r{
	"/mixer/groups.scd".loadRelative;
	"/mixer/mixer.scd".loadRelative;
	"/mixer/instruments.scd".loadRelative;
	"/mixer/guitar.scd".loadRelative;
	//"/mixer/soundcheck.scd".loadRelative;
	"/mixer/loopers.scd".loadRelative;

	s.sync;

	~looper.init;
}.play;