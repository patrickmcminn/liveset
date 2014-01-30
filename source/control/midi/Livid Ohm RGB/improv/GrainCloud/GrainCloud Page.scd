/*
Tuesday, January 21st 2013
GrainCloud Page.scd
prm
*/

~restoreOhm.grainCloud = ( );
~restoreOhm.grainCloud.page = Array.fill(81, nil);
~page.improv.grainCloud = ( );

~page.improv.grainCloud.top = {

  var scale = [1, 8, 9, 16, 17, 25, 32, 33, 40, 41, 48, 49, 57];
  var octave1 = scale + 6;
  var octave2 = scale + 4;
  var octave3 = scale + 2;
  var octave4 = scale;
  var octaveOffset = 0;

  ~ohm.clearAll;
  ~ohm.addEssential;

  octave1.do({ | val | ~ohm.turnBlue(val); });
  octave2.do({ | val | ~ohm.turnPurple(val); });
  octave3.do({ | val | ~ohm.turnCyan(val); });
  octave4.do({ | val | ~ohm.turnWhite(val); });

  octave1.do({ | val, index |
    var note = index + octaveOffset;
    MIDIdef.noteOn(("grainCloudOctave1" + val).asSymbol, {
      x.toggleNote(note);
      if( x.noteArray.includes(note),
        { ~ohm.turnGreen(val); ~restoreOhm.grainCloud.page.put(val, \green); },
        { ~ohm.turnBlue(val); ~restoreOhm.grainCloud.page.put(val, \blue); });
    }, val);
  });

  octave2.do({ | val, index |
    var note = index + octaveOffset + 12;
    MIDIdef.noteOn(("grainCloudOctave2" + val).asSymbol, {
      x.toggleNote(note);
      if( x.noteArray.includes(note),
        { ~ohm.turnGreen(val); ~restoreOhm.grainCloud.page.put(val, \green); },
        { ~ohm.turnPurple(val); ~restoreOhm.grainCloud.page.put(val, \purple); });
    }, val);
  });

  octave3.do({ | val, index |
    var note = index + octaveOffset + 24;
    MIDIdef.noteOn(("grainCloudOctave3" + val).asSymbol, {
      x.toggleNote(note);
      if( x.noteArray.includes(note),
        { ~ohm.turnGreen(val); ~restoreOhm.page.put(val, \green); },
        { ~ohm.turnCyan(val); ~restoreOhm.page.put(val, \cyan); });
  }, val);
  });

  octave4.do({ | val, index |
    var note = index + octaveOffset + 36;
    MIDIdef.noteOn(("grainCloudOctave4" + val).asSymbol, {
      x.toggleNote(note);
      if( x.noteArray.includes(note),
        { ~ohm.turnGreen(val); ~restoreOhm.page.put(val, \green); },
        { ~ohm.turnWhite(val); ~restoreOhm.page.put(val, \white); });
    }, val);
  });

  //////// Controls:

  // Add/Remove Sine:

  // Add/Remove Saw:

  // Add/Remove Gendy (careful!!):



  // trig rate low:
  MIDIdef.cc(\grainCloudTrigRateLow, { | val |
    var trigRateLow = val.linexp(0, 127, 1, 700);
    x.setTrigRateLow(trigRateLow); }, 17);

  // trig rate high:
  MIDIdef.cc(\grainCloudTrigRateHigh, { | val |
    var trigRateHigh = val.linexp(0, 127, 1, 1000);
    x.setTrigRateLow(trigRateHigh); }, 16);

  // sustain time low:
  MIDIdef.cc(\grainCloudSustainTimeLow, { | val |
    var sustainTimeLow = val.linlin(0, 127, 0.0001, 0.5);
    x.setSustainLow(sustainTimeLow) }, 9);

  // sustain tim high:
  MIDIdef.cc(\grainCloudSustainTimeHigh, { | val |
    var sustainTimeHigh = val.linlin(0, 127, 0.0005, 0.7);
    x.setSustainHigh(sustainTimeHigh) }, 8);

  // cutoff frequency low:
  MIDIdef.cc(\grainCloudCutoffFreqLow, { | val |
    var cutoffLow = val.linexp(0, 127, 100, 15000);
    x.setCutoffLow(cutoffLow) }, 19);

  // cutoff frequency high:
  MIDIdef.cc(\grainCloudCutoffFreqHigh, { | val |
    var cutoffHigh = val.linexp(0, 127, 200, 17000);
    x.setCutoffHigh(cutoffHigh) }, 18);

  // rq low:
  MIDIdef.cc(\grainCloudRQLow, { | val |
    var rqLow = val.linlin(0, 127, 1.0, 0.05);
    x.setRQLow(rqLow) }, 11);

  // rq high:
  MIDIdef.cc(\grainCloudRQHigh, { | val |
    var rqHigh = val.linlin(0, 127, 1.0, 0.01);
    x.setRQHigh(rqHigh) }, 10);

  // pan low:
  MIDIdef.cc(\grainCloudPanLow, { | val |
    var panLow = val.linlin(0, 127, -1.0, 1.0);
    x.setPanLow(panLow) }, 21);

  // pan high:
  MIDIdef.cc(\grainCloudPanHigh, { | val |
    var panHigh = val.linlin(0, 127, -1.0, 1.0);
    x.setPanHigh(panHigh); }, 20);

  // volume:
  MIDIdef.cc(\grainCloudVolume, { | val |
    var vol = val.linlin(0, 127, -70, 0);
    x.setVol(vol);}, 14);

  ~restoreOhm.grainCloud.keysValuesDo({ | name, state |  ~scLang.sendMsg(\restoreOhm, name, state); });
  ~restoreOhm.grainCloud.keysValuesDo({ | name, state | ~scLang.sendMsg(\restoreOhmImprov, name, state); });

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
	});
};