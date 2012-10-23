/*
Wednesday, October 17th
grainBufs.scd
prm
*/

var grainEnvs;

grainEnvs = (
	gabor:	Env.sine(1, 1),
	gabWide:	Env([0, 1, 1, 0], [1, 1, 1]),
	perc:	Env.perc(0.01, 0.99),
	percRev:	Env.perc(0.99, 0.01),
	expodec:	Env.perc(0.01, 0.99, 1, 4),
	rexpodec:	Env.perc(0.99, 0.01, 1, 4)
	);

~grainBufs = (
	gabor:	Buffer.sendCollection(s, grainEnvs.at(\gabor).discretize, 1),
	gabWide:	Buffer.sendCollection(s, grainEnvs.at(\gabWide).discretize, 1),
	perc:	Buffer.sendCollection(s, grainEnvs.at(\perc).discretize, 1),
	percRev:	Buffer.sendCollection(s, grainEnvs.at(\percRev).discretize, 1),
	expodec:	Buffer.sendCollection(s, grainEnvs.at(\expodec).discretize, 1),
	rexpodec:	Buffer.sendCollection(s, grainEnvs.at(\rexpodec).discretize, 1)
	);