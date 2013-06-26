/*
Wednesday, December 12th 2012
noteRecordOhm.scd
prm
*/

var val = 3;

OSCdef(\noteRecordOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \noteRecord } { ~connectOhm[\noteRecord].value; }
}, \control, ~scLang);


~connectOhm[\noteRecord] = Routine({
	~restoreOhm[\connections].page.put(val, \lavender);
	~ohm.turnLavender(val).yield;

	~restoreOhm[\connections].page.put(val, \purple);
	~ohm.turnPurple(val).yield;

	~restoreOhm[\connections].page.put(val, \yellow);
	~ohm.turnYellow(val).yield;

	~restoreOhm[\connections].page.put(val, \pink);
	~ohm.turnPink(val).yield;

	~restoreOhm[\connections].page.put(val, \blue);
	~ohm.turnBlue(val).yield;
	loop {
		~restoreOhm[\connections].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};

});