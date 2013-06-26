/*
Thursday, December 13th 2012
transportOhm.scd
prm
*/

var val, bar, beat;
val = 77;
bar = 69;
beat = 70;

OSCdef(\connectionsTransportOhm, { | msg |
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

		~connectOhm[\makeTransport].stop;
		~ohm.turnRed(val).yield;
	}
});

