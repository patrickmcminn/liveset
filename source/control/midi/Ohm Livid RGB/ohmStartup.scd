/*
Friday, September 20th 2012
ohmStartup.scd
prm
runs Ohm Splashscreen
Loads control surface to its initial conditions
*/

r {
	~ohm.splash.postln;
	4.wait;
	~scLang.sendMsg(\page, \top);
}.play(AppClock);