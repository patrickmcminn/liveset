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
		1.wait;
	};
});

~birdsMake[\seeTransport] = Routine({ | val |
	loop {
		~birds[\seeTransport].play(~birds[\transport]);
		~scLang.sendMsg(\control, \birdsTransport);
		["transport  visualized"].postln.yield;

		~birds[\seeTransport].stop;
		~birds[\seeTransport].reset;
		~scLang.sendMsg(\control, \birdsTransport);
		["transport not visualized"].postln.yield;
	}
});
		