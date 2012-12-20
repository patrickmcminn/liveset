/*
Wednesday, December 12th 2012
noteRecordOhm.scd
prm
*/

var val = 3;

OSCdef(\noteRecordOhm, { | msg |
	var id = msg.at(1);
	case
	{ \id == \noteRecord } { ~connectOhm[\noteRecord].value; }
}, \control, ~scLang);


~connectOhm[\noteRecord] = Routine({

	~ohm.turnLavender(val).yield;

	~ohm.turnPurple(val).yield;

	~ohm.turnYellow(val).yield;

	~ohm.turnPink(val).yield;

	~ohm.turnBlue(val).yield;
	loop {
		~ohm.turnRed(val).yield;
	};

});