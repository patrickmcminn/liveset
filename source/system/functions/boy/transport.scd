/*
Tuesday, November 27th 2012
transport.scd
prm
*/


~boy[\seeTransport] = Routine({
	loop{
		~boy[\transport].schedAbs(~boy[\transport].nextTimeOnGrid, {
			[~boy[\transport].bar, (~boy[\transport].beatInBar + 1)].postln;});
		1.wait;
	};
});


~boyMake[\seeTransport] = Routine({ | val |
	loop{
		~boy[\seeTransport].reset;
		~boy[\seeTransport].play(~boy[\transport]);
		~scLang.sendMsg(\control, \boyTransport);
		["transport visualized"].postln.yield;

		~boy[\seeTransport].stop;
		~scLang.sendMsg(\control, \boyTransport);
		["transport off"].postln.yield;
	}
});