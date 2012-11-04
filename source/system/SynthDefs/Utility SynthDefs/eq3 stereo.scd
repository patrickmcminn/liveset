SynthDef(\eq3Stereo, { // gain is in db
	|
	in, out, amp = 1,
	loFreq = 250, loGain = 0,
	midBW = 1,
	hiFreq = 2500, hiGain = 0
	|
	var input, avg, lowShelf, mid, hiShelf, sig;
	input = In.ar(in, 2);
	avg = (loFreq + hiFreq)/2;
	lowShelf = BLowShelf.ar(input, loFreq, 1, loGain);
	//mid = BBandPass.ar(lowShelf, avg, midBW);
	hiShelf = BHiShelf.ar(lowShelf, hiFreq, 1, hiGain);
	sig = hiShelf * amp;
	sig = Out.ar(out, sig);
}).add;

"eq3Stereo SynthDef Added".postln;
"args: in, out, amp = 1,".postln;
"     loFreq = 250, loGain = 0, hiFreq = 2500, hiGain = 0".postln;
"".postln;


/*

b = Bus.audio;
a = { | freq = 110 | Out.ar([b], Saw.ar(freq) * 0.2) }.play;

c = Synth(\eq3, [\in, b, \out, 0], addAction: \addToTail);
c.set(\hiGain, -30, \hiFreq, 6000);
c.set(\loGain, 16);

Task{
	loop{
		c.set(\hiGain, 0);
		0.2.rand.wait;
		c.set(\hiGain, -50);
		0.2.rand.wait;
	}
}.play;

Task{
	loop{
		c.set(\loGain, 16);
		0.2.rand.wait;
		c.set(\loGain, -50);
		0.2.rand.wait;
	}
}.play;

Task{
	loop{
		a.set(\freq, [55, 110, 165, 220, 330, 275, 247.5].choose;);
		0.1.rand.wait;
	};
}.play

*/