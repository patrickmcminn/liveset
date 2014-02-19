/*
Friday, September 20th 2012
ohmStartup.scd
prm
runs Ohm Splashscreen
Loads control surface to its initial conditions
*/

r {
  ~ohm2 = OhmRGB.new;
	~ohm.splash.postln;
	4.wait;
	~scLang.sendMsg(\page, \top);

  ~ohm2.makePage('nilPage');
  ~ohm2.makePage('improv');
  ~ohm2.makePage('grainCloud');
  ~ohm2.makePage('delayNetwork');
}.play(AppClock);