/*
Monday, December 17th 2012
tremgtrOhm.scd
prm
*/


var val, toggle, shift, vol;
val = 2;
toggle = 10;
shift = 47;
vol = 15;

OSCdef(\tremgtrOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \tremgtr } { ~birdsOhm[\tremgtr].value; }
	{ id == \tremgtrToggle } { ~birdsOhm[\tremgtrToggle].value; }
}, \control, ~scLang);

OSCdef(\tremgtrOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \tremgtr } {
		if ( val == 1, { ~birdsOhmMidi[\tremgtr].make; } );
	}
}, \restoreOhm);


~birdsOhm[\tremgtr] = r ({
	loop {
		~restoreOhm[\birds].tremgtr = 1;
		~birdsOhmMidi[\tremgtr].make;
		~restoreOhm[\birds].page.put(toggle, \blue);
		~ohm.turnBlue(toggle);
		~restoreOhm[\birds].page.put(shift, \green);
		~ohm.turnGreen(shift);
		~restoreOhm[\birds].page.put(val, \purple);
		~ohm.turnPurple(val).yield;

		~restoreOhm[\birds].tremgtr = 0;
		~birdsOhmMidi[\tremgtr].kill;
		~restoreOhm[\birds].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\birds].page.put(shift, \off);
		~ohm.turnOff(shift);
		~restoreOhm[\birds].page.put(val, \red);
		~ohm.turnRed(val).yield;

	};

});

~birdsOhm[\tremgtrToggle] = r ({
	loop {
		~restoreOhm[\birds].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;

		~restoreOhm[\birds].page.put(toggle, \blue);
		~ohm.turnBlue(toggle).yield;
	};
});

~birdsOhmMidi[\tremgtr] = { };
~birdsOhmMidi[\tremgtr].addUniqueMethod(\make, {
	MIDIdef.noteOn(\tremgtrToggle, { ~scLang.sendMsg(\tremgtr, \toggle); }, toggle);
	MIDIdef.noteOn(\tremgtrShift, { ~scLang.sendMsg(\tremgtr, \shift); }, shift);
	MIDIdef.cc(\tremgtrVolume, { | val |
			var amp = val.linlin(0, 127, 0, -6.dbamp);
			~scLang.sendMsg(\tremgtr, \volume, amp); }, vol);
});
~birdsOhmMidi[\tremgtr].addUniqueMethod(\kill, {
	MIDIdef(\tremgtrToggle).free;
	MIDIdef(\tremgtrShift).free;
	MIDIdef(\tremgtrVolume).free;
});