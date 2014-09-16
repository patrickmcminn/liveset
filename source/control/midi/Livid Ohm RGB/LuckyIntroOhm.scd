/*
FreezeDroneOhm.scd
*/

var page = 'luckyIntro';
var grainEnvResetFunc, grainRateResetFunc, delayFilterResetFunc;
var droneBank = 0;
var arpBank = 1;

~ohm2.makePage(page);
~ohm2.addLeftButtonsBanks(1, page: page);
~ohm2.addLeftSlidersBanks(1, page: page);
~ohm2.addLeftKnobsBanks(1, page: page);

// change banks:
~ohm2.turnCrossfaderButtonBlue(0, page: page);
~ohm2.setCrossfaderButtonFunc(0, r {
  loop {
    ~ohm2.setActiveLeftButtonsBank(arpBank);
    ~ohm2.setActiveLeftSlidersBank(arpBank);
    ~ohm2.setActiveLeftKnobsBank(arpBank);
    ~ohm2.turnCrossfaderButtonWhite(0, page: page).yield;

    ~ohm2.setActiveLeftButtonsBank(droneBank);
    ~ohm2.setActiveLeftSlidersBank(droneBank);
    ~ohm2.setActiveLeftKnobsBank(droneBank);
    ~ohm2.turnCrossfaderButtonBlue(0, page: page).yield;
  }
}, page: page);

// change page:
~ohm2.turnControlButtonYellow(2, 1, page: page);
~ohm2.setControlButtonFunc(2, 1, { ~ohm2.setPage('lucky'); }, page: page);


///////////////////////////////////
///////////////////////////////////
//// Freeze Drone //////
//////////////////////////////////
///////////////////////////////////

////////////////////////
// Left Side ////
////////////////////////

//////// Left Buttons:

// main mute:
~ohm2.turnLeftButtonGreen(3, page: page);
~ohm2.setLeftButtonFunc(3, {
  ~lucky.drone.mixer.tglMute;
  if( ~lucky.drone.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(3); }, { ~ohm2.turnLeftButtonGreen(3); });
}, page: page, bank: droneBank);

// high drone mute:
~ohm2.turnLeftButtonGreen(2, page: page);
~ohm2.setLeftButtonFunc(2, {
  ~lucky.drone.highFreeze.mixer.tglMute;
  if( ~lucky.drone.highFreeze.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(2); }, { ~ohm2.turnLeftButtonGreen(2); });
}, page: page, bank: droneBank);

// low drone mute:
~ohm2.turnLeftButtonGreen(1, page: page);
~ohm2.setLeftButtonFunc(1, {
  ~lucky.drone.lowFreeze.mixer.tglMute;
  if( ~lucky.drone.lowFreeze.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(1); }, { ~ohm2.turnLeftButtonGreen(1); });
}, page: page, bank: droneBank);

//////// Left Sliders:

// main:
~ohm2.setLeftSliderFunc(3, { | val |
  ~lucky.drone.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page, bank: droneBank);

// high drone:
~ohm2.setLeftSliderFunc(2, { | val |
  ~lucky.drone.highFreeze.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page, bank: droneBank);

// low drone:
~ohm2.setLeftSliderFunc(1, { | val |
  ~lucky.drone.lowFreeze.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page, bank: droneBank);

//////// Left Knobs:

//// Delay:

// mix:
~ohm2.setLeftKnobFunc(0, 0, { | val |
  var mix = val.linlin(0, 127, 0, 1);
  ~lucky.drone.granularDelay.setDelayMix(mix);
}, page: page, bank: droneBank);
//Delay Time:
~ohm2.setLeftKnobFunc(1, 0, { | val |
  var delay = val.linlin(0, 127, 0.05, 4);
  ~lucky.drone.granularDelay.setDelayTime(delay);
}, page: page, bank: droneBank);
// feedback:
~ohm2.setLeftKnobFunc(2, 0, { | val |
  var feedback = val.linlin(0, 127, 0, 0.95);
  ~lucky.drone.granularDelay.setFeedback(feedback);
}, page: page, bank: droneBank);
// filter cutoff:
/*
~ohm2.setLeftKnobFunc(3, 0, { | val |
  var cutoff = val.linexp(100, 15000);
  ~lucky.drone.granularDelay.setDelayFilterCutoff(cutoff);
}, page: page);
*/

//// Granulator:
// mix:
~ohm2.setLeftKnobFunc(0, 1, { | val |
  var mix = val.linlin(0, 127, -1, 1);
  ~lucky.drone.granularDelay.setGranulatorCrossfade(mix);
}, page: page, bank: droneBank);
// grain dur low:
~ohm2.setLeftKnobFunc(1, 1, { | val |
  var durLow = val.linexp(0, 127, 0.005, 1);
  ~lucky.drone.granularDelay.setGrainDurLow(durLow);
}, page: page, bank: droneBank);
// grain dur high:
~ohm2.setLeftKnobFunc(2, 1, { | val |
  var durHigh = val.linexp(0, 127, 0.01, 2.5);
  ~lucky.drone.granularDelay.setGrainDurHigh(durHigh);
}, page: page, bank: droneBank);
// trig rate:
~ohm2.setLeftKnobFunc(3, 1, { | val |
  var trigRate = val.linexp(0, 127, 5, 65);
  ~lucky.drone.granularDelay.setTrigRate(trigRate);
}, page: page, bank: droneBank);

/*
//// Distortion:
// amount:
~ohm2.setLeftKnobFunc(0, 2, { | val |
  var distAmp = val.linlin(0, 127, 1, 1000);
  var postAmp = val.linexp(0, 127, 0.05, 1);
  ~lucky.drone.setDistortionGainAmp(distAmp);
  ~lucky.drone.setDistortionPostAmp(postAmp);
}, page: page);
// cutoff:
~ohm2.setLeftKnobFunc(1, 2, { | val |
  var cutoff = val.linexp(0, 127, 100, 18000);
  ~lucky.drone.setPostDistortionCutoff(cutoff);
}, page: page);
*/

//// Distortion:
// amount:
~ohm2.setLeftKnobFunc(0, 2, { | val |
  var distLow = val.linexp(0, 127, 1, 500);
  var distHigh = val.linexp(0, 127, 1, 250);
  ~lucky.drone.lowFreeze.setDistortion(distLow);
  ~lucky.drone.highFreeze.setDistortion(distHigh);
}, page: page, bank: droneBank);

// cutoff:
~ohm2.setLeftKnobFunc(1, 2, { | val |
  var cutoffLow = val.linexp(0, 127, 100, 8000);
  var cutoffHigh = val.linexp(0, 127, 200, 16000);
  ~lucky.drone.lowFreeze.setPostDistortionCutoff(cutoffLow);
  ~lucky.drone.highFreeze.setPostDistortionCutoff(cutoffHigh);
}, page: page, bank: droneBank);

//// Filters:

// low cutoff:
~ohm2.setLeftKnobFunc(2, 2, { | val |
  var cutoff = val.linexp(0, 127, 100, 3000);
  ~lucky.drone.lowFreeze.setLowPassCutoff(cutoff);
}, page: page, bank: droneBank);

// high cutoff:
~ohm2.setLeftKnobFunc(3, 2, { | val |
  var cutoff = val.linexp(0, 127, 200, 4500);
  ~lucky.drone.highFreeze.setLowPassCutoff(cutoff);
}, page: page, bank: droneBank);

/////////////////////////
// Grid ///////////
/////////////////////////

// freeze:
~ohm2.turnGridCyan(0, 0, page: page);
~ohm2.setGridFunc(0, 0, {
  ~lucky.drone.freeze;
  ~ohm2.blinkGridPlay(0, 0, 'green', mul: 0.25);
  { ~ohm2.blinkGridStop(0, 0, 'cyan'); }.defer(1.5);
}, page: page);

// release:
~ohm2.turnGridRed(1, 0, page: page);
~ohm2.setGridFunc(1, 0, {
  ~lucky.drone.releaseFreeze;
  ~ohm2.blinkGridPlay(1, 0, 'red', mul: 0.21);
  { ~ohm2.blinkGridStop(1, 0, 'red') }.defer(5);
}, page: page);

//////// rates:
~ohm2.turnGridGreen(0, 1, page: page);
~ohm2.turnGridBlue(1, 1, page: page);
~ohm2.setGridFunc(0, 1, {
  ~ohm2.turnGridGreen(0, 1);
  ~ohm2.turnGridBlue(1, 1);
  ~lucky.drone.highFreeze.setPlayRate(0.5);
}, page: page);
~ohm2.setGridFunc(1, 1, {
  ~ohm2.turnGridGreen(1, 1);
  ~ohm2.turnGridBlue(0, 1);
  ~lucky.drone.highFreeze.setPlayRate(0.75);
}, page: page);

//////// granular:

// envelopes:
grainEnvResetFunc = {
  7.do({ | i | ~ohm2.turnGridBlue(i, 2, page: page); });
};
grainEnvResetFunc.value;
~ohm2.turnGridGreen(0, 2, page: page);
~ohm2.setGridFunc(0, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(0, 2);
  ~lucky.drone.granularDelay.setGrainEnvelope('hanning');
}, page: page);
~ohm2.setGridFunc(1, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(1, 2);
  ~lucky.drone.granularDelay.setGrainEnvelope('gabor');
}, page: page);
~ohm2.setGridFunc(2, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(2, 2);
  ~lucky.drone.granularDelay.setGrainEnvelope('gabWide');
}, page: page);
~ohm2.setGridFunc(3, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(3, 2);
  ~lucky.drone.granularDelay.setGrainEnvelope('perc');
}, page: page);
~ohm2.setGridFunc(4, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(4, 2);
  ~lucky.drone.granularDelay.setGrainEnvelope('revPerc');
}, page: page);
~ohm2.setGridFunc(5, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(5, 2);
  ~lucky.drone.granularDelay.setGrainEnvelope('expodec');
}, page: page);
~ohm2.setGridFunc(6, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(6, 2);
  ~lucky.drone.granularDelay.setGrainEnvelope('rexpodec');
}, page: page);

// play rates:
grainRateResetFunc = {
  6.do({ | i | ~ohm2.turnGridCyan(i, 3, page: page); });
};
grainRateResetFunc.value;
~ohm2.turnGridGreen(1, 3, page: page);

~ohm2.setGridFunc(0, 3, {
  grainRateResetFunc.value;
  ~ohm2.turnGridGreen(0, 3);
  ~lucky.drone.granularDelay.setRate(0.5, 0.5);
}, page: page);
~ohm2.setGridFunc(1, 3, {
  grainRateResetFunc.value;
  ~ohm2.turnGridGreen(1, 3);
  ~lucky.drone.granularDelay.setRate(1, 1);
}, page: page);
~ohm2.setGridFunc(2, 3, {
  grainRateResetFunc.value;
  ~ohm2.turnGridGreen(2, 3);
  ~lucky.drone.granularDelay.setRate(2, 2);
}, page: page);
~ohm2.setGridFunc(3, 3, {
  grainRateResetFunc.value;
  ~ohm2.turnGridGreen(3, 3);
  ~lucky.drone.granularDelay.setRate(4, 4);
}, page: page);
~ohm2.setGridFunc(4, 3, {
  grainRateResetFunc.value;
  ~ohm2.turnGridGreen(4, 3);
  ~lucky.drone.granularDelay.setRate(0.25, 0.75);
}, page: page);
~ohm2.setGridFunc(5, 3, {
  grainRateResetFunc.value;
  ~ohm2.turnGridGreen(5, 3);
  ~lucky.drone.granularDelay.setRate(1, 2);
}, page: page);

//////// delay:
// filter type:
delayFilterResetFunc = {
  4.do({ | i | ~ohm2.turnGridPurple(i, 4, page: page); });
};
delayFilterResetFunc.value;
~ohm2.turnGridGreen(0, 4, page: page);

// none:
~ohm2.setGridFunc(0, 4, {
  delayFilterResetFunc.value;
  ~ohm2.turnGridGreen(0, 4);
  ~lucky.drone.granularDelay.setDelayFilterType('none');
}, page: page);

// lowpass:
~ohm2.setGridFunc(1, 4, {
  delayFilterResetFunc.value;
  ~ohm2.turnGridGreen(1, 4);
  ~lucky.drone.granularDelay.setDelayFilterType('lowPass');
}, page: page);

// high pass:
~ohm2.setGridFunc(2, 4, {
  delayFilterResetFunc.value;
  ~ohm2.turnGridGreen(2, 4);
  ~lucky.drone.granularDelay.setDelayFilterType('highPass');
}, page: page);

// bandpass:
~ohm2.setGridFunc(3, 4, {
  delayFilterResetFunc.value;
  ~ohm2.turnGridGreen(3, 4);
  ~lucky.drone.granularDelay.setDelayFilterType('bandPass');
}, page: page);


///////////////////////////////////
//// Trumpet Arp ///////
///////////////////////////////////

///////////////////////////////////
// Left Side //
///////////////////////////////////

// volume/track active:
~ohm2.turnLeftButtonGreen(3, page: page, bank: arpBank);
~ohm2.setLeftButtonFunc(3, {
  ~lucky.trumpetSequencer.mixer.tglMute;
  if( ~lucky.trumpetSequencer.mixer.masterChan.isMuted,
    { ~ohm2.turnLeftButtonRed(3); },
    { ~ohm2.turnLeftButtonGreen(3); }
  );
}, page: page, bank: arpBank);

~ohm2.setLeftSliderFunc(3, { | val |
  ~lucky.trumpetSequencer.mixer.setVol(val.ccdbfs(-70, 6));
}, page: page, bank: arpBank);

// sends sliders:
3.do({ | i | ~ohm2.setLeftKnobFunc(3, i, { | val |
  ~lucky.trumpetSequencer.mixer.setSendVol(i, val.ccdbfs(-70, 0));
  }, page: page, bank: arpBank);
});

//// parameters:

~ohm2.setLeftKnobFunc(0, 0, { | val |
  var dist = val.linexp(0, 127, 1, 1000);
  ~lucky.trumpetSequencer.setDistortion(dist);
}, page: page, bank: arpBank);
~ohm2.setLeftKnobFunc(1, 0, { | val |
  var cutoff = val.linexp(0, 127, 100, 18000);
  ~lucky.trumpetSequencer.setCutoff(cutoff);
}, page: page, bank: arpBank);
~ohm2.setLeftKnobFunc(2, 0, { | val |
  var cutoff = val.linexp(0, 127, 100, 18000);
  ~lucky.trumpetSequencer.setPostDistortionCutoff(cutoff);
}, page: page, bank: arpBank);
~ohm2.setLeftKnobFunc(2, 1, { | val |
  var boost = val.linlin(-6, 6);
  ~lucky.trumpetSequencer.setHighBoost(boost);
}, page: page, bank: arpBank);


///////////////////////////////////
//////////// Grid /////////////
///////////////////////////////////

// start the sequences:
~ohm2.turnGridWhite(0, 6, page: page);
~ohm2.setGridFunc(0, 6, r {
  loop {
    ~lucky.trumpetSequencer.shiftSequencer.playSequence(\luckyFirstArp, ~lucky.tempoClock);
    ~lucky.trumpetSequencer.shiftSequencer.playSequence(\luckySecondArp, ~lucky.tempoClock);
    ~lucky.trumpetSequencer.shiftSequencer.playSequence(\luckyThirdArp, ~lucky.tempoClock);
    ~lucky.trumpetSequencer.shiftSequencer.playSequence(\luckyFourthArp, ~lucky.tempoClock);
    ~ohm2.turnGridGreen(0, 6).yield;

    ~lucky.trumpetSequencer.shiftSequencer.stopSequence(\luckyFirstArp);
    ~lucky.trumpetSequencer.shiftSequencer.stopSequence(\luckySecondArp);
    ~lucky.trumpetSequencer.shiftSequencer.stopSequence(\luckyThirdArp);
    ~lucky.trumpetSequencer.shiftSequencer.stopSequence(\luckyFourthArp);
    ~ohm2.turnGridRed(0, 6).yield;
  }
}, page: page);

// first arp vol:
~ohm2.turnGridBlue(1, 6, page: page);
~ohm2.setGridFunc(1, 6, r{
  loop {
    ~lucky.trumpetSequencer.shiftSequencer.addKey(\luckyFirstArp, \amp, 0);
    ~ohm2.turnGridRed(1, 6).yield;

    ~lucky.trumpetSequencer.shiftSequencer.addKey(\luckyFirstArp, \amp, 1);
    ~ohm2.turnGridBlue(1, 6).yield;
  }
}, page: page);

// second arp vol:
~ohm2.turnGridRed(2, 6, page: page);
~ohm2.setGridFunc(2, 6, r{
  loop {
    ~lucky.trumpetSequencer.shiftSequencer.addKey(\luckySecondArp, \amp, 1);
    ~ohm2.turnGridCyan(2, 6).yield;

    ~lucky.trumpetSequencer.shiftSequencer.addKey(\luckySecondArp, \amp, 0);
    ~ohm2.turnGridRed(2, 6).yield;
  }
}, page: page);

// third arp vol:
~ohm2.turnGridRed(3, 6, page: page);
~ohm2.setGridFunc(3, 6, r{
  loop {
    ~lucky.trumpetSequencer.shiftSequencer.addKey(\luckyThirdArp, \amp, 1);
    ~ohm2.turnGridPurple(3, 6).yield;

    ~lucky.trumpetSequencer.shiftSequencer.addKey(\luckyThirdArp, \amp, 0);
    ~ohm2.turnGridRed(3, 6).yield;
  }
}, page: page);

// fourth arp vol:
~ohm2.turnGridRed(4, 6, page: page);
~ohm2.setGridFunc(4, 6, r{
  loop {
    ~lucky.trumpetSequencer.shiftSequencer.addKey(\luckyFourthArp, \amp, 0.2);
    ~ohm2.turnGridYellow(4, 6).yield;

    ~lucky.trumpetSequencer.shiftSequencer.addKey(\luckyFourthArp, \amp, 0);
    ~ohm2.turnGridRed(4, 6).yield;
  }
}, page: page);

// second sequence phasing!
~ohm2.turnGridWhite(5, 6, page: page);
~ohm2.setGridFunc(5, 6, {
  ~lucky.trumpetSequencer.shiftSequencer.addKey(\luckySecondArp, \dur, 1/5.9);
}, page: page);

// freeze/release:
~ohm2.turnGridBlue(0, 7, page: page);
~ohm2.setGridFunc(0, 7, {
  if( ~lucky.arpFreeze.freezeActive,
    { ~lucky.arpFreeze.releaseFreeze; ~ohm2.turnGridRed(0, 7); },
    { ~lucky.arpFreeze.freeze; ~ohm2.turnGridGreen(0, 7); });
}, page: page);

// normal rate:
~ohm2.turnGridGreen(1, 7, page: page);
~ohm2.setGridFunc(1, 7, {
  ~lucky.arpFreeze.setPlayRate(1);
  ~ohm2.turnGridGreen(1, 7);
  ~ohm2.turnGridCyan(2, 7);
}, page: page);

// up a M2:
~ohm2.turnGridCyan(2, 7, page: page);
~ohm2.setGridFunc(2, 7, {
  ~lucky.arpFreeze.setPlayRate(9/8);
  ~ohm2.turnGridGreen(2, 7);
  ~ohm2.turnGridCyan(1, 7);
}, page: page);

