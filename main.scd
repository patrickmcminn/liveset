/*
Wednesday, October 10th
main.scd
prm
*/

(
r {
	"/source/Load system.scd".loadRelative;
	5.wait;
	"/source/Load control.scd".loadRelative;
}.play(AppClock);
);

s.meter;
