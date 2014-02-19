/*
Wednesday, Feburary 19th 2014
delayNetworkOhm.scd
prm
*/

var page = 'delayNetwork';
var passiveBank = 0;
var triggerBank = 1;

var delayTimeLow, delayTimeHigh, decayTimeLow, decayTimeHigh;
var cutoffLow, cutoffHigh, resLow, resHigh, panLow, panHigh;
var pitchShiftArray;
var rampTime;

delayTimeLow = 0.1;
delayTimeHigh = 0.5;
decayTimeLow = 45;
decayTimeHigh = 55;
cutoffLow = 3000;
cutoffHigh = 5000;
resLow = 0;
resHigh = 0;
panLow = -0.2;
panHigh = 0.2;
pitchShiftArray = Array.fill(1, { 0 });
rampTime = 3;

//~ohm.makePage(page);
~ohm2.addLeftKnobsBanks(1, page: page);

// Randomize:
~ohm2.turnGridCyan(0, 0, page: page);
~ohm2.turnGridPurple(1, 0, page: page);
~ohm2.turnGridBlue(0, 1, page: page);
~ohm2.turnGridYellow(1, 1, page: page);
~ohm2.turnGridWhite(2, 1, page: page);

~ohm2.setGridFunc(0, 0, { ~delayNetwork.randomizeDelayTime(delayTimeLow, delayTimeHigh); }, page: page);
~ohm2.setGridFunc(1, 0, { ~delayNetwork.randomizeDecayTime(decayTimeLow, decayTimeHigh); }, page: page);
~ohm2.setGridFunc(0, 1, { ~delayNetwork.randomizeCutoff(cutoffLow, cutoffHigh); }, page: page);
~ohm2.setGridFunc(1, 1, { ~delayNetwork.randomizeRes(resLow, resHigh); }, page: page);
~ohm2.setGridFunc(2, 1, { ~delayNetwork.randomizePan(panLow, panHigh); }, page: page);

// bank changing:
~ohm2.turnGridRed(0, 3, page: page);
~ohm2.setGridFunc(0, 3, r {
  loop {
    ~ohm2.setActiveLeftKnobsBank(triggerBank);
    ~ohm2.turnGridGreen(0, 3).yield;

    ~ohm2.setActiveLeftKnobsBank(passiveBank);
    ~ohm2.turnGridRed(0, 3).yield;
  };
}, page: page);

// fade out:
~ohm2.turnCrossfaderButtonYellow(0, page: page);
~ohm2.setCrossfaderButtonFunc(0, { ~delayNetwork.fadeOutDelays(rampTime); }, page: page);

// ramp time:
~ohm2.setCrossfaderFunc({ | val |
  var time = val.linlin(0, 127, 0.1, 10);
  rampTime = time;
}, page: page);

// pitchShifting:

6.do({ | row | 4.do({ | column | ~ohm2.turnGridPurple(column + 4, row, page: page)}); });
~ohm2.turnGridWhite(4, 6, page: page);



// presets:
3.do({ | i | ~ohm2.turnGridYellow(i, 4, page: page); });
3.do({ | i | ~ohm2.turnGridYellow(i, 5, page: page); });
3.do({ | i | ~ohm2.turnGridYellow(i, 6, page: page); });

// preset 1:
~ohm2.setGridFunc(0, 4, {
  delayTimeLow = 0.1;
  delayTimeHigh = 0.5;
  decayTimeLow = 45;
  decayTimeHigh = 55;
  cutoffLow = 3000;
  cutoffHigh = 5000;
  resLow = 0;
  resHigh = 0;
  panLow = -0.2;
  panHigh = 0.2;
  pitchShiftArray = Array.fill(1, { 0 });
  ~delayNetwork.randomizeDelayTime(delayTimeLow, delayTimeHigh);
  ~delayNetwork.randomizeDecayTime(decayTimeLow, decayTimeHigh);
  ~delayNetwork.randomizeCutoff(cutoffLow, cutoffHigh);
  ~delayNetwork.randomizeRes(resLow, resHigh);
  ~delayNetwork.randomizePan(panLow, panHigh);
  ~delayNetwork.setPitchShiftArray(pitchShiftArray);
  3.do({ | i | ~ohm2.turnGridYellow(i, 4); });
  3.do({ | i | ~ohm2.turnGridYellow(i, 5); });
  3.do({ | i | ~ohm2.turnGridYellow(i, 6); });
  ~ohm2.turnGridGreen(0, 4);
}, page: page);



// Input Select:

~ohm2.turnGridBlue(0, 7, page: page);
~ohm2.turnGridGreen(1, 7, page: page);

// Mute:

~ohm2.setGridFunc(0, 7, {
  ~delayNetwork.setInBus(~inst.mute);
  ~ohm2.turnGridGreen(0, 7);
  ~ohm2.turnGridBlue(1, 7);
}, page: page);

// Mic:
~ohm2.setGridFunc(1, 7, {
  ~delayNetwork.setInBus(~inst.mic);
  ~ohm2.turnGridBlue(0, 7);
  ~ohm2.turnGridGreen(1, 7);
}, page: page);


// sliders:
~ohm2.setLeftSliderFunc(3, { | val |
  var amp = val.linlin(0, 127, 0, 3.dbamp);
  ~delayNetwork.setAmp(amp);
}, page: page);



// knobs:

// passive bank:

// delayTimeLow:
~ohm2.setLeftKnobFunc(0, 0, { | val |
  var delayTime = val.linlin(0, 127, 0.005, 3);
  delayTimeLow = delayTime;
}, bank: passiveBank, page: page);

// delayTimeHigh:
~ohm2.setLeftKnobFunc(1, 0, { | val |
  var delayTime = val.linlin(0, 127, 0.01, 3);
  delayTimeHigh = delayTime;
}, bank: passiveBank, page: page);

// decayTimeLow:
~ohm2.setLeftKnobFunc(2, 0, { | val |
  var decayTime = val.linexp(0, 127, 1, 60);
  decayTimeLow = decayTime;
}, bank: passiveBank, page: page);

// decayTimeHigh:

~ohm2.setLeftKnobFunc(3, 0, { | val |
  var decayTime = val.linexp(0, 127, 1, 90);
  decayTimeHigh = decayTime;
}, bank: passiveBank, page: page);

// cutoffLow:

~ohm2.setLeftKnobFunc(0, 1, { | val |
  var cutoff = val.linexp(0, 127, 200, 10000);
  cutoffLow = cutoff;
}, bank: passiveBank, page: page);

// cutoffHigh:

~ohm2.setLeftKnobFunc(1, 1, { | val |
  var cutoff = val.linexp(0, 127, 200, 10000);
  cutoffHigh = cutoff;
}, bank: passiveBank, page: page);

// resLow:

~ohm2.setLeftKnobFunc(2, 1, { | val |
  var res = val.linlin(0, 127, 0, 1);
  resLow = res;
}, bank: passiveBank, page: page);

// resHigh:

~ohm2.setLeftKnobFunc(3, 1, { | val |
  var res = val.linlin(0, 127, 0, 1);
  resHigh = res;
}, bank: passiveBank, page: page);

// panLow:

~ohm2.setLeftKnobFunc(0, 2, { | val |
  var pan = val.linlin(0, 127, -1, 1);
  panLow = pan;
}, bank: passiveBank, page: page);

// panHigh:

~ohm2.setLeftKnobFunc(1, 2, { | val |
  var pan = val.linlin(0, 127, -1, 1);
  panHigh = pan;
}, bank: passiveBank, page: page);

// trigger bank:

// delayTimeLow:
~ohm2.setLeftKnobFunc(0, 0, { | val |
  var delayTime = val.linlin(0, 127, 0.005, 3);
  delayTimeLow = delayTime;
   ~delayNetwork.randomizeDelayTime(delayTimeLow, delayTimeHigh);
}, bank: triggerBank, page: page);

// delayTimeHigh:
~ohm2.setLeftKnobFunc(1, 0, { | val |
  var delayTime = val.linlin(0, 127, 0.01, 3);
  delayTimeHigh = delayTime;
   ~delayNetwork.randomizeDelayTime(delayTimeLow, delayTimeHigh);
}, bank: triggerBank, page: page);

// decayTimeLow:
~ohm2.setLeftKnobFunc(2, 0, { | val |
  var decayTime = val.linexp(0, 127, 1, 60);
  decayTimeLow = decayTime;
  ~delayNetwork.randomizeDecayTime(decayTimeLow, decayTimeHigh);
}, bank: triggerBank, page: page);

// decayTimeHigh:

~ohm2.setLeftKnobFunc(3, 0, { | val |
  var decayTime = val.linexp(0, 127, 1, 90);
  decayTimeHigh = decayTime;
  ~delayNetwork.randomizeDecayTime(decayTimeLow, decayTimeHigh);
}, bank: triggerBank, page: page);

// cutoffLow:

~ohm2.setLeftKnobFunc(0, 1, { | val |
  var cutoff = val.linexp(0, 127, 200, 10000);
  cutoffLow = cutoff;
  ~delayNetwork.randomizeCutoff(cutoffLow, cutoffHigh);
}, bank: triggerBank, page: page);

// cutoffHigh:

~ohm2.setLeftKnobFunc(1, 1, { | val |
  var cutoff = val.linexp(0, 127, 200, 10000);
  cutoffHigh = cutoff;
  ~delayNetwork.randomizeCutoff(cutoffLow, cutoffHigh);
}, bank: triggerBank, page: page);

// resLow:

~ohm2.setLeftKnobFunc(2, 1, { | val |
  var res = val.linlin(0, 127, 0, 1);
  resLow = res;
  ~delayNetwork.randomizeRes(resLow, resHigh);
}, bank: triggerBank, page: page);

// resHigh:

~ohm2.setLeftKnobFunc(3, 1, { | val |
  var res = val.linlin(0, 127, 0, 1);
  resHigh = res;
  ~delayNetwork.randomizeRes(resLow, resHigh);
}, bank: triggerBank, page: page);

// panLow:

~ohm2.setLeftKnobFunc(0, 2, { | val |
  var pan = val.linlin(0, 127, -1, 1);
  panLow = pan;
  ~delayNetwork.randomizePan(panLow, panHigh);
}, bank: triggerBank, page: page);

// panHigh:

~ohm2.setLeftKnobFunc(1, 2, { | val |
  var pan = val.linlin(0, 127, -1, 1);
  panHigh = pan;
  ~delayNetwork.randomizePan(panLow, panHigh);
}, bank: triggerBank, page: page);

