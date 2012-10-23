/*
Wednesday, October 10th
somewhere between New Orleans, LA and Houston, TX
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

