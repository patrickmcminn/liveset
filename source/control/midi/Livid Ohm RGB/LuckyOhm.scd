var page = 'lucky';
var instBank = 0;
var returnsBank = 1;
var synthBank = 2;
var synth2Bank = 3;

var resetBankFunc, osc1OctaveResetFunc, osc2OctaveResetFunc;

var octShiftRoutine;

~ohm2.makePage(page);

~ohm2.addLeftButtonsBanks(3, page: page);
~ohm2.addLeftSlidersBanks(3, page: page);
~ohm2.addLeftKnobsBanks(3, page: page);

// intro page:
~ohm2.turnControlButtonYellow(2, 1, page: page);
~ohm2.setControlButtonFunc(2, 1, {~ohm2.setPage('luckyIntro'); }, page: page);

//////// Left side:

//////////////////////////////
//////// instBank: //////
//////////////////////////////

//// Buttons:
// initial button state:
4.do({ | i | ~ohm2.turnLeftButtonGreen(i, page: page, bank: instBank); });

~ohm2.setLeftButtonFunc(0, {
  ~lucky.melodySubtractive.mixer.tglMute;
  if( ~lucky.melodySubtractive.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(0); }, { ~ohm2.turnLeftButtonGreen(0); });
}, page: page, bank: instBank);
~ohm2.setLeftButtonFunc(1, {
  ~lucky.fakeGuitar.mixer.tglMute;
  if( ~lucky.basslineSubtractive.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(1); }, { ~ohm2.turnLeftButtonGreen(1); });
}, page: page, bank: instBank);
~ohm2.setLeftButtonFunc(2, {
  ~lucky.nebula.mixer.tglMute;
  if( ~lucky.nebula.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(2); }, { ~ohm2.turnLeftButtonGreen(2); });
}, page: page, bank: instBank);
~ohm2.setLeftButtonFunc(3, {
  ~lucky.tptIn.tglMute;
  if( ~lucky.tptIn.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(3); }, { ~ohm2.turnLeftButtonGreen(3); });
}, page: page, bank: instBank);

//// Sliders:
~ohm2.setLeftSliderFunc(0, { | val |
  ~lucky.melodySubtractive.mixer.setVol(val.ccdbfs(-140, 0));
}, page: page, bank: instBank);
~ohm2.setLeftSliderFunc(1, { | val |
  ~lucky.fakeGuitar.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page, bank: instBank);
~ohm2.setLeftSliderFunc(2, { | val |
  ~lucky.nebula.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page, bank: instBank);
~ohm2.setLeftSliderFunc(3, { | val |
  ~lucky.tptIn.setVol(val.ccdbfs(-70, 0));
}, page: page, bank: instBank);

//// Sends (knobs):

// melody sub:
3.do({ | i |
  ~ohm2.setLeftKnobFunc(0, i, { | val |
    ~lucky.melodySubtractive.mixer.setSendVol(i, val.ccdbfs(-70, 6));
  }, page: page, bank: instBank);
});
// bass sub:
3.do({ | i |
  ~ohm2.setLeftKnobFunc(1, i, { | val |
    ~lucky.fakeGuitar.mixer.setSendVol(i, val.ccdbfs(-70, 6));
  }, page: page, bank: instBank);
});
// nebula:
3.do({ | i |
  ~ohm2.setLeftKnobFunc(2, i, { | val |
    ~lucky.nebula.mixer.setSendVol(i, val.ccdbfs(-70, 6));
  }, page: page, bank: instBank);
});
// tpt:
3.do({ | i |
  ~ohm2.setLeftKnobFunc(3, i, { | val |
    ~lucky.tptIn.setSendVol(i, val.ccdbfs(-70, 6));
  }, page: page, bank: instBank);
});

//////////////////////////////
//////// returnsBank:
//////////////////////////////

///// Buttons:
3.do({ | i | ~ohm2.turnLeftButtonGreen(i, page: page, bank: returnsBank); });

~ohm2.setLeftButtonFunc(0, {
  ~lucky.granulator.mixer.tglMute;
  if( ~lucky.granulator.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(0); }, { ~ohm2.turnLeftButtonGreen(0); });
}, page: page, bank: returnsBank);
~ohm2.setLeftButtonFunc(1, {
  ~lucky.reverb.mixer.tglMute;
  if( ~lucky.reverb.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(1); }, { ~ohm2.turnLeftButtonGreen(1); });
}, page: page, bank: returnsBank);
~ohm2.setLeftButtonFunc(2, {
  ~lucky.poppy.mixer.tglMute;
  if( ~lucky.poppy.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(2); }, { ~ohm2.turnLeftButtonGreen(2); });
}, page: page, bank: returnsBank);

//// Sliders:
~ohm2.setLeftSliderFunc(0, { | val |
  ~lucky.granulator.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page, bank: returnsBank);
~ohm2.setLeftSliderFunc(1, { | val |
  ~lucky.reverb.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page, bank: returnsBank);
~ohm2.setLeftSliderFunc(2, { | val |
  ~lucky.poppy.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page, bank: returnsBank);

//// Send Knobs:

// poppy:
2.do({ | i |
  ~ohm2.setLeftKnobFunc(2, i + 1, { | val |
    ~lucky.poppy.mixer.setSendVol(i, val.ccdbfs(-70, 6));
  }, page: page, bank: returnsBank);
});

//////////////////////////////
//////// Synth 1 Bank
//////////////////////////////

//////// Buttons:
~ohm2.turnLeftButtonGreen(0, page: page, bank: synthBank);
~ohm2.turnLeftButtonGreen(3, page: page, bank: synthBank);
~ohm2.setLeftButtonFunc(0, {
  ~lucky.melodySubtractive.mixer.tglMute;
  if( ~lucky.melodySubtractive.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(0); }, { ~ohm2.turnLeftButtonGreen(0); });
}, page: page, bank: synthBank);
~ohm2.setLeftButtonFunc(3, {
  ~lucky.basslineSubtractive.mixer.tglMute;
  if( ~lucky.melodySubtractive.mixer.masterChan.isMuted, { ~ohm2.turnLeftButtonRed(3); }, { ~ohm2.turnLeftButtonGreen(3); });
}, page: page, bank: synthBank);

///////// Sliders:
~ohm2.setLeftSliderFunc(0, { | val |
  ~lucky.melodySubtractive.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page, bank: synthBank);
~ohm2.setLeftSliderFunc(1, { | val |
  ~lucky.melodySubtractive.setOsc1SubVol(val.ccdbfs(-70, 0));
}, page: page, bank: synthBank);
~ohm2.setLeftSliderFunc(2, { | val |
  ~lucky.melodySubtractive.setOsc2SubVol(val.ccdbfs(-70, 0));
}, page: page, bank: synthBank);
~ohm2.setLeftSliderFunc(3, { | val |
  ~lucky.basslineSubtractive.mixer.setVol(val.ccdbfs(-70, 0));
}, page: page, bank: synthBank);

//////// Knobs:
3.do({ | i |
  ~ohm2.setLeftKnobFunc(0, i, { | val |
    ~lucky.melodySubtractive.mixer.setSendVol(i, val.ccdbfs(-70, 6));
  }, page: page, bank: synthBank);
});

// cutoff:
~ohm2.setLeftKnobFunc(3, 2, { | val |
  var cutoff = val.linexp(0, 127, 100, 18000);
  ~lucky.melodySubtractive.setFilterCutoff(cutoff);
}, page: page, bank: synthBank);

// noise osc vol:
~ohm2.setLeftKnobFunc(2, 2, { | val |
  ~lucky.melodySubtractive.setNoiseOscVol(val.ccdbfs(-70, 6));
}, page: page, bank: synthBank);
// filter drive:
~ohm2.setLeftKnobFunc(2, 1, { | val |
  var drive = val.linexp(0, 127, 1, 1000);
  ~lucky.melodySubtractive.setFilterDrive(drive);
}, page: page, bank: synthBank);

//////////////////////////////
//////// Synth 2 Bank
//////////////////////////////

//////// Buttons:

///////// Sliders:

//////// Knobs:



//////////////////////////////
//////// Grid: ///////////
//////////////////////////////

//////// Initial Fade In:
~ohm2.turnGridWhite(7, 7, page: page);
~ohm2.setGridFunc(7, 7, { { ~lucky.melodySubtractive.mixer.fade(-6, 30); }.defer(30);
}, 'noteOn', page: page);


//////// Poppy:
// trigger:
~ohm2.turnGridRed(0, 1, page: page);
~ohm2.setGridFunc(0, 1, {
  ~lucky.poppy.toggleTrigger;
  if( ~lucky.poppy.isTriggering == true, { ~ohm2.turnGridBlue(0, 1); }, { ~ohm2.turnGridRed(0, 1); });
}, page: page);

// input active/mute:
~ohm2.turnGridGreen(1, 1, page: page);
~ohm2.setGridFunc(1, 1, {
  ~lucky.poppy.toggleMuteInput;
  if( ~lucky.poppy.inputIsMuted == true, { ~ohm2.turnGridRed(1, 1); }, { ~ohm2.turnGridGreen(1, 1); });
}, page: page);

// buffer clear:
~ohm2.turnGridWhite(2, 1, page: page);
~ohm2.setGridFunc(2, 1, { ~lucky.poppy.clearBuffer; }, page: page);

//////// Sequences

~ohm2.turnGridBlue(0, 0, page: page);
~ohm2.setGridFunc(0, 0, {
  if( ~lucky.isIntroPlaying == false,
    {
      ~lucky.playIntroSequence;
      ~lucky.setMelodySubtractiveIntroPreset;
      ~ohm2.turnGridGreen(0, 0);
    },
    {
      ~lucky.stopIntroSequence;
      ~ohm2.turnGridRed(0, 0);
  });
}, page: page);

~ohm2.turnGridCyan(1, 0, page: page);
~ohm2.setGridFunc(1, 0, {
  if( ~lucky.introVersion == "short",
    {
      ~lucky.setIntroSequenceLong;
      ~ohm2.turnGridPurple(1, 0);
    },
    {
      ~lucky.setIntroSequenceShort;
      ~ohm2.turnGridCyan(1, 0);
  });
}, page: page);

~ohm2.turnGridPurple(2, 0, page: page);
~ohm2.setGridFunc(2, 0, {
  if( ~lucky.isSection1Playing == false,
    {
      ~lucky.playSection1Sequence;
      ~lucky.setMelodySubtractiveSection1Preset;
      ~ohm2.turnGridGreen(2, 0);
    },
    {
      ~lucky.stopSection1Sequence;
      ~ohm2.turnGridRed(2, 0);
      ~lucky.setMelodySubtractiveBreakPreset;
  });
}, page: page);

~ohm2.turnGridYellow(3, 0, page: page);
~ohm2.setGridFunc(3, 0, {
  if( ~lucky.isBreakPlaying == false,
    {
      ~lucky.playBreakSequence;
      ~ohm2.turnGridGreen(3, 0);
    },
    {
      ~lucky.stopBreakSequence;
      ~ohm2.turnGridRed(3, 0);
  });
}, page: page);

~ohm2.turnGridWhite(4, 0, page: page);
~ohm2.setGridFunc(4, 0, {
  if( ~lucky.isSection2Playing == false,
    {
      ~lucky.playSection2Sequence;
      ~lucky.setMelodySubtractiveSection2Preset;
      ~ohm2.turnGridGreen(4, 0);
    },
    {
      ~lucky.stopSection2Sequence;
      ~ohm2.turnGridRed(4, 0);
  });
}, page: page);

~ohm2.turnGridBlue(5, 0, page: page);
~ohm2.setGridFunc(5, 0, {
  if( ~lucky.isOutPlaying == false,
    {
      ~lucky.playOutSection;
      ~ohm2.turnGridGreen(5, 0);
    },
    {
      ~lucky.stopOutSection;
      ~ohm2.turnGridRed(5, 0);
  });
}, page: page);


//////// Octave Shift:

octShiftRoutine = r {
  loop {
    ~lucky.melodySubtractive.setOsc2Octave([6, 6, 5, 5, 5, 4, 4, 4, 3, 2].choose);
    switch(~lucky.melodySubtractive.osc2OctaveMul,
      { 0.5 }, { osc2OctaveResetFunc.value; ~ohm2.turnGridGreen(5, 5, page: page); },
      { 1 },  { osc2OctaveResetFunc.value;  ~ohm2.turnGridGreen(6, 5, page: page); },
      { 2 }, { osc2OctaveResetFunc.value; ~ohm2.turnGridGreen(4, 6, page: page); },
      { 3 }, { osc2OctaveResetFunc.value; ~ohm2.turnGridGreen(5, 6, page: page); },
      { 4 }, { osc2OctaveResetFunc.value; ~ohm2.turnGridGreen(6, 6, page: page); }
    );
    rrand(0.05, 0.15).wait;
  };
};

~ohm2.turnGridWhite(7, 0, page: page);
~ohm2.setGridFunc(7, 0, r {
  loop {
    octShiftRoutine.reset;
    octShiftRoutine.play;
    ~ohm2.turnGridGreen(7, 0).yield;

    octShiftRoutine.stop;
    ~ohm2.turnGridRed(7, 0).yield;
  }
}, page: page);


//////// Subtractive Bassline:
4.do({ | i | ~ohm2.turnGridCyan(i, 3, page: page); });

~ohm2.setGridFunc(0, 3, {
  ~lucky.basslineSubtractive.playNote(72.midicps);
  ~ohm2.turnGridGreen(0, 3);
}, 'noteOn', page: page);
~ohm2.setGridFunc(0, 3, {
  ~lucky.basslineSubtractive.releaseNote(72.midicps);
  ~ohm2.turnGridCyan(0, 3);
}, 'noteOff', page: page);

~ohm2.setGridFunc(1, 3, {
  ~lucky.basslineSubtractive.playNote(73.midicps);
  ~ohm2.turnGridGreen(1, 3);
}, 'noteOn', page: page);
~ohm2.setGridFunc(1, 3, {
  ~lucky.basslineSubtractive.releaseNote(73.midicps);
  ~ohm2.turnGridCyan(1, 3);
}, 'noteOff', page: page);

~ohm2.setGridFunc(2, 3, {
  ~lucky.basslineSubtractive.playNote(75.midicps);
  ~ohm2.turnGridGreen(2, 3);
}, 'noteOn', page: page);
~ohm2.setGridFunc(2, 3, {
  ~lucky.basslineSubtractive.releaseNote(75.midicps);
  ~ohm2.turnGridCyan(2, 3);
}, 'noteOff', page: page);

~ohm2.setGridFunc(3, 3, {
  ~lucky.basslineSubtractive.playNote(77.midicps);
  ~ohm2.turnGridGreen(3, 3);
}, 'noteOn', page: page);
~ohm2.setGridFunc(3, 3, {
  ~lucky.basslineSubtractive.releaseNote(77.midicps);
  ~ohm2.turnGridCyan(3, 3);
}, 'noteOff', page: page);



//////// Osc 1 Octave
osc1OctaveResetFunc =  {
  ~ohm2.turnGridCyan(0, 5, page: page);
  ~ohm2.turnGridCyan(1, 5, page: page);
  ~ohm2.turnGridCyan(2, 5, page: page);
  ~ohm2.turnGridCyan(0, 6, page: page);
  ~ohm2.turnGridCyan(1, 6, page: page);
  ~ohm2.turnGridCyan(2, 6, page: page);
};

osc1OctaveResetFunc.value;
~ohm2.turnGridGreen(2, 5, page: page);

~ohm2.setGridFunc(0, 5, {
  ~lucky.melodySubtractive.setOsc1Octave(1);
  osc1OctaveResetFunc.value;
  ~ohm2.turnGridGreen(0, 5);
}, page: page);
~ohm2.setGridFunc(1, 5, {
  ~lucky.melodySubtractive.setOsc1Octave(2);
  osc1OctaveResetFunc.value;
  ~ohm2.turnGridGreen(1, 5);
}, page: page);
~ohm2.setGridFunc(2, 5, {
  ~lucky.melodySubtractive.setOsc1Octave(3);
  osc1OctaveResetFunc.value;
  ~ohm2.turnGridGreen(2, 5);
}, page: page);
~ohm2.setGridFunc(0, 6, {
  ~lucky.melodySubtractive.setOsc1Octave(4);
  osc1OctaveResetFunc.value;
  ~ohm2.turnGridGreen(0, 6);
}, page: page);
~ohm2.setGridFunc(1, 6, {
  ~lucky.melodySubtractive.setOsc1Octave(5);
  osc1OctaveResetFunc.value;
  ~ohm2.turnGridGreen(1, 6);
}, page: page);
~ohm2.setGridFunc(2, 6, {
  ~lucky.melodySubtractive.setOsc1Octave(6);
  osc1OctaveResetFunc.value;
  ~ohm2.turnGridGreen(2, 6);
}, page: page);

//////// Osc 2 Octave:
osc2OctaveResetFunc =  {
  ~ohm2.turnGridBlue(4, 5, page: page);
  ~ohm2.turnGridBlue(5, 5, page: page);
  ~ohm2.turnGridBlue(6, 5, page: page);
  ~ohm2.turnGridBlue(4, 6, page: page);
  ~ohm2.turnGridBlue(5, 6, page: page);
  ~ohm2.turnGridBlue(6, 6, page: page);
};
osc2OctaveResetFunc.value;
~ohm2.turnGridGreen(5, 5, page: page);
~ohm2.setGridFunc(4, 5, {
  ~lucky.melodySubtractive.setOsc2Octave(1);
  osc2OctaveResetFunc.value;
  ~ohm2.turnGridGreen(4, 5);
}, page: page);
~ohm2.setGridFunc(5, 5, {
  ~lucky.melodySubtractive.setOsc2Octave(2);
  osc2OctaveResetFunc.value;
  ~ohm2.turnGridGreen(5, 5);
}, page: page);
~ohm2.setGridFunc(6, 5, {
  ~lucky.melodySubtractive.setOsc2Octave(3);
  osc2OctaveResetFunc.value;
  ~ohm2.turnGridGreen(6, 5);
}, page: page);
~ohm2.setGridFunc(4, 6, {
  ~lucky.melodySubtractive.setOsc2Octave(4);
  osc2OctaveResetFunc.value;
  ~ohm2.turnGridGreen(4, 6);
}, page: page);
~ohm2.setGridFunc(5, 6, {
  ~lucky.melodySubtractive.setOsc2Octave(5);
  osc2OctaveResetFunc.value;
  ~ohm2.turnGridGreen(5, 6);
}, page: page);
~ohm2.setGridFunc(6, 6, {
  ~lucky.melodySubtractive.setOsc2Octave(6);
  osc2OctaveResetFunc.value;
  ~ohm2.turnGridGreen(6, 6);
}, page: page);

//// Bank Changing:
resetBankFunc = {
  ~ohm2.turnGridBlue(0, 7, page: page);
  ~ohm2.turnGridCyan(1, 7, page: page);
  ~ohm2.turnGridYellow(2, 7, page: page);
  ~ohm2.turnGridWhite(3, 7, page: page);
};
resetBankFunc.value;
~ohm2.turnGridGreen(0, 7, page: page);

~ohm2.setGridFunc(0, 7, {
  ~ohm2.setActiveLeftButtonsBank(instBank, page: page);
  ~ohm2.setActiveLeftSlidersBank(instBank, page: page);
  ~ohm2.setActiveLeftKnobsBank(instBank, page: page);
  resetBankFunc.value;
  ~ohm2.turnGridGreen(0, 7);
}, page: page);
~ohm2.setGridFunc(1, 7, {
  ~ohm2.setActiveLeftButtonsBank(returnsBank, page: page);
  ~ohm2.setActiveLeftSlidersBank(returnsBank, page: page);
  ~ohm2.setActiveLeftKnobsBank(returnsBank, page: page);
  resetBankFunc.value;
  ~ohm2.turnGridGreen(1, 7);
}, page: page);
~ohm2.setGridFunc(2, 7, {
  ~ohm2.setActiveLeftButtonsBank(synthBank, page: page);
  ~ohm2.setActiveLeftSlidersBank(synthBank, page: page);
  ~ohm2.setActiveLeftKnobsBank(synthBank, page: page);
  resetBankFunc.value;
  ~ohm2.turnGridGreen(2, 7);
}, page: page);
~ohm2.setGridFunc(3, 7, {
  ~ohm2.setActiveLeftButtonsBank(synth2Bank, page: page);
  ~ohm2.setActiveLeftSlidersBank(synth2Bank, page: page);
  ~ohm2.setActiveLeftKnobsBank(synth2Bank, page: page);
  resetBankFunc.value;
  ~ohm2.turnGridGreen(3, 7);
}, page: page);

//////// LFO 1 Waveform:
