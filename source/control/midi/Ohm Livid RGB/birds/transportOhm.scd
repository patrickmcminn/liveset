/*
Thursday, November 8th 2012
transport.scd
prm
*/

~birds[\transport] = TempoClock;
~birds[\transport].tempo = 60/60;

~birds[\seeTransport] = Routine({
	loop{
		~birds[\transport].schedAbs(~birds[\transport].nextTimeOnGrid, {
			[~birds[\transport].bar, (~birds[\transport].beatInBar + 1)].postln;});
		~birds[\transport].schedAbs(~birds[\transport].nextBar, {
			~ohm.blink(69, \green, 0.5)});
		~birds[\transport].schedAbs(~birds[\transport].nextTimeOnGrid, {
			~ohm.blink(70, \blue, 0.5)});
		1.wait;
	};
});

~birdsMake[\seeTransport] = Routine({ | val |
	loop {
		~birds[\seeTransport].play(~birds[\transport]);
		["transport  visualized"].postln;
		~ohm.turnLavender(val).yield;

		~birds[\seeTransport].stop;
		~birds[\seeTransport].reset;
		~ohm.turnRed(val).yield;
	}
});
		