/*
Tuesday, September 3rd 2013
clusterOhm.scd
prm
*/

{
	s.sync;

	"/cluster/clusterOhm.scd".loadRelative;

	s.sync;

	~restoreOhm.grace.cluster = ( );
	~restoreOhm.grace.cluster.page = Array.fill(81, nil);
	~graceOhm.poppy.makeOSC;

}.fork;