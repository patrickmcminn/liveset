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

	~restoreOhm[\connections].page.put(val, \lavender);
	~ohm.turnLavender(val).yield;

	~restoreOhm[\connections].page.put(val, \purple);
	~ohm.turnPurple(val).yield;

	~restoreOhm[\connections].page.put(val, \yellow);
	~ohm.turnYellow(val).yield;

	~restoreOhm[\connections].page.put(val, \pink);
	~ohm.turnPink(val).yield;

	~restoreOhm[\connections].page.put(val, \green);
	~ohm.turnGreen(val).yield;

	~restoreOhm[\connections].page.put(val, \blue);
	~ohm.turnBlue(val).yield;

	loop {
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};

};
