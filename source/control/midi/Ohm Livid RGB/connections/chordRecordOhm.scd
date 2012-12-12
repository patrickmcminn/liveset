/*
Tuesday, Decembet 12th 2012
chordRecordOhm.scd
prm
*/

var val = 19;

OSCdef(\chordRecordOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \chordRecord } { ~connectOhm[\chordRecord].value; }
}, \control, ~scLang);

~connectOhm[\chordRecord] = r {
	loop {

		~ohm.turnLavender(val).yield;

		~ohm.turnPurple(val).yield;

		~ohm.turnYellow(val).yield;

		~ohm.turnPink(val).yield;

		~ohm.turnGreen(val).yield;

		~ohm.turnBlue(val).yield;

	};
};
