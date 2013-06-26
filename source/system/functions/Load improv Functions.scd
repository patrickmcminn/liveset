/*
Saturday, January 12th 2013
Load improv Functions.scd
prm
*/

"improv/init.scd".loadRelative;
"improv/gendy.scd".loadRelative;
"improv/granulator.scd".loadRelative;
"improv/pings.scd".loadRelative;
"improv/noiseSynth.scd".loadRelative;

~improv.noiseSynth.makeOSC;