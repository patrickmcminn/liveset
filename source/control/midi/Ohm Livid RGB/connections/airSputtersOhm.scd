/*
Saturday, October 13th 2012
airSputters.scd
prm
*/

var val, toggle, vol;
val = 0;
toggle = 8;
vol = 23;

OSCdef(\airSputtersOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \airSputters } { ~connectOhm[\airSputters].value; }
	{ id == \airSputtersToggle } { ~connectOhm[\airSputtersToggle].value; }
	{ id == \sputterMake } { ~connectOhm[\sputterMake].value; }
}, \control, ~scLang);


~connectOhm[\airSputters] = r {
	loop {

		~ohm.turnGreen(toggle);
		MIDIdef.noteOn(\airSputtersToggle, { ~scLang.sendMsg(\airSputters, \toggle, toggle) }, toggle);

		MIDIdef.cc(\airSputtersVol, { | val |
			var amp = val.linlin(0, 127, 0, -4.dbamp);
			~scLang.sendMsg(\airSputters, \volume, amp) }, vol);
		~ohm.turnPurple(val).yield;


		~ohm.turnOff(toggle);
		MIDIdef(\airSputtersToggle).free;
		MIDIdef(\airSputtersVol).free;
		~ohm.turnRed(val).yield;
	};
};


~connectOhm[\airSputtersToggle] = r {
	loop {
		~ohm.turnRed(toggle).yield;

		~ohm.turnPink(toggle).yield;
	};
};

~connectOhm[\sputterMake] = r ({
	loop {
		~ohm.turnLavender(val).yield;

		~ohm.turnPink(val).yield;

		~ohm.turnPurple(val).yield;

		~ohm.turnYellow(val).yield;

		~ohm.turnBlue(val).yield;
	};
});