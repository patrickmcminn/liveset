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
  5.wait;
  "/source/control/midi/Livid Ohm RGB/improv/improvPage ohm2.scd".loadRelative;
  "source/control/midi/Livid Ohm RGB/improv/GrainCloudOhm.scd".loadRelative;
  "source/control/midi/Livid Ohm RGB/improv/delayNetworkOhm.scd".loadRelative;
  "source/control/midi/Livid Ohm RGB/improv/FakeGuitarOhm.scd".loadRelative;
  "source/control/midi/Livid Ohm RGB/improv/TrumpetNebulaOhm.scd".loadRelative;
  "source/control/midi/Livid Ohm RGB/improv/FreezeDroneOhm.scd".loadRelative;
  "source/control/midi/Livid Ohm RGB/LuckyOhm.scd".loadRelative;
  "source/control/midi/Livid Ohm RGB/LuckyIntroOhm.scd".loadRelative;
}.play(AppClock);
);

s.meter;
Server.local.makeWindow;