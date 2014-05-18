/*
Sunday, May 11 2014
FakeGuitarOhm.scd
prm
*/

var page = 'fakeGuitar';
var chordBank = 0;
var keyboardBank = 1;
var octave1 = [[0, 7], [1, 6], [1, 7], [2, 6], [2, 7], [3, 7], [4, 6], [4, 7], [5, 6], [5, 7], [6, 6], [6, 7]];
var octave2 = octave1 - [[0, 2]];
var octave3 = octave2 - [[0, 2]];
var octave4 = octave3 - [[0, 2]];

~ohm2.addGridBanks(1, page: page);

// bank switch:
~ohm2.turnCrossfaderButtonBlue(0, page: page);
~ohm2.setCrossfaderButtonFunc(0, r {
  loop {
    ~ohm2.setActiveGridBank(keyboardBank);
    ~ohm2.turnCrossfaderButtonWhite(0).yield;

    ~ohm2.setActiveGridBank(chordBank);
    ~ohm2.turnCrossfaderButtonBlue(0).yield;
  }
}, page: page);

// chord bank:

~ohm2.turnGridGreen(0, 0, page: page, bank: chordBank);
~ohm2.setGridFunc(0, 0, {
  ~fakeGuitar.setFilterType(0);
  ~ohm2.turnGridGreen(0, 0);
  ~ohm2.turnGridYellow(1, 0);
  ~ohm2.turnGridWhite(2, 0);
}, page: page, bank: chordBank);

~ohm2.turnGridYellow(1, 0, page: page, bank: chordBank);
~ohm2.setGridFunc(1, 0, {
  ~fakeGuitar.setFilterType(1);
  ~ohm2.turnGridGreen(1, 0);
  ~ohm2.turnGridBlue(0, 0);
  ~ohm2.turnGridWhite(2, 0);
}, page: page, bank: chordBank);

~ohm2.turnGridWhite(2, 0, page: page, bank: chordBank);
~ohm2.setGridFunc(2, 0, {
  ~fakeGuitar.setFilterType(2);
  ~ohm2.turnGridGreen(2, 0);
  ~ohm2.turnGridBlue(0, 0);
  ~ohm2.turnGridYellow(1, 0);
}, page: page, bank: chordBank);

~ohm2.turnGridWhite(0, 4, page: page, bank: chordBank);
~ohm2.setGridFunc(0, 4, {
  ~ohm2.turnGridGreen(0, 4);
  ~fakeGuitar.playNote(36.midicps);
  ~fakeGuitar.playNote(37.midicps);
  ~fakeGuitar.playNote(38.midicps);
  ~fakeGuitar.playNote(41.midicps);
  ~fakeGuitar.playNote(43.midicps);
  ~fakeGuitar.playNote(46.midicps);
}, type: 'noteOn', page: page, bank: chordBank);
~ohm2.setGridFunc(0, 4, {
  ~ohm2.turnGridWhite(0, 4);
  ~fakeGuitar.releaseNote(36.midicps);
  ~fakeGuitar.releaseNote(37.midicps);
  ~fakeGuitar.releaseNote(38.midicps);
  ~fakeGuitar.releaseNote(41.midicps);
  ~fakeGuitar.releaseNote(43.midicps);
  ~fakeGuitar.releaseNote(46.midicps);
}, type: 'noteOff', page: page, bank: chordBank);


~ohm2.turnGridBlue(1, 4, page: page, bank: chordBank);
~ohm2.setGridFunc(1, 4, {
  ~ohm2.turnGridGreen(1, 4);
  ~fakeGuitar.playNote(36.midicps);
  ~fakeGuitar.playNote(37.midicps);
  ~fakeGuitar.playNote(43.midicps);
  ~fakeGuitar.playNote(46.midicps);
  ~fakeGuitar.playNote(48.midicps);
  ~fakeGuitar.playNote(49.midicps);
  ~fakeGuitar.playNote(56.midicps);
}, type: 'noteOn', page: page, bank: chordBank);
~ohm2.setGridFunc(1, 4, {
  ~ohm2.turnGridBlue(1, 4);
  ~fakeGuitar.releaseNote(36.midicps);
  ~fakeGuitar.releaseNote(37.midicps);
  ~fakeGuitar.releaseNote(43.midicps);
  ~fakeGuitar.releaseNote(46.midicps);
  ~fakeGuitar.releaseNote(48.midicps);
  ~fakeGuitar.releaseNote(49.midicps);
  ~fakeGuitar.releaseNote(56.midicps);
}, type: 'noteOff', page: page, bank: chordBank);


~ohm2.turnGridPurple(2, 4, page: page, bank: chordBank);
~ohm2.setGridFunc(2, 4, {
  ~ohm2.turnGridGreen(2, 4);
  ~fakeGuitar.playNote(28.midicps);
  ~fakeGuitar.playNote(35.midicps);
  ~fakeGuitar.playNote(41.midicps);
  ~fakeGuitar.playNote(48.midicps);
  ~fakeGuitar.playNote(52.midicps);
  ~fakeGuitar.playNote(56.midicps);
}, type: 'noteOn', page: page, bank: chordBank);
~ohm2.setGridFunc(2, 4, {
  ~fakeGuitar.releaseNote(28.midicps);
  ~fakeGuitar.releaseNote(35.midicps);
  ~fakeGuitar.releaseNote(41.midicps);
  ~fakeGuitar.releaseNote(48.midicps);
  ~fakeGuitar.releaseNote(52.midicps);
  ~fakeGuitar.releaseNote(56.midicps);
  ~ohm2.turnGridPurple(2, 4);
}, type: 'noteOff', page: page, bank: chordBank);

~ohm2.turnGridYellow(3, 4, page: page, bank: chordBank);
~ohm2.setGridFunc(3, 4, {
  ~ohm2.turnGridGreen(3, 4);
  ~fakeGuitar.playNote(120.midicps);
  ~fakeGuitar.playNote(122.midicps);
  ~fakeGuitar.playNote(117.midicps);
  ~fakeGuitar.playNote(36.midicps, 0.5);
  ~fakeGuitar.playNote(96.midicps);
  ~fakeGuitar.playNote(110.midicps);
  ~fakeGuitar.playNote(24.midicps, 0.1);
}, type: 'noteOn', page: page, bank: chordBank);
~ohm2.setGridFunc(3, 4, {
  ~fakeGuitar.releaseNote(120.midicps);
  ~fakeGuitar.releaseNote(122.midicps);
  ~fakeGuitar.releaseNote(117.midicps);
  ~fakeGuitar.releaseNote(36.midicps);
  ~fakeGuitar.releaseNote(96.midicps);
  ~fakeGuitar.releaseNote(110.midicps);
  ~fakeGuitar.releaseNote(24.midicps);
  ~ohm2.turnGridYellow(3, 4);
}, type: 'noteOff', page: page, bank: chordBank);

// keyboard bank:

octave1.do({ | item | ~ohm2.turnGridBlue(item[0], item[1], page: page, bank: keyboardBank); });
octave2.do({ | item | ~ohm2.turnGridCyan(item[0], item[1], page: page, bank: keyboardBank); });
octave3.do({ | item | ~ohm2.turnGridPurple(item[0], item[1], page: page, bank: keyboardBank); });
octave4.do({ | item | ~ohm2.turnGridYellow(item[0], item[1], page: page, bank: keyboardBank); });

octave1.do({ | item, index |
  var note = index + 24;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~fakeGuitar.playNote(note.midicps);
    ~ohm2.turnGridGreen(item[0], item[1]);
  }, type: 'noteOn', page: page, bank: keyboardBank);
  ~ohm2.setGridFunc(item[0], item[1], {
    ~fakeGuitar.releaseNote(note.midicps);
    ~ohm2.turnGridBlue(item[0], item[1]);
  }, type: 'noteOff', page: page, bank: keyboardBank);
});

octave2.do({ | item, index |
  var note = index + 36;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~fakeGuitar.playNote(note.midicps);
    ~ohm2.turnGridGreen(item[0], item[1]);
  }, type: 'noteOn', page: page, bank: keyboardBank);
  ~ohm2.setGridFunc(item[0], item[1], {
    ~fakeGuitar.releaseNote(note.midicps);
    ~ohm2.turnGridCyan(item[0], item[1]);
  }, type: 'noteOff', page: page, bank: keyboardBank);
});

octave3.do({ | item, index |
  var note = index + 48;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~fakeGuitar.playNote(note.midicps);
    ~ohm2.turnGridGreen(item[0], item[1]);
  }, type: 'noteOn', page: page, bank: keyboardBank);
  ~ohm2.setGridFunc(item[0], item[1], {
    ~fakeGuitar.releaseNote(note.midicps);
    ~ohm2.turnGridPurple(item[0], item[1]);
  }, type: 'noteOff', page: page, bank: keyboardBank);
});

octave4.do({ | item, index |
  var note = index + 60;
  ~ohm2.setGridFunc(item[0], item[1], {
    ~fakeGuitar.playNote(note.midicps);
    ~ohm2.turnGridGreen(item[0], item[1]);
  }, type: 'noteOn', page: page, bank: keyboardBank);
  ~ohm2.setGridFunc(item[0], item[1], {
    ~fakeGuitar.releaseNote(note.midicps);
    ~ohm2.turnGridYellow(item[0], item[1]);
  }, type: 'noteOff', page: page, bank: keyboardBank);
});

// control:


// volume:
~ohm2.setLeftSliderFunc(3, { | val |
  var amp = val.linlin(0, 127, 0, 1);
  ~fakeGuitar.setAmp(amp);
}, page: page);

// attack:
~ohm2.setLeftKnobFunc(2, 0, { | val |
  var attack = val.linexp(0, 127, 0.05, 10);
  ~fakeGuitar.setAttack(attack);
}, page: page);

// release:
~ohm2.setLeftKnobFunc(3, 0, { | val |
  var release = val.linexp(0, 127, 0.05, 15);
  ~fakeGuitar.setRelease(release);
}, page: page);

// cutoff:
~ohm2.setLeftKnobFunc(0, 0, { | val |
  var cutoff = val.linexp(0, 127, 100, 7500);
  ~fakeGuitar.setCutoff(cutoff);
}, page: page);

// rq:
~ohm2.setLeftKnobFunc(1, 0, { | val |
  var rq = val.linlin(0, 127, 1, 0);
  ~fakeGuitar.setRQ(rq);
}, page: page);

// waveloss
~ohm2.setLeftKnobFunc(3, 1, { | val |
  var loss = val.linlin(0, 127, 0, 95);
  ~fakeGuitar.setWaveLossAmount(loss);
}, page: page);
