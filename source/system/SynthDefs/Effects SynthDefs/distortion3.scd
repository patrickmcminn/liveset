

SynthDef(\distortion3, {

	| in, out, amp, dist = 10, centerFreq = 1000, bw = 4, cutoff = 15000, mix = 1 |

	var input, dry, distortion, bandPass, lowPass, sig;

	input = In.ar(in);
	dry = input * (1-mix);
	distortion = input * dist;
	distortion = distortion.distort;
	bandPass = BBandPass.ar(distortion, centerFreq, bw);
	lowPass = LPF.ar(bandPass, cutoff);
	sig = lowPass * amp;
	sig = sig * mix;
	sig = sig + dry;
	sig = Out.ar(out, sig);
}).add;

