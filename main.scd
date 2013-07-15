/*
Wednesday, October 10th
edited Monday, December 17th 2012
main.scd
prm
*/

(
r {
	"/source/Load system.scd".loadRelative;
	7.wait;
	"/source/Load control.scd".loadRelative;
}.play(AppClock);
);

s.meter;
Server.local.makeWindow;


