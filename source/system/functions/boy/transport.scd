/*
Tuesday, November 27th 2012
transport.scd
prm
*/


~boy[\seeTransport] = Routine({
	loop{
		~boy[\transport].schedAbs(~boy[\transport].nextTimeOnGrid, {
			[~boy[\transport].bar, (~boy[\transport].beatInBar + 1)].postln;});
		~boy[\transport].schedAbs(~boy[\transport].nextBar, {
			~ohm.blink(69, \green, 0.4)});
		~boy[\transport].schedAbs(~boy[\transport].nextTimeOnGrid, {
			~ohm.blink(70, \blue, 0.4)});
		1.wait;
	};
});


~boyMake[\seeTransport] = Routine({ | val |
	loop{
		~boy[\seeTransport].reset;
		~boy[\seeTransport].play(~boy[\transport]);
		["transport visualized"].postln;
		~ohm.turnLavender(val).yield;

		~boy[\seeTransport].stop;
		["transport off"].postln;
		~ohm.turnRed(val).yield;
	}
});