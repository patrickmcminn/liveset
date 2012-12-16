/*
Sunday, December 16th 2012
transportOhm.scd
prm
*/


var val, bar, beat;
val = 77;
bar = 69;
beat = 70;

OSCdef(\boyTransport, { | msg |
	var id = msg.at(1);
	case
	{ id == \boyTransport } { ~boyOhm[\seeTransport].value; }
}, \control, ~scLang);


~boyOhm[\makeTransport] = Routine({
	loop{
		~boy[\transport].schedAbs(~boy[\transport].nextBar, {
			~ohm.blink(bar, \green, (~boy[\transport].tempo/2))});
		~boy[\transport].schedAbs(~boy[\transport].nextTimeOnGrid, {
			~ohm.blink(beat, \blue, (~boy[\transport].tempo/2))});
		1.wait;
	};
});


~boyOhm[\seeTransport] = Routine({
	loop{
		~boyOhm[\makeTransport].reset;
		~boyOhm[\makeTransport].play(~connections[\transport]);
		~ohm.turnLavender(val).yield;

		~boy[\seeTransport].stop;
		~ohm.turnRed(val).yield;
	}
});
