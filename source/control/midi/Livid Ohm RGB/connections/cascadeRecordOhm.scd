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
		~restoreOhm[\connections].page.put(val, \lavender);
		~ohm.turnLavender(val).yield;

		~restoreOhm[\connections].page.put(val, \purple);
		~ohm.turnPurple(val).yield;

		~restoreOhm[\connections].page.put(val, \yellow);
		~ohm.turnYellow(val).yield;
	};
};