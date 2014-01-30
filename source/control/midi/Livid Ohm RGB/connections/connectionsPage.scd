/*
Thursday, October 18th 2012
edited 1/11/2013
connectionsPage.scd
prm
*/

~restoreOhm[\connections] = ( );
~restoreOhm[\connections].page = Array.fill(81, nil);


~page[\connections] = {
	~ohm.clearAll;
	~ohm.addEssential;

	~ohm.turnGreen(0);
	MIDIdef.noteOn(\airSputters, { ~scLang.sendMsg(\airSputters, \main)}, 0);

	~ohm.turnGreen(1);
	MIDIdef.noteOn(\droner, { ~scLang.sendMsg(\droner, \main)}, 1);


	~ohm.turnGreen(3);
	MIDIdef.noteOn(\noteRecord, { ~scLang.sendMsg(\noteRecord, \main)}, 3);
	~ohm.turnGreen(11);
	MIDIdef.noteOn(\cascadeRecord, { ~scLang.sendMsg(\cascade, \record)}, 11);
	~ohm.turnGreen(19);
	MIDIdef.noteOn(\chordRecord, { ~scLang.sendMsg(\chords, \record)}, 19);


	~ohm.turnGreen(4);
	MIDIdef.noteOn(\bassline, { ~scLang.sendMsg(\bassline, \main)}, 4);


	~ohm.turnGreen(5);
	MIDIdef.noteOn(\granDelay, { ~scLang.sendMsg(\granDelay, \main)}, 5);


	~ohm.turnGreen(64);
	MIDIdef.noteOn(\inlet, { ~scLang.sendMsg(\inlet, \main)}, 64);

	~ohm.turnGreen(6);
	MIDIdef.noteOn(\attackRandomizer, { ~scLang.sendMsg(\attackRandomizer, \main)}, 6);

	~ohm.turnGreen(7);
	MIDIdef.noteOn(\cascade, { ~scLang.sendMsg(\cascade, \main)}, 7);

	~ohm.turnGreen(32);
	MIDIdef.noteOn(\chords, { ~scLang.sendMsg(\chords, \main)}, 32);

	~ohm.turnGreen(33);
	MIDIdef.noteOn(\stabs, {
		~scLang.sendMsg(\stabs, \main)}, 33);

	~ohm.turnGreen(34);
	MIDIdef.noteOn(\micVerb, { ~scLang.sendMsg(\micVerb, \main) }, 34);

	~ohm.turnGreen(77);
	MIDIdef.noteOn(\transport, { ~scLang.sendMsg(\connectionsTransport, \main) }, 77);

/*
  // damn, son, here's some VERY TEMPORARY lighting cues:
  ~ohm.turnRed(87);
  MIDIdef.noteOn(\dmxInit, {
    ~dmx = DMX.new;
    ~enttec = EntTecDMXUSBPro.new("/dev/tty.usbserial-EN129369");
    ~dmx.device = ~enttec;
    ~dmxCue = DMXCue.new;

    // light 1:
    ~dmxCue.put(0, 0);
    ~dmxCue.put(2, 0.3);
    ~dmxCue.put(5, 0);

    // light 2:
    ~dmxCue.put(14, 0);
    ~dmxCue.put(16, 0.25);
    ~dmxCue.put(19, 0);


    // light 3:
    ~dmxCue.put(29, 0);
    ~dmxCue.put(31, 0.25);
    ~dmxCue.put(34, 0);


    ~dmx.currentCue = ~dmxCue;
    ~dmx.setCue;
  }, 87);

  ~ohm.turnGreen(65);
  MIDIdef.noteOn(\dmxCue1, {

    // light 1:
    ~dmxCue.put(0, 0);
    ~dmxCue.put(2, 0.3);
    ~dmxCue.put(9, 0);
    4.do({ | index | ~dmxCue.put(index + 5, 1); });

    // light 2:
    ~dmxCue.put(14, 0);
    ~dmxCue.put(16, 0.25);
    ~dmxCue.put(19, 0);



    // light 3:
    ~dmxCue.put(29, 0);
    ~dmxCue.put(31, 0.25);
    ~dmxCue.put(34, 0);


    ~dmx.currentCue = ~dmxCue;
    ~dmx.setCue;
  }, 65);

  ~ohm.turnYellow(73);
  MIDIdef.noteOn(\dmxCue2, {

    // Light 1:
    ~dmxCue.put(0, 0);
    ~dmxCue.put(2, 0.3);
    ~dmxCue.put(5, 210.linlin(0, 255, 0, 1));
    ~dmxCue.put(9, 0);


    // Light 2:
    ~dmxCue.put(14, 0);
    ~dmxCue.put(16, 0.25);
    ~dmxCue.put(19, 200.linlin(0, 255, 0, 1));
    ~dmxCue.put(23, 0);
    3.do({ | index | ~dmxCue.put(index + 20, 1); });


    // light 3:
    ~dmxCue.put(29, 0);
    ~dmxCue.put(31, 0.25);
    ~dmxCue.put(34, 202.linlin(0, 255, 0, 1));
    ~dmxCue.put(38, 0);
    3.do({ | index | ~dmxCue.put(index + 35, 1); });

    ~dmx.currentCue = ~dmxCue;
    ~dmx.setCue;
  }, 73);

  ~ohm.turnPurple(66);
  MIDIdef.noteOn(\dmxCue3, {

    // Light 1:
    ~dmxCue.put(9, 1);
    ~dmxCue.put(5, 210.linlin(0, 255, 0, 1));

    // Light 2:
    ~dmxCue.put(14, 0);
    ~dmxCue.put(16, 0.25);
    ~dmxCue.put(19, 205.linlin(0, 255, 0, 1));
    ~dmxCue.put(23, 1);
    ~dmxCue.put(24, 0);

    // light 3:
    ~dmxCue.put(29, 0);
    ~dmxCue.put(31, 0.25);
    ~dmxCue.put(34, 205.linlin(0, 255, 0, 1));
    ~dmxCue.put(38, 1);
    ~dmxCue.put(39, 0);

    ~dmx.currentCue = ~dmxCue;
    ~dmx.setCue;
  }, 66);

  ~ohm.turnCyan(74);
  MIDIdef.noteOn(\dmxCue4, {

    // Light 1:
    ~dmxCue.put(9, 1);
    ~dmxCue.put(10, 0);
    ~dmxCue.put(5, 1);

    // Light 2:
    ~dmxCue.put(19, 1);
    ~dmxCue.put(23, 1);
    ~dmxCue.put(24, 0.02);

    // Light 3:
    ~dmxCue.put(34, 1);
    ~dmxCue.put(38, 1);
    ~dmxCue.put(39, 0.01);

    ~dmx.currentCue = ~dmxCue;
    ~dmx.setCue;
  }, 74);
  */


	~restoreOhm[\connections].keysValuesDo({ | name, state |  ~scLang.sendMsg(\restoreOhm, name, state); });

	~restoreOhm[\connections].page.do({ | color, note |
		case
		{ color == \off } { ~ohm.turnOff(note); }
		{ color == \blue } { ~ohm.turnBlue(note); }
		{ color == \red } { ~ohm.turnRed(note); }
		{ color == \purple } { ~ohm.turnPurple(note); }
		{ color == \green } { ~ohm.turnGreen(note); }
		{ color == \yellow } { ~ohm.turnYellow(note); }
		{ color == \cyan } { ~ohm.turnCyan(note); }
		{ color == \white } { ~ohm.turnWhite(note); }

		//legacy colors:
		{ color == \pink } { ~ohm.turnPink(note) ; }
		{ color == \lavender } { ~ohm.turnLavender(note); }
	});


}






