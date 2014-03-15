/*
Tuesday, January 21st 2013
grainCloudOhm.scd
prm
*/

var page = 'grainCloud';
var susBank = 0;
var relBank = 1;
// ~ohm.makePage(page);
var octave1 = [[0, 7], [1, 6], [1, 7], [2, 6], [2, 7], [3, 7], [4, 6], [4, 7], [5, 6], [5, 7], [6, 6], [6, 7]];
var octave2 = octave1 - [[0, 2]];
var octave3 = octave2 - [[0, 2]];
var octave4 = octave3 - [[0, 2]];

~ohm2.addGridBanks(1, page: page);


// susBank:

octave1.do({ | item | ~ohm2.turnGridBlue(item[0], item[1], page: page, bank: susBank); });
octave2.do({ | item | ~ohm2.turnGridCyan(item[0], item[1], page: page, bank: susBank); });
octave3.do({ | item | ~ohm2.turnGridPurple(item[0], item[1], page: page, bank: susBank); });
octave4.do({ | item | ~ohm2.turnGridYellow(item[0], item[1], page: page, bank: susBank); });

octave1.do({ | item, index |
  var note = index;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridBlue(item[0], item[1]); }
    );
  }, page: page, bank: susBank);
});

octave2.do({ | item, index  |
  var note = index + 12;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridCyan(item[0], item[1]); }
    );
  }, page: page, bank: susBank);
});

octave3.do({ | item, index  |
  var note = index + 24;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridPurple(item[0], item[1]); }
    );
  }, page: page, bank: susBank);
});

octave4.do({ | item, index  |
  var note = index + 36;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridYellow(item[0], item[1]); }
    );
  }, page: page, bank: susBank);
});


// relBank:
octave1.do({ | item | ~ohm2.turnGridCyan(item[0], item[1], page: page, bank: relBank); });
octave2.do({ | item | ~ohm2.turnGridPurple(item[0], item[1], page: page, bank: relBank); });
octave3.do({ | item | ~ohm2.turnGridYellow(item[0], item[1], page: page, bank: relBank); });
octave4.do({ | item | ~ohm2.turnGridBlue(item[0], item[1], page: page, bank: relBank); });

octave1.do({ | item, index  |
  var note = index;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridCyan(item[0], item[1]); }
    );
  }, page: page, bank: relBank);
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridCyan(item[0], item[1]); }
    );
  }, type: 'noteOff', page: page, bank: relBank);
});

octave2.do({ | item, index  |
  var note = index + 12;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridPurple(item[0], item[1]); }
    );
  }, page: page, bank: susBank);
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridPurple(item[0], item[1]); }
    );
  }, type: 'noteOff', page: page, bank: relBank);
});

octave3.do({ | item, index  |
  var note = index + 24;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridYellow(item[0], item[1]); }
    );
  }, page: page, bank: susBank);
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridYellow(item[0], item[1]); }
    );
  }, type: 'noteOff', page: page, bank: relBank);
});

octave4.do({ | item, index  |
  var note = index + 36;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridBlue(item[0], item[1]); }
    );
  }, page: page, bank: susBank);
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.playingArray[note],
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridBlue(item[0], item[1]); }
    );
  }, type: 'noteOff', page: page, bank: relBank);
});

// bank change:

~ohm2.setCrossfaderButtonFunc(0, r{
  loop {
    ~ohm2.setActiveGridBank(relBank);
    ~ohm2.turnCrossfaderButtonWhite(0).yield;

    ~ohm2.setActiveGridBank(susBank);
    ~ohm2.turnCrossfaderButtonPurple(0).yield;
  }
}, page: page);


4.do({ | index | ~ohm2.turnLeftButtonWhite(index, page: page); });
~ohm2.turnLeftButtonGreen(0, page: page);

~ohm2.setLeftButtonFunc(0, {
  ~grainCloud.setInstArray([\gaborWideSine]);
  ~ohm2.turnLeftButtonGreen(0);
  3.do({ | index | ~ohm2.turnLeftButtonWhite(index + 1);
  });
}, page: page);

~ohm2.setLeftButtonFunc(1, {
  ~grainCloud.setInstArray([\gaborWideSaw]);
  4.do({ | index | ~ohm2.turnLeftButtonWhite(index); });
  ~ohm2.turnLeftButtonGreen(1);
}, page: page);




~ohm2.setLeftButtonFunc(3, {
  ~grainCloud.setInstArray([\gaborGendy]);
  ~ohm2.turnLeftButtonGreen(3);
  3.do({ | index | ~ohm2.turnLeftButtonWhite(index); });
}, page: page);


// master volume:
~ohm2.setLeftSliderFunc(3, { | val |
  var vol = val.linlin(0, 127, -70, 3);
  ~grainCloud.setVol(vol);
}, page: page);

// trig rate low:
~ohm2.setLeftKnobFunc(0, 0, { | val |
  var trigRateLow = val.linexp(0, 127, 0.1, 300);
  ~grainCloud.setTrigRateLow(trigRateLow);
}, page: page);

// trig rate high:
~ohm2.setLeftKnobFunc(1, 0, { | val |
  var trigRateHigh = val.linexp(0, 127, 0.1, 400);
  ~grainCloud.setTrigRateLow(trigRateHigh);
}, page: page);

// sustain time low:
~ohm2.setLeftKnobFunc(2, 0, { | val |
  var sustainTimeLow = val.linlin(0, 127, 0.0001, 0.5);
  ~grainCloud.setSustainLow(sustainTimeLow)
}, page: page);

// sustain time high:
~ohm2.setLeftKnobFunc(3, 0, { | val |
  var sustainTimeHigh = val.linlin(0, 127, 0.0005, 0.7);
  ~grainCloud.setSustainHigh(sustainTimeHigh)
}, page: page);

// cutoff low:
~ohm2.setLeftKnobFunc(0, 1, { | val |
  var cutoffLow = val.linexp(0, 127, 100, 15000);
  ~grainCloud.setCutoffLow(cutoffLow)
}, page: page);

// cutoff high:
~ohm2.setLeftKnobFunc(1, 1, { | val |
  var cutoffHigh = val.linexp(0, 127, 200, 17000);
  ~grainCloud.setCutoffHigh(cutoffHigh)
}, page: page);

// rq low:
~ohm2.setLeftKnobFunc(2, 1, { | val |
  var rqLow = val.linlin(0, 127, 1.0, 0.05);
  ~grainCloud.setRQLow(rqLow)
}, page: page);

// rq high:
~ohm2.setLeftKnobFunc(3, 1, { | val |
  var rqHigh = val.linlin(0, 127, 1.0, 0.01);
  ~grainCloud.setRQHigh(rqHigh)
}, page: page);

// pan low:
~ohm2.setLeftKnobFunc(0, 2, { | val |
  var panLow = val.linlin(0, 127, -1.0, 1.0);
  ~grainCloud.setPanLow(panLow)
}, page: page);

// pan high:
~ohm2.setLeftKnobFunc(1, 2, { | val |
  var panHigh = val.linlin(0, 127, -1.0, 1.0);
  ~grainCloud.setPanHigh(panHigh);
}, page: page);

// attack:
~ohm2.setLeftKnobFunc(2, 2, { | val |
  var attack = val.linexp(0, 127, 0.05, 10);
  ~grainCloud.setAttack(attack);
}, page: page);

// release:
~ohm2.setLeftKnobFunc(3, 2, { | val |
  var release = val.linexp(0, 127, 0.05, 20);
  ~grainCloud.setRelease(release);
}, page: page);

