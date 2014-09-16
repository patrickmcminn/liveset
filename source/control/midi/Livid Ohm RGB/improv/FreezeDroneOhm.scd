/*
FreezeDroneOhm.scd
*/

var page = 'freezeDrone';
var grainEnvResetFunc, grainRateResetFunc, delayFilterResetFunc;

~ohm2.makePage(page);

////////////////////////
// Left Side ////
////////////////////////

//////// Left Buttons:

// main mute:
~ohm2.turnLeftButtonGreen(3, page: page);
~ohm2.setLeftButtonFunc(3, {
  ~freezeDrone.mixer.tglMute;
  if( ~freezeDrone.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(3); }, { ~ohm2.turnLeftButtonGreen(3); });
}, page: page);

// high drone mute:
~ohm2.turnLeftButtonGreen(2, page: page);
~ohm2.setLeftButtonFunc(2, {
  ~freezeDrone.highFreeze.mixer.tglMute;
  if( ~freezeDrone.highFreeze.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(2); }, { ~ohm2.turnLeftButtonGreen(2); });
}, page: page);

// low drone mute:
~ohm2.turnLeftButtonGreen(1, page: page);
~ohm2.setLeftButtonFunc(1, {
  ~freezeDrone.lowFreeze.mixer.tglMute;
  if( ~freezeDrone.lowFreeze.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(1); }, { ~ohm2.turnLeftButtonGreen(1); });
}, page: page);

//////// Left Sliders:

// main:
~ohm2.setLeftSliderFunc(3, { | val |
  ~freezeDrone.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page);

// high drone:
~ohm2.setLeftSliderFunc(2, { | val |
  ~freezeDrone.highFreeze.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page);

// low drone:
~ohm2.setLeftSliderFunc(1, { | val |
  ~freezeDrone.lowFreeze.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page);

//////// Left Knobs:

//// Delay:

// mix:
~ohm2.setLeftKnobFunc(0, 0, { | val |
  var mix = val.linlin(0, 127, 0, 1);
  ~freezeDrone.granularDelay.setDelayMix(mix);
}, page: page);
//Delay Time:
~ohm2.setLeftKnobFunc(1, 0, { | val |
  var delay = val.linlin(0, 127, 0.05, 4);
  ~freezeDrone.granularDelay.setDelayTime(delay);
}, page: page);
// feedback:
~ohm2.setLeftKnobFunc(2, 0, { | val |
  var feedback = val.linlin(0, 127, 0, 0.95);
  ~freezeDrone.granularDelay.setFeedback(feedback);
}, page: page);
// filter cutoff:
/*
~ohm2.setLeftKnobFunc(3, 0, { | val |
  var cutoff = val.linexp(100, 15000);
  ~freezeDrone.granularDelay.setDelayFilterCutoff(cutoff);
}, page: page);
*/

//// Granulator:
// mix:
~ohm2.setLeftKnobFunc(0, 1, { | val |
  var mix = val.linlin(0, 127, -1, 1);
  ~freezeDrone.granularDelay.setGranulatorCrossfade(mix);
}, page: page);
// grain dur low:
~ohm2.setLeftKnobFunc(1, 1, { | val |
  var durLow = val.linexp(0, 127, 0.005, 1);
  ~freezeDrone.granularDelay.setGrainDurLow(durLow);
}, page: page);
// grain dur high:
~ohm2.setLeftKnobFunc(2, 1, { | val |
  var durHigh = val.linexp(0, 127, 0.01, 2.5);
  ~freezeDrone.granularDelay.setGrainDurHigh(durHigh);
}, page: page);
// trig rate:
~ohm2.setLeftKnobFunc(3, 1, { | val |
  var trigRate = val.linexp(0, 127, 5, 65);
  ~freezeDrone.granularDelay.setTrigRate(trigRate);
}, page: page);

/*
//// Distortion:
// amount:
~ohm2.setLeftKnobFunc(0, 2, { | val |
  var distAmp = val.linlin(0, 127, 1, 1000);
  var postAmp = val.linexp(0, 127, 0.05, 1);
  ~freezeDrone.setDistortionGainAmp(distAmp);
  ~freezeDrone.setDistortionPostAmp(postAmp);
}, page: page);
// cutoff:
~ohm2.setLeftKnobFunc(1, 2, { | val |
  var cutoff = val.linexp(0, 127, 100, 18000);
  ~freezeDrone.setPostDistortionCutoff(cutoff);
}, page: page);
*/

//// Distortion:
// amount:
~ohm2.setLeftKnobFunc(0, 2, { | val |
  var distLow = val.linexp(0, 127, 1, 500);
  var distHigh = val.linexp(0, 127, 1, 250);
  ~freezeDrone.lowFreeze.setDistortion(distLow);
  ~freezeDrone.highFreeze.setDistortion(distHigh);
}, page: page);

// cutoff:
~ohm2.setLeftKnobFunc(1, 2, { | val |
  var cutoffLow = val.linexp(0, 127, 100, 8000);
  var cutoffHigh = val.linexp(0, 127, 200, 16000);
  ~freezeDrone.lowFreeze.setPostDistortionCutoff(cutoffLow);
  ~freezeDrone.highFreeze.setPostDistortionCutoff(cutoffHigh);
}, page: page);

//// Filters:

// low cutoff:
~ohm2.setLeftKnobFunc(2, 2, { | val |
  var cutoff = val.linexp(0, 127, 100, 3000);
  ~freezeDrone.lowFreeze.setLowPassCutoff(cutoff);
}, page: page);

// high cutoff:
~ohm2.setLeftKnobFunc(3, 2, { | val |
  var cutoff = val.linexp(0, 127, 200, 4500);
  ~freezeDrone.highFreeze.setLowPassCutoff(cutoff);
}, page: page);

/////////////////////////
// Grid ///////////
/////////////////////////

// freeze:
~ohm2.turnGridCyan(0, 0, page: page);
~ohm2.setGridFunc(0, 0, {
  ~freezeDrone.freeze;
  ~ohm2.blinkGridPlay(0, 0, 'green', mul: 0.25);
  { ~ohm2.blinkGridStop(0, 0, 'cyan'); }.defer(1.5);
}, page: page);

// release:
~ohm2.turnGridRed(1, 0, page: page);
~ohm2.setGridFunc(1, 0, {
  ~freezeDrone.releaseFreeze;
  ~ohm2.blinkGridPlay(1, 0, 'red', mul: 0.21);
  { ~ohm2.blinkGridStop(1, 0, 'red') }.defer(5);
}, page: page);

//////// rates:
~ohm2.turnGridGreen(0, 1, page: page);
~ohm2.turnGridBlue(1, 1, page: page);
~ohm2.setGridFunc(0, 1, {
  ~ohm2.turnGridGreen(0, 1);
  ~ohm2.turnGridBlue(1, 1);
  ~freezeDrone.highFreeze.setPlayRate(0.5);
}, page: page);
~ohm2.setGridFunc(1, 1, {
  ~ohm2.turnGridGreen(1, 1);
  ~ohm2.turnGridBlue(0, 1);
  ~freezeDrone.highFreeze.setPlayRate(0.75);
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
  ~freezeDrone.granularDelay.setGrainEnvelope('hanning');
}, page: page);
~ohm2.setGridFunc(1, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(1, 2);
  ~freezeDrone.granularDelay.setGrainEnvelope('gabor');
}, page: page);
~ohm2.setGridFunc(2, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(2, 2);
  ~freezeDrone.granularDelay.setGrainEnvelope('gabWide');
}, page: page);
~ohm2.setGridFunc(3, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(3, 2);
  ~freezeDrone.granularDelay.setGrainEnvelope('perc');
}, page: page);
~ohm2.setGridFunc(4, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(4, 2);
  ~freezeDrone.granularDelay.setGrainEnvelope('revPerc');
}, page: page);
~ohm2.setGridFunc(5, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(5, 2);
  ~freezeDrone.granularDelay.setGrainEnvelope('expodec');
}, page: page);
~ohm2.setGridFunc(6, 2, {
  grainEnvResetFunc.value;
  ~ohm2.turnGridGreen(6, 2);
  ~freezeDrone.granularDelay.setGrainEnvelope('rexpodec');
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
  ~freezeDrone.granularDelay.setRate(0.5, 0.5);
}, page: page);
~ohm2.setGridFunc(1, 3, {
  grainRateResetFunc.value;
  ~ohm2.turnGridGreen(1, 3);
  ~freezeDrone.granularDelay.setRate(1, 1);
}, page: page);
~ohm2.setGridFunc(2, 3, {
  grainRateResetFunc.value;
  ~ohm2.turnGridGreen(2, 3);
  ~freezeDrone.granularDelay.setRate(2, 2);
}, page: page);
~ohm2.setGridFunc(3, 3, {
  grainRateResetFunc.value;
  ~ohm2.turnGridGreen(3, 3);
  ~freezeDrone.granularDelay.setRate(4, 4);
}, page: page);
~ohm2.setGridFunc(4, 3, {
  grainRateResetFunc.value;
  ~ohm2.turnGridGreen(4, 3);
  ~freezeDrone.granularDelay.setRate(0.25, 0.75);
}, page: page);
~ohm2.setGridFunc(5, 3, {
  grainRateResetFunc.value;
  ~ohm2.turnGridGreen(5, 3);
  ~freezeDrone.granularDelay.setRate(1, 2);
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
  ~freezeDrone.granularDelay.setDelayFilterType('none');
}, page: page);

// lowpass:
~ohm2.setGridFunc(1, 4, {
  delayFilterResetFunc.value;
  ~ohm2.turnGridGreen(1, 4);
  ~freezeDrone.granularDelay.setDelayFilterType('lowPass');
}, page: page);

// high pass:
~ohm2.setGridFunc(2, 4, {
  delayFilterResetFunc.value;
  ~ohm2.turnGridGreen(2, 4);
  ~freezeDrone.granularDelay.setDelayFilterType('highPass');
}, page: page);

// bandpass:
~ohm2.setGridFunc(3, 4, {
  delayFilterResetFunc.value;
  ~ohm2.turnGridGreen(3, 4);
  ~freezeDrone.granularDelay.setDelayFilterType('bandPass');
}, page: page);
