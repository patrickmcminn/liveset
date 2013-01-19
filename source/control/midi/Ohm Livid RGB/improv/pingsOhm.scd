/*
Monday, January 14th 2012
pingsOhm.scd
prm
*/

var val, toggle, vol, loScale, hiScale;
val = 1;
toggle = 9;
vol = 22;
loScale = 17;
hiScale = 16;

OSCdef(\pingsOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \pings } { ~improvOhm[\pings].value; }
	{ id == \pingsToggle } { ~improvOhm[\pingsToggle].value; }
}, \control);

OSCdef(\pingsOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \pings } {
		if ( val == 1, { ~improvOhmMidi[\pings].make; } );
	}
}, \restoreOhm);

~improvOhm[\pings] = r ({
	loop {
		~restoreOhm[\improv].pings = 1;
		~improvOhmMidi[\pings].make;
		~restoreOhm[\improv].page.put(toggle, \purple);
		~ohm.turnPurple(toggle);
		~restoreOhm[\improv].page.put(val, \blue);
		~ohm.turnBlue(val).yield;

		~restoreOhm[\improv].pings = 0;
		~improvOhmMidi[\pings].kill;
		~restoreOhm[\improv].page.put(toggle, \off);
		~ohm.turnOff(toggle);
		~restoreOhm[\improv].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
});

~improvOhm[\pingsToggle] = r({
	loop {
		~restoreOhm[\improv].page.put(toggle, \red);
		~ohm.turnRed(toggle).yield;

		~restoreOhm[\improv].page.put(toggle, \purple);
		~ohm.turnPurple(toggle).yield;
	}
});

~improvOhmMidi[\pings] = { };
~improvOhmMidi[\pings].addUniqueMethod(\make, {
	MIDIdef.noteOn(\pingsToggle, { ~scLang.sendMsg(\pings, \toggle, toggle); }, toggle);
	MIDIdef.cc(\pingsVolume, { | val |
		var amp = val.linlin(0, 127, 0, 1);
		~scLang.sendMsg(\pings, \volume, amp); }, vol);
	MIDIdef.cc(\pingsLoScale, { | val |
		var scale = val.linlin(0, 127, 2, 60);
		~scLang.sendMsg(\pings, \loScale, scale); }, loScale);
	MIDIdef.cc(\pingsHiScale, { | val |
		var scale = val.linlin(0, 127, 20, 150);
		~scLang.sendMsg(\pings, \hiScale, scale) }, hiScale);
});
~improvOhmMidi[\pings].addUniqueMethod(\kill, {
	MIDIdef(\pingsToggle).free;
	MIDIdef(\pingsVolume).free;
	MIDIdef(\pingsLoScale).free;
	MIDIdef(\pingsHiScale).free;
});