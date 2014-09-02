var pitchShiftColorReset;
var page = 'nebula';
var shiftAmount = 0;

var cutoffShiftRate = 10;
var cutoffLow = 700;
var cutoffHigh = 2500;
var cutoffShiftRoutine;


// only if not made/active already:

// (uncomment if new Ohm is needed)
//~ohm2 = OhmRGB.new;

~ohm2.makePage(page);
//~ohm2.setPage(page);

//~nebula = TrumpetNebula.new(0);

(
//////// Left Buttons:
~ohm2.turnLeftButtonGreen(3, page: page);
~ohm2.setLeftButtonFunc(3, {
  ~nebula.toggleMuteInput;
  if( ~nebula.inputIsMuted, { ~ohm2.turnLeftButtonRed(3); }, { ~ohm2.turnLeftButtonGreen(3); });
}, page: page);

////// Left Sliders:
// overall volume:
~ohm2.setLeftSliderFunc(3, { | val |
  ~nebula.setVol(0, val.ccdbfs(-70, 0), 0.1);
}, page: page);

// Left Delay:
~ohm2.setLeftSliderFunc(0, { | val |
  var delayTime = val.linlin(0, 127, 0.05, 2);
  ~nebula.setLeftDelayTime(delayTime);
}, page: page);

// Right Delay:
~ohm2.setLeftSliderFunc(1, { | val |
  var delayTime = val.linlin(0, 127, 0.05, 2);
  ~nebula.setRightDelayTime(delayTime);
}, page: page);

// Feedback:
~ohm2.setLeftSliderFunc(2, { | val |
  var feedback = val.linlin(0, 127, 0, 1.2);
  ~nebula.setFeedback(feedback);
}, page: page);

////// Left Knobs:

//// Bottom Row:

// Delay Center Freq:
~ohm2.setLeftKnobFunc(0, 2, { | val |
  var freq = val.linexp(0, 127, 200, 3000);
  ~nebula.setDelayFilterCenterFreq(freq);
}, page: page);

// Delay BW:
~ohm2.setLeftKnobFunc(1, 2, { | val |
  var bw = val.linlin(0, 127, 8, 1);
  ~nebula.setDelayFilterBW(bw);
}, page: page);

// Delay Vol:
~ohm2.setLeftKnobFunc(2, 2, { | val |
  ~nebula.setDelayVol(val.ccdbfs(-70, 12));
}, page: page);

// Cutoff:
~ohm2.setLeftKnobFunc(3, 2, { | val |
  var cutoff = val.linexp(0, 127, 300, 16000);
  ~nebula.setCutoff(cutoff);
}, page: page);

//// Middle Row:

// Distortion Amount:
~ohm2.setLeftKnobFunc(0, 1, { | val |
  var distAmt = val.linlin(0, 127, 1, 500);
  ~nebula.setDistortionAmount(distAmt);
  ~nebula.setDistortionGain(val.ccdbfs(0, -18));
}, page: page);

// Post-Distortion Cutoff:
~ohm2.setLeftKnobFunc(1, 1, { | val |
  var cutoff = val.linexp(0, 127, 300, 10000);
  ~nebula.setPostDistortionCutoff(cutoff);
}, page: page);

// Reverb Mix:
~ohm2.setLeftKnobFunc(2, 1, { | val |
  var mix = val.linlin(0, 127, 0, 1);
  ~nebula.setReverbMix(mix);
}, page: page);

// Reverb Room:
~ohm2.setLeftKnobFunc(3, 1, { | val |
  var room = val.linlin(0, 127, 0, 1);
  ~nebula.setReverbRoom(room);
}, page: page);

//// Top Row:

// Low Gain:
~ohm2.setLeftKnobFunc(0, 0, { | val |
  ~nebula.setLowGain(val.ccdbfs(-12, 12));
}, page: page);

// High Gain:
~ohm2.setLeftKnobFunc(1, 0, { | val |
  ~nebula.setHighGain(val.ccdbfs(-12, 12));
}, page: page);

// Nebula Activity:
~ohm2.setLeftButtonFunc(2, 0, { | val |
  var activity = val.linlin(0, 127, 0, 100);
  ~nebula.setNebulaActivity(activity);
}, page: page);

// Nebula Depth:
~ohm2.setLeftButtonFunc(3, 0, { | val |
  var depth = val.linlin(0, 127, 0, 100);
  ~nebula.setNebulaDepth(depth);
}, page: page);


////// Grid:

//// Pitch Shifting:

pitchShiftColorReset = {
  ~ohm2.turnGridBlue(0, 0, page: page);
  ~ohm2.turnGridBlue(1, 0, page: page);
  ~ohm2.turnGridBlue(2, 0, page: page);
  ~ohm2.turnGridBlue(3, 0, page: page);
  ~ohm2.turnGridBlue(4, 0, page: page);
  ~ohm2.turnGridCyan(0, 1, page: page);
  ~ohm2.turnGridWhite(1, 1, page: page);
};

pitchShiftColorReset.value;
~ohm2.turnGridGreen(2, 0, page: page);

// 15vb:
~ohm2.setGridFunc(0, 0, {
  pitchShiftColorReset.value;
  ~ohm2.turnGridGreen(0, 0);
  shiftAmount = -24;
  ~nebula.setPitchShiftAmount(shiftAmount);
}, page: page);

// 8vb:
~ohm2.setGridFunc(1, 0, {
  pitchShiftColorReset.value;
  ~ohm2.turnGridGreen(1, 0);
  shiftAmount = -12;
  ~nebula.setPitchShiftAmount(shiftAmount);
}, page: page);

// 0:
~ohm2.setGridFunc(2, 0, {
  pitchShiftColorReset.value;
  ~ohm2.turnGridGreen(2, 0);
  shiftAmount = 0;
  ~nebula.setPitchShiftAmount(shiftAmount);
}, page: page);

// 8va:
~ohm2.setGridFunc(3, 0, {
  pitchShiftColorReset.value;
  ~ohm2.turnGridGreen(3, 0);
  shiftAmount = 12;
  ~nebula.setPitchShiftAmount(shiftAmount);
}, page: page);

// 15ma:
~ohm2.setGridFunc(4, 0, {
  pitchShiftColorReset.value;
  ~ohm2.turnGridGreen(4, 0);
  shiftAmount = 24;
  ~nebula.setPitchShiftAmount(shiftAmount);
}, page: page);

// -1:
~ohm2.setGridFunc(0, 1, {
  ~ohm2.turnGridYellow(0, 1);
  shiftAmount = shiftAmount - 1;
  ~nebula.setPitchShiftAmount(shiftAmount);
}, page: page);

// +1:
~ohm2.setGridFunc(1, 1, {
  ~ohm2.turnGridYellow(1, 1);
  shiftAmount = shiftAmount + 1;
  ~nebula.setPitchShiftAmount(shiftAmount);
}, page: page);


// cutoff shift routine:
cutoffShiftRoutine = r {
  loop {
    ~nebula.setPostDistortionCutoff(exprand(cutoffLow, cutoffHigh));
    (1/cutoffShiftRate).wait;
  }
};

~ohm2.turnGridCyan(0, 4, page: page);
~ohm2.setGridFunc(0, 4, r {
  loop {
    cutoffShiftRoutine.reset.play;
    ~ohm2.turnGridGreen(0, 4).yield;

    cutoffShiftRoutine.stop;
    ~ohm2.turnGridRed(0, 4).yield;
  };
}, page: page);

)