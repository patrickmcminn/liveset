/*
Wednesday, December 12th 2012
livesetOhm.scd
prm
*/

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
		amp = val.linlin(0, 127, 0, 0.7);
		~scLang.sendMsg(\mixer, \s1, amp);
	}, 5);

	MIDIdef.cc(\s2, { | val |
		var amp;
		amp = val.linlin(0, 127, 0, 0.7);
		~scLang.sendMsg(\mixer, \s2, amp);
	}, 7);

	MIDIdef.cc(\s3, { | val |
		var amp;
		amp = val.linlin(0, 127, 0, 0.7);
		~scLang.sendMsg(\mixer, \s3, amp);
	}, 6);
});


//creates function dictionaries to hold song functions specific to the Ohm control surface:

~connectOhm = ( );
~boyOhm = ( );
~birdsOhm = ( );