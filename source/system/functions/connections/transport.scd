/*
Monday, October 29th 2012
edited 12/13/2012
- reflects change in control surface structure
between Boise, ID and Salt Lake City, UT
transport.scd
prm
*/

~connections[\transport] = TempoClock.new;
~connections[\transport].tempo = 75/60;

~connections[\seeTransport] = Routine({
	loop{
		~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid, {
			[~connections[\transport].bar, (~connections[\transport].beatInBar + 1)].postln;});
		1.wait;
	};
});


~connectMake[\seeTransport] = Routine({ | val |
	loop{
		~connections[\seeTransport].reset;
		~connections[\seeTransport].play(~connections[\transport]);
		~scLang.sendMsg(\control, \connectionsTransport);
		["transport visualized"].postln.yield;

		~connections[\seeTransport].stop;
		~scLang.sendMsg(\control, \connectionsTransport);
		["transport off"].postln.yield;
	}
});

/*
~seeTransport =
	~connections[\transport].schedAbs(~connections[\transport].nextBar, {
	[~connections[\transport].bar, (~connections[\transport].beatInBar + 1)].postln; 1;});


~cool = Routine({
	loop{
		~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid, {
			[~connections[\transport].bar, (~connections[\transport].beatInBar + 1)].postln;});
		1.wait;
	}
});
~cool.play(~connections[\transport])
~cool.stop
~cool.reset
~seeMe = Routine({
	loop{
		~connections[\transport].schedAbs(~connections[\transport].nextBar, {
			~ohm.blink(69, \green, 0.5)});
		~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid, {
			~ohm.blink(70, \blue, 0.5)});
		1.wait;
	};
});

~seeMe.play(~connections[\transport])
*/

