SynthDef(\multiTrem, {

	|
	in = 0, out, amp = 1,
	tremOneFreq = 1, tremOneDepth = 1, tremOneWave = 0,
	tremTwoFreq = 2, tremTwoDepth = 1, tremTwoWave = 0,
	tremThreeFreq = 3, tremThreeDepth = 1, tremThreeWave = 0,
	tremFourFreq = 4, tremFourDepth = 1, tremFourWave = 0
	|

	var input;
	var waveOneSine, waveOneSaw, waveOneSquare, waveOneNoise, waveOneScale, waveOne;
	var waveTwoSine, waveTwoSaw, waveTwoSquare, waveTwoNoise, waveTwoScale, waveTwo;
	var waveThreeSine, waveThreeSaw, waveThreeSquare, waveThreeNoise, waveThreeScale, waveThree;
	var waveFourSine, waveFourSaw, waveFourSquare, waveFourNoise, waveFourScale, waveFour;
	var sum, sig;

	input = In.ar(in);

	waveOneScale = (1-tremOneDepth);
	waveOneSine = SinOsc.ar(tremOneFreq);
	waveOneSaw = Saw.ar(tremOneFreq);
	waveOneSquare = Pulse.ar(tremOneFreq);
	waveOneNoise = LFNoise0.ar(tremOneFreq);
	waveOne = SelectX.ar(tremOneWave, [waveOneSine, waveOneSaw, waveOneSquare, waveOneNoise]);
	waveOne = waveOne * tremOneDepth;
	waveOne = waveOne + waveOneScale;
	waveOne = waveOne * 0.25;

	waveTwoScale = (1-tremTwoDepth);
	waveTwoSine = SinOsc.ar(tremTwoFreq);
	waveTwoSaw = Saw.ar(tremTwoFreq);
	waveTwoSquare = Pulse.ar(tremTwoFreq);
	waveTwoNoise = LFNoise0.ar(tremTwoFreq);
	waveTwo = SelectX.ar(tremTwoWave, [waveTwoSine, waveTwoSaw, waveTwoSquare, waveTwoNoise]);
	waveTwo = waveTwo * tremTwoDepth;
	waveTwo = waveTwo + waveTwoScale;
	waveTwo = waveTwo * 0.25;

	waveThreeScale = (1-tremThreeDepth);
	waveThreeSine = SinOsc.ar(tremThreeFreq);
	waveThreeSaw = Saw.ar(tremThreeFreq);
	waveThreeSquare = Pulse.ar(tremThreeFreq);
	waveThreeNoise = LFNoise0.ar(tremThreeFreq);
	waveThree = SelectX.ar(tremThreeWave, [waveThreeSine, waveThreeSaw, waveThreeSquare, waveThreeNoise]);
	waveThree = waveOne * tremThreeDepth;
	waveThree = waveThree + waveThreeScale;
	waveThree = waveOne * 0.25;

	waveFourScale = (1-tremFourDepth);
	waveFourSine = SinOsc.ar(tremFourFreq);
	waveFourSaw = Saw.ar(tremFourFreq);
	waveFourSquare = Pulse.ar(tremFourFreq);
	waveFourNoise = LFNoise0.ar(tremFourFreq);
	waveFour = SelectX.ar(tremFourWave, [waveFourSine, waveFourSaw, waveFourSquare, waveFourNoise]);
	waveFour = waveFour * tremFourDepth;
	waveFour = waveFour + waveFourScale;
	waveFour = waveFour * 0.25;

	sum = waveOne + waveTwo + waveThree + waveFour;
	sum = input * sum;

	sig = sum * amp;
	sig = Out.ar(out, sig);
}).add;

"multiTrem SyntDef Added".postln;
"".postln;
