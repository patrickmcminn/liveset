/*
Sunday, January 13th 2012
improvPage.scd
prm
*/

var poppy, huge, grainCloud;
var page = 'improv';
poppy = 3;
huge = 5;
grainCloud = 7;


~restoreOhm[\improv] = ( );
~restoreOhm[\improv].page = Array.fill(81, nil);
~page.improv = ( );
//~ohm2.makePage(page);

~page.improv.top = {
  ~ohm2.setPage(page);

	~ohm.clearAll;
	~ohm.addEssential;

	~ohm.turnGreen(0);
	MIDIdef.noteOn(\gendy, { ~scLang.sendMsg(\gendy, \main) }, 0);

	~ohm.turnGreen(1);
	MIDIdef.noteOn(\pings, { ~scLang.sendMsg(\pings, \main) }, 1);

	~ohm.turnYellow(2);
	MIDIdef.noteOn(\improvNoiseSynth, { ~scLang.sendMsg(\improvNoiseSynth, \main) }, 2);

	~ohm.turnWhite(poppy);
	MIDIdef.noteOn(\improvPoppy, { ~improv.poppy.spawn; }, poppy);

	~ohm.turnCyan(huge);
	MIDIdef.noteOn(\improvHuge, { ~improv.huge.spawn; }, huge);

  //~ohm.turnPurple(grainCloud);
  //MIDIdef.noteOn(\improvGrainCloud, { ~improvOhm.grainCloud.spawn; }, grainCloud);


	~restoreOhm[\improv].keysValuesDo({ | name, state |  ~scLang.sendMsg(\restoreOhm, name, state); });
	~restoreOhm.improv.keysValuesDo({ | name, state | ~scLang.sendMsg(\restoreOhmImprov, name, state); });

	~restoreOhm[\improv].page.do({ | color, note |
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

  ~ohm2.turnGridPurple(0, 7, page: page);
  ~ohm2.setGridFunc(0, 7, r {
    loop {
      ~grainCloud = GrainCloud2.new(~mixer.s2, -6.dbamp, 0, ~group.fx, \addToTail);
      ~ohm2.setGridFunc(1, 7, { ~ohm.clearAll; ~ohm2.setPage('grainCloud'); ~ohm.addEssential; });
      ~ohm2.turnGridWhite(1, 7);
      ~ohm2.turnGridGreen(0, 7).yield;

      ~grainCloud.free;
      ~ohm2.setGridFunc(1, 7, { });
      ~ohm2.turnGridOff(1, 7);
      ~ohm2.turnGridRed(0, 7).yield;
    };
  });


  ~ohm2.turnGridBlue(4, 0);
  ~ohm2.setGridFunc(4, 0, r {
    loop {
      ~delayNetwork = DelayNetwork.new(~inst.mic, ~mixer.s3, 0.dbamp, 0, 8, 3, 0.1, 0.5, 45, 55, 0, 3000, 4000, 0, 0, -0.2, 0.2,
        relGroup: ~group.fx, addAction: \addToTail);
      ~ohm2.setGridFunc(5, 0, { ~ohm.clearAll; ~ohm2.setPage('delayNetwork'); ~ohm.addEssential; });
      ~ohm2.turnGridPurple(5, 0);
      ~ohm2.turnGridGreen(4, 0).yield;

      ~delayNetwork.free;
      ~ohm2.setGridFunc(5, 0, { });
      ~ohm2.turnGridOff(5, 0);
      ~ohm2.turnGridRed(4, 0).yield;
    };
  });

  ~ohm2.turnGridRed(4, 1, page: page);
  ~ohm2.setGridFunc(4, 1, {
    ~delayNetwork.free;
    ~ohm2.setGridFunc(5, 0, { });
    ~ohm2.turnGridOff(5, 0);
    ~ohm2.turnGridRed(4, 0);
  });

  ~ohm2.turnGridWhite(4, 2, page: page);
  ~ohm2.setGridFunc(4, 2, r {
    loop {
      ~fakeGuitar = FakeGuitar.new(~mixer.s1, -6.dbamp, 0, ~group.fx, \addToTail);
      ~ohm2.setGridFunc(5, 2, { ~ohm.clearAll; ~ohm2.setPage('fakeGuitar'); ~ohm.addEssential; });
      ~ohm2.turnGridCyan(5, 2);
      ~ohm2.turnGridGreen(5, 2).yield;

      ~fakeGuitar.free;
      ~ohm2.setGridFunc(5, 2, { });
      ~ohm2.turnGridOff(5, 2);
      ~ohm2.turnGridRed(4, 2).yield;
    }
  });

  ~ohm2.turnGridRed(4, 3, page: page);
  ~ohm2.setGridFunc(4, 3, {
    ~fakeGuitar.free;
    ~ohm2.setGridFunc(5, 2, { });
    ~ohm2.turnGridOff(5, 2);
    ~ohm2.turnGridRed(4, 2);
  }, page: page);

};
