/*
Thursday, October 18th 2012
edited 12/10/2012
reflects new control surface function handling
Load Ohm.scd
prm
*/


try
{
	"/Livid Ohm RGB/ohmInit.scd".loadRelative;
	"/Livid Ohm RGB/livesetOhm.scd".loadRelative;
	"/Livid Ohm RGB/topPage.scd".loadRelative;
	"/Livid Ohm RGB/loadStructural.scd".loadRelative;
	"/Livid Ohm RGB/connectionsPage.scd".loadRelative;
	"/Livid Ohm RGB/loadConnectionsOhm.scd".loadRelative;
	"/Livid Ohm RGB/boyPage.scd".loadRelative;
	"/Livid Ohm RGB/loadBoyOhm.scd".loadRelative;
	"/Livid Ohm RGB/birdsPage.scd".loadRelative;
	"/Livid Ohm RGB/loadBirdsOhm.scd".loadRelative;
	"/Livid Ohm RGB/improvPage.scd".loadRelative;
	"/Livid Ohm RGB/loadImprovOhm.scd".loadRelative;
	"/Livid Ohm RGB/loadLightOhm.scd".loadRelative;

	"/Livid Ohm RGB/ohmStartup.scd".loadRelative;
}

{ "Livid Ohm RGB not present!" }