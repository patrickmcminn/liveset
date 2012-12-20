/*
Wednesday, October 17th 2012
Outside of Albuquerque, NM
chordSum.scd
prm
*/

~connections[\chordSum] = {
	var attack, sustain, release, amp;
	attack = 0.1;
	sustain = 0.8;
	release = 0.1;
	amp = 1;
	~connectBus[\chordSum] = (
		\fSharpMinor: Bus.audio,
		\aMajor: Bus.audio,
		\cSharpMinor: Bus.audio,
		\eMajor: Bus.audio,
	);

	~connectSynth[\chordSum] = ();


	~connectSynth[\chordSum].fSharpMinor = (

		\fSharp: Synth(\playBuf, [\out, ~connectBus[\chordSum].fSharpMinor, \amp, amp,
			\bufName, ~connectBuf[\chord].at(0), \attack, attack, \sustain, sustain,
			\release, release], ~group[\synths], \addToTail),

		\a: Synth(\playBuf, [\out, ~connectBus[\chordSum].fSharpMinor, \amp, amp,
			\bufName, ~connectBuf[\chord].at(1), \attack, attack, \sustain, sustain,
			\release, release], ~group[\synths], \addToTail),

		\cSharp: Synth(\playBuf, [\out, ~connectBus[\chordSum].fSharpMinor, \amp, amp,
			\bufName, ~connectBuf[\chord].at(2), \attack, attack, \sustain, sustain,
			\release, release], ~group[\synths], \addToTail),

		\rec: Synth(\recordBuf, [\in, ~connectBus[\chordSum].fSharpMinor, \bufName, ~connectBuf[\chordSum].at(0)],
			~group[\synths], \addToTail)
	);


	~connectSynth[\chordSum].aMajor = (

		\a: Synth(\playBuf, [\out, ~connectBus[\chordSum].aMajor, \amp, amp, \bufName, ~connectBuf[\chord].at(1),
			\attack, attack, \sustain, sustain, \release, release], ~group[\synths], \addToTail),

		\cSharp: Synth(\playBuf, [\out, ~connectBus[\chordSum].aMajor, \amp, amp, \bufName, ~connectBuf[\chord].at(2),
			\attack, attack, \sustain, sustain, \release, release], ~group[\synths], \addToTail),

		\e: Synth(\playBuf, [\out, ~connectBus[\chordSum].aMajor, \amp, amp, \bufName, ~connectBuf[\chord].at(5),
			\attack, attack, \sustain, sustain, \release, release], ~group[\synths], \addToTail),

		\rec: Synth(\recordBuf, [\in, ~connectBus[\chordSum].aMajor, \bufName, ~connectBuf[\chordSum].at(1)],
			~group[\synths], \addToTail)
	);

	~connectSynth[\chordSum].cSharpMinor = (

		\cSharp: Synth(\playBuf, [\out, ~connectBus[\chordSum].cSharpMinor, \amp, amp,
			\bufName, ~connectBuf[\chord].at(2), \attack, attack, \sustain, sustain, \release, release],
			~group[\synths], \addToTail),

		\e: Synth(\playBuf, [\out, ~connectBus[\chordSum].cSharpMinor, \amp, amp,
			\bufName, ~connectBuf[\chord].at(5), \attack, attack, \sustain, sustain, \release, release],
			~group[\synths], \addToTail),

		\gSharp: Synth(\playBuf, [\out, ~connectBus[\chordSum].cSharpMinor, \amp, amp,
			\bufName, ~connectBuf[\chord].at(4), \attack, attack, \sustain, sustain, \release, release],
			~group[\synths], \addToTail),

		\rec: Synth(\recordBuf, [\in, ~connectBus[\chordSum].cSharpMinor, \bufName, ~connectBuf[\chordSum].at(2)],
			~group[\synths], \addToTail)
	);

	~connectSynth[\chordSum].eMajor = (

		\e: Synth(\playBuf, [\out, ~connectBus[\chordSum].eMajor, \amp, amp,
			\bufName, ~connectBuf[\chord].at(5), \attack, attack, \sustain, sustain, \release, release],
			~group[\synths], \addToTail),

		\gSharp: Synth(\playBuf, [\out, ~connectBus[\chordSum].eMajor, \amp, amp,
			\bufName, ~connectBuf[\chord].at(4), \attack, attack, \sustain, sustain, \release, release],
			~group[\synths], \addToTail),

		\b: Synth(\playBuf, [\out, ~connectBus[\chordSum].eMajor, \amp, amp,
			\bufName, ~connectBuf[\chord].at(3), \attack, attack, \sustain, sustain, \release, release],
			~group[\synths], \addToTail),

		\rec: Synth(\recordBuf, [\in, ~connectBus[\chordSum].eMajor, \bufName, ~connectBuf[\chordSum].at(3)],
			~group[\synths], \addToTail)
	);


};


~connectMake[\chordSum] = r { | val |
	loop{
		~connections[\chordSum].value;
		~scLang.sendMsg(\control, \chordSum);
		["chords summed"].postln.yield;
	};
};



/*

(
~chordsRecord = {
	var attack, sustain, release, amp;
	attack = 0.1;
	sustain = 0.8;
	release = 0.1;
	amp = 1;
	~chordBufs = Buffer.allocConsecutive(4, s, s.sampleRate, 1);
	~chordsRecordBus = (
		\fSharpMinor:		Bus.audio,
		\aMajor:			Bus.audio,
		\cSharpMinor:		Bus.audio,
		\eMajor:			Bus.audio);
	~fSharpMinor = (
		\fSharp:		Synth(\playBuf, [\out, ~chordsRecordBus.at(\fSharpMinor), \amp, amp,
						\bufName, ~chordBuffers.at(0), \attack, attack, \sustain, sustain,
						\release, release], ~fx, \addToTail),
		\a:			Synth(\playBuf, [\out, ~chordsRecordBus.at(\fSharpMinor), \amp, amp,
						\bufName, ~chordBuffers.at(1), \attack, attack, \sustain, sustain, 						\release, release], ~fx, \addToTail),
		\cSharp:		Synth(\playBuf, [\out, ~chordsRecordBus.at(\fSharpMinor), \amp, amp,
						\bufName, ~chordBuffers.at(2), \attack, attack, \sustain, sustain, 						\release, release], ~fx, \addToTail),
		\rec:		Synth(\recordBuf, [\in, ~chordsRecordBus.at(\fSharpMinor),
						\bufName, ~chordBufs.at(0)], ~fx, \addToTail));
	~aMajor = (
		\a:			Synth(\playBuf, [\out, ~chordsRecordBus.at(\aMajor), \amp, amp,
						\bufName, ~chordBuffers.at(1), \attack, attack, \sustain, sustain,
						\release, release], ~fx, \addToTail),
		\cSharp:		Synth(\playBuf, [\out, ~chordsRecordBus.at(\aMajor), \amp, amp,
						\bufName, ~chordBuffers.at(2), \attack, attack, \sustain, sustain,
						\release, release], ~fx, \addToTail),
		\e:			Synth(\playBuf, [\out, ~chordsRecordBus.at(\aMajor), \amp, amp,
						\bufName, ~chordBuffers.at(5), \attack, attack, \sustain, sustain,
						\release, release], ~fx, \addToTail),
		\rec:		Synth(\recordBuf, [\in, ~chordsRecordBus.at(\aMajor),
						\bufName, ~chordBufs.at(1)], ~fx, \addToTail));
	~cSharpMinor = (
		\cSharp:		Synth(\playBuf, [\out, ~chordsRecordBus.at(\cSharpMinor), \amp, amp,
						\bufName, ~chordBuffers.at(2), \attack, attack, \sustain, sustain,
						\release, release], ~fx, \addToTail),
		\e:			Synth(\playBuf, [\out, ~chordsRecordBus.at(\cSharpMinor), \amp, amp,
						\bufName, ~chordBuffers.at(5), \attack, attack, \sustain, sustain,
						\release, release], ~fx, \addToTail),
		\gSharp:		Synth(\playBuf, [\out, ~chordsRecordBus.at(\cSharpMinor), \amp, amp,
						\bufName, ~chordBuffers.at(4), \attack, attack, \sustain, sustain,
						\release, release], ~fx, \addToTail),
		\rec:		Synth(\recordBuf, [\in, ~chordsRecordBus.at(\cSharpMinor),
						\bufName, ~chordBufs.at(2)], ~fx, \addToTail));
	~eMajor = (
		\e:			Synth(\playBuf, [\out, ~chordsRecordBus.at(\eMajor), \amp, amp,
						\bufName, ~chordBuffers.at(5), \attack, attack, \sustain, sustain,
						\release, release], ~fx, \addToTail),
		\gSharp:		Synth(\playBuf, [\out, ~chordsRecordBus.at(\eMajor), \amp, amp,
						\bufName, ~chordBuffers.at(4), \attack, attack, \sustain, sustain,
						\release, release], ~fx, \addToTail),
		\b:			Synth(\playBuf, [\out, ~chordsRecordBus.at(\eMajor), \amp, amp,
						\bufName, ~chordBuffers.at(3), \attack, attack, \sustain, sustain,
						\release, release], ~fx, \addToTail),
		\rec:		Synth(\recordBuf, [\in, ~chordsRecordBus.at(\eMajor),
						\bufName, ~chordBufs.at(3)], ~fx, \addToTail));
};
);
	*/
