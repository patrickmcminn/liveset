/*
Monday, January 14th 2013
amplitudeFollow.scd
prm
*/

SynthDef(\amplitudeFollow, {
	| in, out, attackTime = 0.01, releaseTime = 0.01 |
	var input, amplitude, sig;
	input = In.ar(in);
	amplitude = A2K.kr(Amplitude.ar(input, attackTime, releaseTime));
	sig = Out.kr(out, amplitude);
}).add;


SynthDef(\amplitudeOutStereo, {
  | inBus, attackTime = 0.01, releaseTime = 0.01, trigRate = 10, ampMul = 5 |
  var input, amplitudeLeft, amplitudeRight, oscLeft, oscRight;
  input = In.ar(inBus, 2);
  amplitudeLeft = A2K.kr(Amplitude.ar(input[0], attackTime, releaseTime));
  amplitudeLeft = amplitudeLeft * ampMul;
  //amplitudeLeft.poll;
  amplitudeRight = A2K.kr(Amplitude.ar(input[1], attackTime, releaseTime));
  amplitudeRight = amplitudeRight * ampMul;
  //amplitudeRight.poll;
  oscLeft = SendReply.kr(Impulse.kr(trigRate), '/masterAmpLeft', amplitudeLeft, 1);
  oscRight = SendReply.kr(Impulse.kr(trigRate), '/masterAmpRight', amplitudeRight, 1);
}).add;

