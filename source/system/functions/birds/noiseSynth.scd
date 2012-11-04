/*
Friday, November 2nd, 2012
noiseSynth.scd
prm
*/


~birdsBuf[\noiseSynthPath] = thisProcess.nowExecutingPath.dirname;

~birdsBuf[\noisSynth] = [ ]



~birdsBuf[\noiseSynth] = Array.fill(53, { | i |
		Buffer.read(s,
			(~birdsBuf[\noiseSynthPath] ++ "/Noise Synth/" ++ (i + 32) ++ ".wav").postln; )
	});


a = Synth(\playBuf, [\amp, 0, \amp, 0.2, \sustain, 7, \bufName, ~birdsBuf[\noiseSynth].at(20), \loop, 1]);
b = Synth(\playBuf, [\amp, 0, \amp, 0.2, \sustain, 7, \bufName, ~birdsBuf[\noiseSynth].at(24), \loop, 1]);
c = Synth(\playBuf, [\amp, 0, \amp, 0.2, \sustain, 7, \bufName, ~birdsBuf[\noiseSynth].at(27), \loop, 1]);


(
var deg1, deg2, deg3, deg4, deg5, deg6, deg7, deg8;
deg1 = ~birdsBuf[\noiseSynth].at(66-32);
deg2 = ~birdsBuf[\noiseSynth].at(68-32);
deg3 = ~birdsBuf[\noiseSynth].at(69-32);
deg4 = ~birdsBuf[\noiseSynth].at(71-32);
deg5 = ~birdsBuf[\noiseSynth].at(73-32);
deg6 = ~birdsBuf[\noiseSynth].at(74-32);
deg7 = ~birdsBuf[\noiseSynth].at(76-32);
deg8 = ~birdsBuf[\noiseSynth].at(78-32);
Pbindef(\test3,
	\instrument, \playBuf,
	\note, Pseq([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, \r], inf),
	\bufName, Prand([deg1, deg2, deg3, deg4, deg5, deg6, deg7, deg8, deg7, deg6, deg5, deg4, deg3, deg2, deg1, deg1], inf),
	\legato, 2,
	\dur, 0.25
).play

Pbindef(\test2,
	\instrument, \default,
	\freq, 220).play


~midinotes = 


Pbindef(\testPlayer, 
	\instrument, \playBuf,
	\degree, Pseries(0, Prand(#[-2, -1, 1, 2], inf), inf).fold(-11, 11),
	\dur, Pwrand([0.25, Pn(0.125, 2)], #[0.8, 0.2], inf),
	\amp, 0.5,
	\freq, Pfunc { | ev | ev.use(ev[\freq]) },
	\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].indexInBetween(ev[\freq].cpsmidi) }).clip(0, 
		~birdsBuf[\noiseSynth].size - 1.001)
	).play;
	
~birdsBuf[\noiseSynth]






~midinotes = [39, 46, 53, 60, 67, 74, 81, 88];

SynthDef(\multiSampler, { |out, bufnum, bufBase, baseFreqBuf, freq = 440, amp = 1|
Ê Ê var Ê Êbuf1 = bufnum.floor,
Ê Ê Ê Ê buf2 = buf1 + 1,
Ê Ê Ê Ê xfade = (bufnum - buf1).madd(2, -1),
Ê Ê Ê Ê basefreqs = Index.kr(baseFreqBuf, [buf1, buf2]),
Ê Ê Ê Ê playbufs = PlayBuf.ar(1, bufBase + [buf1, buf2], freq / basefreqs, loop: 0, doneAction: 2),
Ê Ê Ê Ê sig = XFade2.ar(playbufs[0], playbufs[1], xfade, amp);
Ê Ê Out.ar(out, sig ! 2)
}).add;

~baseBuf = Buffer.alloc(s, ~midinotes.size, 1, { |buf| buf.setnMsg(0, 
	~midinotes.midicps) });
)

(
TempoClock.default.tempo = 1;
p = Pbind(
Ê Ê \instrument, \multiSampler,
Ê Ê \bufBase, ~birdsBuf[\noiseSynth].first,
Ê Ê \baseFreqBuf, ~baseBuf,
Ê Ê \degree, Pseries(0, Prand(#[-2, -1, 1, 2], inf), inf).fold(-11, 11),
Ê Ê \dur, 9,
Ê Ê \amp, Pexprand(0.1, 0.5, inf),
Ê Ê Ê Ê // some important conversions
Ê Ê Ê Ê // identify the buffer numbers to read
Ê Ê \freq, Pfunc { |ev| ev.use(ev[\freq]) },
Ê Ê \bufnum, Pfunc({ |ev| ~midinotes.indexInBetween(ev[\freq].cpsmidi) })
Ê Ê Ê Ê .clip(0, ~midinotes.size - 1.001)
).play;
)

p.stop;
b.do(_.free); ~baseBuf.free;

Synth(\playBuf, [\bufName, ~birdsBuf[\noiseSynth].at(4), \amp, 0.2])
Scale

// actually in the key of C!!!
{ SinOsc.ar(261.6255653006) }.play
Pbindef(\samplePlayer, 
	\instrument, \playBuf,
	\scale, Pfunc({ ~birds[\mode]}, inf),
	\dur, Prand([0.5, 0.25, 0.75, 1], inf),
	\degree, Pseq([0, 1, 2, 3, 2, 1], inf),
	\octave, 2,
	\sustain, Pkey(\dur),
	\amp, 0.5,
	\freq, Pfunc { | ev | ev.use(ev[\freq]) },
	\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) }).poll
).play

Pbindef(\samplePlayer5, 
	\instrument, \playBuf,
	\scale, Pfunc({ ~birds[\mode]}, inf),
	\dur, Pseq([1, 1, 0.5, 0.5, 1], inf),
	\degree, Pseq([0, 1, 2, 1, 0], inf),
	\octave, 4,
	\sustain, Pkey(\dur),
	\amp, 0.5,
	\freq, Pfunc { | ev | ev.use(ev[\freq]) },
	\bufName, Pfunc({ | ev | ~birdsBuf[\noiseSynth].at((ev[\freq].cpsmidi)-32) })
).play

	
