/*
Monday, December 3rd 2012
soundcheck.scd
prm
*/

SynthDef(\twinPeaksPlayer, {
	| buffer, out = 0, loop = 1, amp = 0.7 |
	var player, sig;
	player = PlayBuf.ar(2, buffer, loop: loop);
	sig = player * amp;
	sig = Out.ar(out, sig);
}).add;

~mixer[\soundcheck] = {
	var peaksPath;
	peaksPath = thisProcess.nowExecutingPath.dirname;
	peaksPath = peaksPath ++ "/twinPeaks.wav";
	~twinPeaks = Buffer.read(s, peaksPath);
	~mixer[\soundcheckBus] = Bus.audio;
	~mixer[\soundcheckSynth] = Synth(\twinPeaksPlayer, [\buffer, ~twinPeaks, ~mixer[\soundcheckBus], \out, ~mixer[\s1],
		\amp, 0], ~group[\fx], \addToTail);
};
~mixer[\soundcheck].addUniqueMethod(\kill, {
	~mixer[\soundcheckBus].free;
	~mixer[\soundcheckSynth].free;
	~twinPeaks.free;
});

~mixer[\soundcheckMake] = r({ | val |
	loop{
		~mixer[\soundcheck].value;
		MIDIdef.cc(\soundcheckVol, { | val |
			var amp = val.linlin(0, 127, 0, -6.dbamp);
			~mixer[\soundcheckSynth].set(\amp, amp);
		}, 23);
		~ohm.turnBlue(val).yield;

		~mixer[\soundcheck].kill;
		MIDIdef(\soundcheckVol).free;
		~ohm.turnRed(val).yield;
	};
});