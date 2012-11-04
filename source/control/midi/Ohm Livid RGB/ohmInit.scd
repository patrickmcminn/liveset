/*
Thursday, September 20th 2012
ohmInit.scd
prm
Initializes Ohm RGB Control Surface and creates basic functions to provide
visual feedback
*/

(
var ohm;
MIDIIn.connectAll;
ohm = MIDIOut.newByName("OhmRGB", "Controls");
ohm.latency = 0;

~ohm = { };
~ohm.addUniqueMethod(\turnOff, { | func, val |
	ohm.noteOn(16, val, 0)});
~ohm.addUniqueMethod(\turnLavender, { | func, val |
	ohm.noteOn(16, val, 1)});
~ohm.addUniqueMethod(\turnBlue, { | func, val |
	ohm.noteOn(16, val, 4)});
~ohm.addUniqueMethod(\turnPink, { | func, val |
	ohm.noteOn(16, val, 8)});
~ohm.addUniqueMethod(\turnRed, { | func, val |
	ohm.noteOn(16, val, 16)});
~ohm.addUniqueMethod(\turnPurple, { | func, val |
	ohm.noteOn(16, val, 32)});
~ohm.addUniqueMethod(\turnYellow, { | func, val |
	ohm.noteOn(16, val, 64)});
~ohm.addUniqueMethod(\turnGreen, { | func, val |
	ohm.noteOn(16, val, 127)});


~ohm.addUniqueMethod(\clearAll, { | func, val |
	MIDIdef.freeAll;
	127.do({ | i | ~ohm.turnOff(i);});});


~ohm.addUniqueMethod(\blink, { | func, val, color, time |
	case
	{ color == \lavender } {
		~ohm.turnLavender(val);
		{ ~ohm.turnOff(val) }.defer(time);}
	{ color == \blue } {
		~ohm.turnBlue(val);
		{ ~ohm.turnOff(val) }.defer(time);}
	{ color == \pink } {
		~ohm.turnPink(val);
		{ ~ohm.turnOff(val) }.defer(time); }
	{ color == \red } {
		~ohm.turnRed(val);
		{ ~ohm.turnOff(val) }.defer(time); }
	{ color == \purple } {
		~ohm.turnPurple(val);
		{ ~ohm.turnOff(val) }.defer(time); }
	{ color == \yellow } {
		~ohm.turnYellow(val);
		{ ~ohm.turnOff(val) }.defer(time); }
	{ color == \green } {
		~ohm.turnGreen(val);
		{ ~ohm.turnOff(val) }.defer(time); }
});

~ohm.addUniqueMethod(\addEssential, {
	// adds buttons and faders that persist through page and effect changes

	// Ohm Button to toggle booting and quitting the server
	~ohm.turnGreen(87);
	MIDIdef.noteOn(\reboot, Routine({ | val = 87 |
		loop{
			~scLang.sendMsg(\server, \quit);
			["quitting server"].postln;
			~ohm.turnRed(val).yield;

			~scLang.sendMsg(\server, \boot);
			["booting server"].postln;
			~ohm.turnGreen(val).yield;
		};
	}), 87);

	// Ohm Button to go to Top Page
	~ohm.turnGreen(71);
	MIDIdef.noteOn(\topPage, { ~scLang.sendMsg(\page, \top) }, 71);

	// Master Volume Control (Far Right Slider)
	MIDIdef.cc(\masterVolume, { | val |
		var amp;
		amp = val.linlin(0, 127, 0, 1);
		~scLang.sendMsg(\mixer, \master, amp)
	}, 4);

	MIDIdef.cc(\s1, { | val |
		var amp;
		amp = val.linlin(0, 127, 0, 1);
		~scLang.sendMsg(\mixer, \s1, amp);
	}, 5);

	MIDIdef.cc(\s2, { | val |
		var amp;
		amp = val.linlin(0, 127, 0, 1);
		~scLang.sendMsg(\mixer, \s2, amp);
	}, 7);

	MIDIdef.cc(\s3, { | val |
		var amp;
		amp = val.linlin(0, 127, 0, 1);
		~scLang.sendMsg(\mixer, \s3, amp);
	}, 6);
});



~ohm.addUniqueMethod(\splash, { | func, val |
	Routine({
		127.do({ | i |
		~ohm.turnRed(i);
		0.01.wait;
	});
	0.25.wait;
	127.do({ | i | ~ohm.turnGreen(i); });
	0.5.wait;
	127.do({ | i | ~ohm.turnOff(i); });
	"Ohm initialized".postln;
	}).play(AppClock);
});


// creates function dictionary to hold different pages
~page = ( );


"Ohm Functions Added".postln;
)

		