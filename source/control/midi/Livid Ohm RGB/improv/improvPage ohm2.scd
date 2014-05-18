/*
ohm2 improv page
*/

var page = 'improv';


// gendy (not working):
~ohm2.turnGridGreen(0, 0, page: page);
~ohm2.setGridFunc(0, 0, { "gendy not working yet".postln; }, page: page);

// pings (not working):
~ohm2.turnGridGreen(0, 1, page: page);
~ohm2.setGridFunc(0, 1, { "pings not working yet".postln; }, page: page);

// noise synth (not working):
~ohm2.turnGridYellow(0, 2, page: page);
~ohm2.setGridFunc(0, 2, { "noise synth not working yet".postln; }, page: page);

// poppy:
~ohm2.turnGridWhite(0, 3, page: page);
~ohm2.setGridFunc(0, 3, r {
  ~improv.poppy.init;


  // input mute toggle:
  ~ohm2.turnGridGreen(1, 3);
  ~ohm2.setGridFunc(1, 3, r {
    ~improv.poppy.mute;
    ~ohm2.turnGridRed(1, 3).yield;
    ~improv.poppy.unmute;
    ~ohm2.turnGridGreen(1, 3).yield;
  }.loop, page: page);


  // trigger toggle:
  ~ohm2.turnGridRed(0, 4);
  ~ohm2.setGridFunc(0, 4, r {
    ~improv.poppy.makeTrigger;
    ~ohm2.turnGridWhite(0, 4).yield;

    ~improv.poppy.killTrigger;
    ~ohm2.turnGridRed(0, 4).yield;
  }.loop, page: page);

  // reset buffer:
  ~ohm2.turnGridPurple(1, 4);
  ~ohm2.setGridFunc(1, 4, { ~improv.poppy.clearBuffer; });

  // overall volume:
  ~ohm2.setLeftSliderFunc(3, { | val |
    var amp = val.linlin(0, 127, 0, 4.dbamp);
    ~improv.poppy.fader.set(\amp, amp);
  }, page: page);

  // buffer playback volume:
  ~ohm2.setLeftKnobFunc(3, 2, { | val |
    var amp = val.linlin(0, 127, 0, 1);
    ~improv.poppy.playVol = amp;
  }, page: page);

  // trig rate:
  ~ohm2.setLeftKnobFunc(3, 1, { | val |
    var rate = val.linlin(0, 127, 0.0, 3.0);
    ~improv.poppy.changeTrigRate(rate);
  }, page: page);

  // length low:
  ~ohm2.setLeftKnobFunc(1, 1, { | val |
    var length = val.linlin(0, 127, 0.01, 4);
    ~improv.poppy.lengthLo = length;
  }, page: page);

  // length high:
  ~ohm2.setLeftKnobFunc(2, 1, { | val |
    var length = val.linlin(0, 127, 0.5, 5);
    ~improv.poppy.lengthHi = length;
  }, page: page);


  ~ohm2.turnGridGreen(0, 3).yield;

  ~improv.poppy.kill;
  ~ohm2.turnGridOff(1, 3);
  ~ohm2.setGridFunc(1, 3, { });
  ~ohm2.turnGridOff(0, 4);
  ~ohm2.setGridFunc(0, 4, { });
  ~ohm2.turnGridOff(1, 4);
  ~ohm2.setGridFunc(1, 4, { });
  ~ohm2.setLeftSliderFunc(3, { });
  ~ohm2.setLeftKnobFunc(3, 2, { });
  ~ohm2.setLeftKnobFunc(3, 1, { });
  ~ohm2.setLeftKnobFunc(1, 1, { });
  ~ohm2.setLeftKnobFunc(2, 1, { });
  ~ohm2.turnGridRed(0, 3).yield;
}.loop, page: page);


// huge:
~ohm2.turnGridCyan(0, 5, page: page);
~ohm2.setGridFunc(0, 5, r {
  ~improv.huge.init;

  // toggle mute:
  ~ohm2.turnGridGreen(1, 5, page: page);
  ~ohm2.setGridFunc(1, 5, r {
    ~improv.huge.mute;
    ~ohm2.turnGridRed(1, 5).yield;

    ~improv.huge.unmute;
    ~ohm2.turnGridGreen(1, 5).yield;
  }.loop, page: page);

  // go to page:
  ~ohm2.turnGridPurple(2, 5, page: page);
  ~ohm2.setGridFunc(2, 5, { ~page.improv.huge; }, page: page);

  // huge volume:
  ~ohm2.setLeftSliderFunc(2, { | val |
    var amp = val.linlin(0, 127, 0, -4.dbamp);
    ~improv.huge.main.set(\amp, amp);
  }, page: page);

  ~ohm2.turnGridBlue(0, 5, page: page).yield;


  ~improv.huge.kill;
  ~ohm2.turnGridOff(1, 5, page: page);
  ~ohm2.setGridFunc(1, 5, { });
  ~ohm2.turnGridOff(2, 5, page: page);
  ~ohm2.setGridFunc(2, 5, { });
  ~ohm2.turnGridRed(0, 5, page: page).yield;
}.loop, page: page);



~ohm2.turnGridPurple(0, 7, page: page);
  ~ohm2.setGridFunc(0, 7, r {
    loop {
      ~grainCloud = GrainCloud2.new(~mixer.s2, -6.dbamp, 0, ~group.fx, \addToTail);
      ~ohm2.setGridFunc(1, 7, { ~ohm.clearAll; ~ohm2.setPage('grainCloud'); ~ohm.addEssential; });
      ~ohm2.turnGridWhite(1, 7);
      ~ohm2.turnGridGreen(0, 7).yield;

      ~grainCloud.free;
      ~ohm2.setGridFunc(1, 7, { });
      ~ohm2.turnGridOff(1, 7);
      ~ohm2.turnGridRed(0, 7).yield;
    };
  }, page: page);


  ~ohm2.turnGridBlue(4, 0, page: page);
  ~ohm2.setGridFunc(4, 0, r {
    loop {
      ~delayNetwork = DelayNetwork.new(~inst.mic, ~mixer.s3, 0.dbamp, 0, 8, 3, 0.1, 0.5, 45, 55, 0, 3000, 4000, 0, 0, -0.2, 0.2,
        relGroup: ~group.fx, addAction: \addToTail);
      ~ohm2.setGridFunc(5, 0, { ~ohm.clearAll; ~ohm2.setPage('delayNetwork'); ~ohm.addEssential; });
      ~ohm2.turnGridPurple(5, 0);
      ~ohm2.turnGridGreen(4, 0).yield;

      ~delayNetwork.free;
      ~ohm2.setGridFunc(5, 0, { });
      ~ohm2.turnGridOff(5, 0);
      ~ohm2.turnGridRed(4, 0).yield;
    };
  }, page: page);

  ~ohm2.turnGridRed(4, 1, page: page);
  ~ohm2.setGridFunc(4, 1, {
    ~delayNetwork.free;
    ~ohm2.setGridFunc(5, 0, { });
    ~ohm2.turnGridOff(5, 0);
    ~ohm2.turnGridRed(4, 0);
  }, page: page);

  ~ohm2.turnGridWhite(4, 2, page: page);
  ~ohm2.setGridFunc(4, 2, r {
    loop {
      ~fakeGuitar = FakeGuitar.new(~mixer.s1, -6.dbamp, 0, ~group.fx, \addToTail);
      ~ohm2.setGridFunc(5, 2, { ~ohm.clearAll; ~ohm2.setPage('fakeGuitar'); ~ohm.addEssential; });
      ~ohm2.turnGridCyan(5, 2);
      ~ohm2.turnGridGreen(5, 2).yield;

      ~fakeGuitar.free;
      ~ohm2.setGridFunc(5, 2, { });
      ~ohm2.turnGridOff(5, 2);
      ~ohm2.turnGridRed(4, 2).yield;
    }
  }, page: page);

  ~ohm2.turnGridRed(4, 3, page: page);
  ~ohm2.setGridFunc(4, 3, {
    ~fakeGuitar.free;
    ~ohm2.setGridFunc(5, 2, { });
    ~ohm2.turnGridOff(5, 2);
    ~ohm2.turnGridRed(4, 2);
  }, page: page);