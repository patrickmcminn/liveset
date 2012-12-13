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


~boyOhm[\bassline] = r({
	loop {

		~ohm.turnPurple(one);
		MIDIdef.noteOn(\boyBasslineOne, { ~scLang.sendMsg(\boyBassline, \one); }, one);

		~ohm.turnLavender(two);
		MIDIdef.noteOn(\boyBasslineTwo, { ~scLang.sendMsg(\boyBassline, \two); }, two);

		~ohm.turnPink(three);
		MIDIdef.noteOn(\boyBasslineThree, { ~scLang.sendMsg(\boyBassline, \three); }, three);

		MIDIdef.cc(\boyBasslineVolume, { | val |
			var amp = val.linlin(0, 127, 0, 1);
			~scLang.sendMsg(\boyBassline, \volume, amp); }, vol);

		MIDIdef.cc(\boyBasslineCutoff, { | val |
			var cutoff = val.linlin(0, 127, 0, 7000);
			~scLang.sendMsg(\boyBassline, \cutoff, cutoff); }, cutoff);

		~ohm.turnPink(val).yield;


		~ohm.turnOff(one);
		~ohm.turnOff(two);
		~ohm.turnOff(three);
		MIDIdef(\boyBasslineOne).free;
		MIDIdef(\boyBasslineTwo).free;
		MIDIdef(\boyBasslineThree).free;
		MIDIdef(\boyBasslineVolume).free;
		MIDIdef(\boyBasslineCutoff).free;

		~ohm.turnRed(val).yield;
	};
});

~boyOhm[\basslineOne] = r({
	loop {
		~ohm.turnBlue(one).yield;

		~ohm.turnRed(one).yield;
	};
});

~boyOhm[\basslineTwo] = r ({
	loop {
		~ohm.turnYellow(two).yield;

		~ohm.turnRed(two).yield;
	};
});

~boyMake[\basslineThree] = r({
	loop {
		~ohm.turnPink(three).yield;

		~ohm.turnRed(three).yield;
	};
});
