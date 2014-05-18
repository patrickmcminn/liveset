/*
Friday, May 9th 2014
QuartzComposer.scd
hacky ass shit for controlling qc over osc
*/

//~mixer[\ampFollow] = Bus.audio(s, 2);
~mixerSynth[\ampFollow] = Synth(\amplitudeOutStereo, [\inBus, 0], addAction: \addToTail);
//~mixerSynth[\ampFollow].free;

OSCdef(\quartzComposerLeft, { | msg |
  var id, amp;
  id = msg.at(1);
  amp = msg.at(3);
  ~quartzComposer.sendMsg(\amplitudeLeft, (1-amp));
}, \masterAmpLeft);

OSCdef(\quartzComposerRight, { | msg |
  var id, amp;
  id = msg.at(1);
  amp = msg.at(3);
  ~quartzComposer.sendMsg(\amplitudeRight, (1-amp));
}, \masterAmpRight);

    