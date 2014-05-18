/*
Tuesday, July 16th 2013
huge.scd
prm
*/

(
SynthDef(\huge, {
	|
	in, out, amp = 0.5, dist = 1000, cutoff = 10000,
	ampScale = 2, subAmp = 0.6,
	verb1Mix = 0.92, verb1Room = 0.95, verbMix = 0.6, verbRoom = 0.9, shiftAmp = 1,
	bufLength = 4, modFreq = 0.3, trigLo = 5, trigHi = 12, grainDur = 0.09, rateLo = 1, rateHi = 150, grainAmp = 0.07,
	cutoffLo = 500, cutoffHi = 7000, cutoffChangeRate = 16, res = 1,
	maxDelay = 4, delayTime = 0.4, feedback = 0.2, delayAmp = 0.5,
	bassBoost = 4
	|

	var input, shift, freq, hasFreq, amplitude;
	var sine, verb1, distortion, verb2;
	var buffer, playhead, record, rate, trigMod, trigger, panner, granulation;
	var shiftArray, shifter1, shifter2, shifter3, shift1, shift2, shift3, shiftSum;
	var cutoffShift, filter, sum, delayLag, delay, localIn, delaySum;
  var eq, lowPass, sig;


	//input:
	input = In.ar(in);
	shift = PitchShift.ar(input, 0.2, 0.5);

	// analysis:
	# freq, hasFreq = Pitch.kr(input, ampThreshold: 0.02, median: 7);
	amplitude = Amplitude.ar(input, 0.01, 0.07);

	// sub Oscillator
	sine = SinOsc.ar(freq/4) * amplitude;
	sine = sine * subAmp;
	sine = sine ! 2;

	// distortion chain
	verb1 = FreeVerb.ar(shift + (input * 0.5), verb1Mix, verb1Room, 0.95);
	distortion = (verb1 * dist).distort;
	distortion = distortion * amplitude;
	verb2 = FreeVerb.ar(distortion, verbMix, verbRoom, 1);
	cutoffShift = TRand.ar(cutoffLo, cutoffHi, Dust.ar(cutoffChangeRate));
	filter = RLPF.ar(verb2, cutoffShift, res);
	filter = filter ! 2;


	// granulation section:
	buffer = LocalBuf(s.sampleRate * bufLength, 1);
	playhead = Phasor.ar(0, BufRateScale.kr(buffer), 0, BufFrames.kr(buffer));
	record = BufWr.ar(distortion, buffer, playhead, 1);
	//trigMod = SinOsc.ar(modFreq).range(trigLo, trigHi);
	trigger = Dust.ar(modFreq);
	panner = TRand.ar(-1, 1, trigger);
	//rate = TRand.ar(rateLo, rateHi, trigger);
  //granulation = GrainBuf.ar(1, trigger, grainDur, buffer, rate, 0.5, 2, panner, -1);
	granulation = GrainBuf.ar(1, trigger, grainDur, buffer, 1, 0.5, 2, panner, -1);
	granulation = granulation * grainAmp;


	// pitchShift Section:
	shiftArray = [1.5, 2, 1.25, 0.75, 1.5, 1.5, 2];
	shifter1 = Demand.ar(Dust.ar(cutoffChangeRate), 0, Drand(shiftArray, inf));
	shift1 = PitchShift.ar(filter, 0.2, shifter1);
	shifter2 = Demand.ar(Dust.ar(cutoffChangeRate), 0, Drand(shiftArray, inf));
	shift2 = PitchShift.ar(filter, 0.2, shifter2);
	shifter3 = Demand.ar(Dust.ar(cutoffChangeRate), 0, Drand(shiftArray, inf));
	shift3 = PitchShift.ar(filter, 0.2, shifter3);
	shiftSum = Mix.new([shift1, shift2, shift3]);
	shiftSum = shiftSum * shiftAmp;
	shiftSum = shiftSum ! 2;

	// mix Section:
	sum = Mix.new([filter, sine, shiftSum, granulation]);
	//sum = sum/3;
	delayLag = Lag2.kr(delayTime, 0.1);
  localIn = LocalIn.ar(2);
  delay = DelayC.ar(sum + (localIn * feedback), maxDelay, delayLag);
  LocalOut.ar(delay);
  delaySum = delay * delayAmp;
  delaySum = sum + delaySum;

	//delay = CombC.ar(sum, maxDelay, delayLag, decayTime);
	//delay = (delay * 0.5) + sum;
	eq = BLowShelf.ar(delaySum, freq/2, 1, bassBoost);
  lowPass = LPF.ar(eq, cutoff);
	sig = lowPass * amp;
	sig = Out.ar(out, sig);

}).add;
)
