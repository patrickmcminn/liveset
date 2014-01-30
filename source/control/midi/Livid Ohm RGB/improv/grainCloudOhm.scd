/*
Tuesday, January 21st 2013
grainCloudOhm.scd
prm
*/

var page = 'grainCloud';
var octave1 = [[0, 7], [1, 6], [1, 7], [2, 6], [2, 7], [3, 7], [4, 6], [4, 7], [5, 6], [5, 7], [6, 6], [6, 7]];
var octave2 = octave1 - [[0, 2]];
var octave3 = octave2 - [[0, 2]];
var octave4 = octave3 - [[0, 2]];


octave1.do({ | item | ~ohm2.turnGridBlue(item[0], item[1], page: page); });
octave2.do({ | item | ~ohm2.turnGridCyan(item[0], item[1], page: page); });
octave3.do({ | item | ~ohm2.turnGridPurple(item[0], item[1], page: page); });
octave4.do({ | item | ~ohm2.turnGridYellow(item[0], item[1], page: page); });

octave1.do({ | item, index  |
  var note = index;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.noteArray.includes(note),
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridBlue(item[0], item[1]); }
    );
  }, page: page);
});

octave2.do({ | item, index  |
  var note = index + 12;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.noteArray.includes(note),
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridCyan(item[0], item[1]); }
    );
  }, page: page);
});

octave3.do({ | item, index  |
  var note = index + 24;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.noteArray.includes(note),
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridPurple(item[0], item[1]); }
    );
  }, page: page);
});

octave4.do({ | item, index  |
  var note = index + 36;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~grainCloud.toggleNote(note);
    if( ~grainCloud.noteArray.includes(note),
      { ~ohm2.turnGridGreen(item[0], item[1]); },
      { ~ohm2.turnGridYellow(item[0], item[1]); }
    );
  }, page: page);
});


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
  var trigRateLow = val.linexp(0, 127, 1, 700);
  ~grainCloud.setTrigRateLow(trigRateLow);
}, page: page);

// trig rate high:
~ohm2.setLeftKnobFunc(1, 0, { | val |
  var trigRateHigh = val.linexp(0, 127, 1, 1000);
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



/*
~improvOhm.grainCloud = (

  // improv page function nums:
  main: 7,
  page: 15,
  pageFunc: nil,

  spawn: { | self |
    if( try { ~improv.grainCloud.noteArray; }.isNil, { self.init; }, { self.kill });
    self;
  },

  init: { | self |
    ~improv.grainCloud = GrainCloud.new;
    self.makeButtons;
    self;
  },

  kill: { | self |
    ~improv.grainCloud.free;
    self.killButtons;
    self;
  },

  makeButtons: { | self |
    self.topOhm(1);
    self.makePage;
  },

  killButtons: { | self |
    self.topOhm(0);
    self.killPage;
  },

  topOhm: { | self, val |
    if ( val == 1,
      {
        ~ohm.turnGreen(self.main);
        ~restoreOhm.improv.page.put(self.main, \green);
      },
      {
        ~ohm.turnRed(self.main);
        ~restoreOhm.improv.page.put(self.main, \red);
      }
    );
  },

  makePage: { | self |
    ~ohm.turnPurple(self.page);
    ~restoreOhm.improv.page.put(self.page, \purple);
    self.pageFunc = MIDIFunc({ ~page.improv.grainCloud.top; }, self.page);
  },

  killPage: { | self |
    ~ohm.turnOff(self.page);
    ~restoreOhm.improv.page.put(self.page, \off);
    self.pageFunc.free;
  },

);
*/