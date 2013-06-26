/*
Monday, December 17th 2012
transportOhm.scd
prm
*/

var val, bar, beat;
val = 77;
bar = 69;
beat = 70;

OSCdef(\birdsTransportOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \birdsTransport } { ~birdsOhm[\seeTransport].value; }
}, \control, ~scLang);


~birdsOhm[\makeTransport] = Routine({
	loop{
		~birds[\transport].schedAbs(~birds[\transport].nextBar, {
			~ohm.blink(bar, \green, (~birds[\transport].tempo/2))});
		~birds[\transport].schedAbs(~birds[\transport].nextTimeOnGrid, {
			~ohm.blink(beat, \blue, (~birds[\transport].tempo/2))});
		1.wait;
	};
});


~birdsOhm[\seeTransport] = Routine({
	loop{
		~birdsOhm[\makeTransport].reset;
		~birdsOhm[\makeTransport].play(~birds[\transport]);
		~ohm.turnLavender(val).yield;

		~birds[\seeTransport].stop;
		~ohm.turnRed(val).yield;
	}
});
