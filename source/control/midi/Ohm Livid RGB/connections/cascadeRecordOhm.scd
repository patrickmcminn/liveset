/*
Tuesday, December 12th 2012
cascadeRecordOhm.scd
prm
*/

var val = 11;

OSCdef(\cascadeRecordOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \cascadeRecord } { ~connectOhm[\cascadeRecord].value; }
}, \control, ~scLang);

~connectOhm[\cascadeRecord] = r {
	loop {
		~ohm.turnLavender(val).yield;

		~ohm.turnPurple(val).yield;

		~ohm.turnYellow(val).yield;
	};
};