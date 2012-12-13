/*
Thursday, December 13th 2012
transportOhm.scd
prm
*/

var val, bar, beat;
val = 77;
bar = 69;
beat = 70;

OSCdef(\connectionsTransport, { | msg |
	var id = msg.at(1);
	case
	{ id == \connectionsTransport } { ~connectOhm[\seeTransport].value; }
}, \control, ~scLang);


~connectOhm[\makeTransport] = Routine({
	loop{
		~connections[\transport].schedAbs(~connections[\transport].nextBar, {
			~ohm.blink(bar, \green, 0.5)});
		~connections[\transport].schedAbs(~connections[\transport].nextTimeOnGrid, {
			~ohm.blink(beat, \blue, 0.5)});
		1.wait;
	};
});


~connectOhm[\seeTransport] = Routine({
	loop{
		~connectOhm[\makeTransport].reset;
		~connectOhm[\makeTransport].play(~connections[\transport]);
		~ohm.turnLavender(val).yield;

		~connections[\seeTransport].stop;
		~ohm.turnRed(val).yield;
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

