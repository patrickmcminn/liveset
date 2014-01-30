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

  ~ohm2.turnGridPurple(0, 7);
  ~ohm2.setGridFunc(0, 7, r {
    loop {
      ~grainCloud = GrainCloud.new(~mixer.s2, -6.dbamp, 0, ~group.fx, \addToTail);
      ~ohm2.setGridFunc(1, 7, { ~ohm.clearAll; ~ohm2.setPage('grainCloud'); ~ohm.addEssential; });
      ~ohm2.turnGridWhite(1, 7);
      ~ohm2.turnGridGreen(0, 7).yield;

      ~grainCloud.free;
      ~ohm2.setGridFunc(1, 7, { });
      ~ohm2.turnGridOff(1, 7);
      ~ohm2.turnGridRed(0, 7).yield;
    };
  });
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

};
