/*
Friday, November 23rd 2012
bassline.scd
prm
*/

var val, one, two, three, vol, cutoff;
val = 3;
one = 4;
two = 12;
three = 20;
vol = 22;
cutoff = 20;

OSCdef(\boyBasslineOhm, { | msg |
	var id = msg.at(1);
	case
	{ id == \boyBassline } { ~boyOhm[\bassline].value; }
	{ id == \boyBasslineOne } { ~boyOhm[\basslineOne].value; }
	{ id == \boyBasslineTwo } { ~boyOhm[\basslineTwo].value; }
	{ id == \boyBasslineThree } { ~boyOhm[\basslineThree].value; }
}, \control, ~scLang);

OSCdef(\boyBasslineOhmRestore, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \boyBassline } {
		if ( val == 1, { ~boyOhmMidi[\bassline].make; } );
	}
}, \restoreOhm);


~boyOhm[\bassline] = r({
	loop {
		~restoreOhm[\boy].boyBassline = 1;
		~boyOhmMidi[\bassline].make;
		~restoreOhm[\boy].page.put(one, \purple);
		~ohm.turnPurple(one);
		~restoreOhm[\boy].page.put(two, \lavender);
		~ohm.turnLavender(two);
		~restoreOhm[\boy].page.put(three, \pink);
		~ohm.turnPink(three);
		~restoreOhm[\boy].page.put(val, \pink);
		~ohm.turnPink(val).yield;

		~restoreOhm[\boy].boyBassline = 0;
		~boyOhmMidi[\bassline].kill;
		~restoreOhm[\boy].page.put(one, \off);
		~ohm.turnOff(one);
		~restoreOhm[\boy].page.put(two, \off);
		~ohm.turnOff(two);
		~restoreOhm[\boy].page.put(three, \off);
		~ohm.turnOff(three);
		~restoreOhm[\boy].page.put(val, \red);
		~ohm.turnRed(val).yield;
	};
});



~boyOhm[\basslineOne] = r({
	loop {
		~restoreOhm[\boy].page.put(one, \blue);
		~ohm.turnBlue(one).yield;

		~restoreOhm[\boy].page.put(one, \red);
		~ohm.turnRed(one).yield;
	};
});

~boyOhm[\basslineTwo] = r ({
	loop {
		~restoreOhm[\boy].page.put(two, \yellow);
		~ohm.turnYellow(two).yield;

		~restoreOhm[\boy].page.put(two, \red);
		~ohm.turnRed(two).yield;
	};
});

~boyOhm[\basslineThree] = r({
	loop {
		~restoreOhm[\boy].page.put(three, \blue);
		~ohm.turnBlue(three).yield;

		~restoreOhm[\boy].page.put(three, \red);
		~ohm.turnRed(three).yield;
	};
});


~boyOhmMidi[\bassline] = { };
~boyOhmMidi[\bassline].addUniqueMethod(\make, {
	MIDIdef.noteOn(\boyBasslineOne, { ~scLang.sendMsg(\boyBassline, \one); }, one);
	MIDIdef.noteOn(\boyBasslineTwo, { ~scLang.sendMsg(\boyBassline, \two); }, two);
	MIDIdef.noteOn(\boyBasslineThree, { ~scLang.sendMsg(\boyBassline, \three); }, three);
	MIDIdef.cc(\boyBasslineVolume, { | val |
			var amp = val.linlin(0, 127, 0, 3.dbamp);
			~scLang.sendMsg(\boyBassline, \volume, amp); }, vol);
	MIDIdef.cc(\boyBasslineCutoff, { | val |
		var cutoff = val.linlin(0, 127, 40, 7000);
		~scLang.sendMsg(\boyBassline, \cutoff, cutoff;) }, cutoff);
});
~boyOhmMidi[\bassline].addUniqueMethod(\kill, {
	MIDIdef(\boyBasslineOne).free;
	MIDIdef(\boyBasslineTwo).free;
	MIDIdef(\boyBasslineThree).free;
	MIDIdef(\boyBasslineVolume).free;
	MIDIdef(\boyBasslineCutoff).free;
});

