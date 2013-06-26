/*
Wednesday, March 13th 2013
wakingIdeas.scd
prm
*/


~waking[\init] = {

	~waking.chordOne.makeOSC;
	~waking.chordOneHigh.makeOSC;
	~waking.chordOneLow.makeOSC;
	~waking.chordTwo.makeOSC;
	~waking.chordTwoHigh.makeOSC;
	~waking.chordTwoLow.makeOSC;

	~waking.chordOne.spawn;
	~waking.chordOneHigh.spawn;
	~waking.chordOneLow.spawn;
	~waking.chordTwo.spawn;
	~waking.chordTwoHigh.spawn;
	~waking.chordTwoLow.spawn;
};


~waking.init

~waking.filterA.spawn
~waking.filterB.spawn
~waking.filterC.spawn



~waking.filterA.makeAutoFilter
~waking.filterB.makeAutoFilter
~waking.filterC.makeAutoFilter


~waking.filterA.killAutoFilter
~waking.filterB.killAutoFilter
~waking.filterC.killAutoFilter

~waking.filterA.autoFilter.set(\modHi, 2000)

~waking.filterA.fader.set(\amp, 10)

~waking.filterA.fader

~waking.filterB.autoFilter.set(\freq, 6, \modWave, 0)
~waking.filterB.autoFilter.set(\modHi, 3000)

MIDIdef.cc(\test, { | val | ~waking.filterB.autoFilter.set(\freq, val.linexp(0, 127, 0.04, 1000)) }, 17)


~waking.chordOne.path

~waking.init

~waking.chordOne.chordToggle

~waking.chordOneLow.chordToggle

~scLang.sendMsg(\wakingChordOne, \chord)
~scLang.sendMsg(\wakingChordTwo, \chord)

~ohm.turnGreen(27);
~ohm.turnGreen(27+8);
~ohm.turnGreen(61);
~ohm.turnGreen(22);

~ohm.turnOff(6)

MIDIdef.noteOn(\wakingChordOneOn, { ~scLang.sendMsg(\wakingChordOne, \chord); ~ohm.turnYellow(27); }, 27);
MIDIdef.noteOff(\wakingChordOneOff, { ~scLang.sendMsg(\wakingChordOne, \chord); ~ohm.turnGreen(27); }, 27);
MIDIdef.noteOn(\wakingChordTwoOn, { ~scLang.sendMsg(\wakingChordTwo, \chord); ~ohm.turnYellow(35); }, 35);
MIDIdef.noteOff(\wakingChordTwoOff, { ~scLang.sendMsg(\wakingChordTwo, \chord); ~ohm.turnGreen(35); }, 35);


MIDIdef.noteOn(\wakingChordOneHighOn, { ~scLang.sendMsg(\wakingChordOneHigh, \chord); ~ohm.turnYellow(5); }, 5);
MIDIdef.noteOff(\wakingChordOneHighOff, { ~scLang.sendMsg(\wakingChordOneHigh, \chord); ~ohm.turnGreen(5); }, 5);
MIDIdef.noteOn(\wakingChordTwoHighOn, { ~scLang.sendMsg(\wakingChordTwoHigh, \chord); ~ohm.turnYellow(13); }, 13);
MIDIdef.noteOff(\wakingChordTwoHighOff, { ~scLang.sendMsg(\wakingChordTwoHigh, \chord); ~ohm.turnGreen(13); }, 13);

MIDIdef.noteOn(\wakingChordOneLowOn, { ~scLang.sendMsg(\wakingChordOneLow, \chord); ~ohm.turnYellow(22); }, 22);
MIDIdef.noteOff(\wakingChordOneLowOff, { ~scLang.sendMsg(\wakingChordOneLow, \chord); ~ohm.turnGreen(22); }, 22);
MIDIdef.noteOn(\wakingChordTwoLowOn, { ~scLang.sendMsg(\wakingChordTwoLow, \chord); ~ohm.turnYellow(61); }, 61);
MIDIdef.noteOff(\wakingChordTwoLowOff, { ~scLang.sendMsg(\wakingChordTwoLow, \chord); ~ohm.turnGreen(61); }, 61);




// create function dictionary for waking functions
~waking = ( );

~path = thisProcess.nowExecutingPath.dirname;
~path = PathName(~path);
~path = PathName(~path.parentPath);
~path = PathName(~path.parentPath);
~path = ~path.parentPath ++ "data/sampled/Waking/";

~chord1 = ~path ++ "chord 1.aif";
~chord2 = ~path ++ "chord 2.aif";

a = Buffer.read(s, ~chord1);
b = Buffer.read(s, ~chord2);

a.play
b.play


Warp1

// pretty ok for pitch shifting
{ Pan2.ar(
	LPF.ar(
		BLowShelf.ar(
			Warp1.ar(1, a, SinOsc.ar(0.2).range(0.1, 0.9), 0.5, 0.2, -1, 8, 0, 1, 2, 0),
			1,
			220,
			12),
		5000) * 0.2,
	0);

}.play

s.meter


// not great for pitch shifting down, it seems
{ Pan2.ar(
	GrainBuf.ar(
		1,
		Dust.ar(30),
		LFNoise0.ar(22).range(0.05, 2),
		a,
		0.5,
		0.4,
	) * 0.2,
	0);
}.play


// not bad for pitch shifting down
{
	Pan2.ar(
		PlayBuf.ar(
			1,
			a,
			0.5
			loop: 1
		),
		0
	);
}.play


// pretty shitty for pitch shifting down
{
	Pan2.ar(
		PitchShift.ar(
			PlayBuf.ar(1, a, loop: 1),
			0.2,
			0.5,
			0.001,
			0.04,
		),
		0
	);
}.play



r ({
	loop {
		d = Synth(\warpEnv,
			[\bufName, a, \attack, 12, \release, 9, \shift, 0, \lowShelfFreq, 440, \lowShelfGain, 0, \cutoff, 15000, \amp, 0.2]);
		3.wait;
		e.set(\gate, 0);
		4.wait;
		e = Synth(\warpEnv, [\bufName, b, \attack, 12, \release, 9, \shift, 0, \amp, 0.2]);
		4.wait;
		d.set(\gate, 0);
		7.wait;
	};
}).play;


r ({
	loop {
		f = Synth(\warpEnv,
			[\bufName, a, \attack, 12, \release, 12, \shift, -12, \lowShelfFreq, 220, \lowShelfGain, 9, \cutoff, 700, \amp, 0.3]);
		5.wait;
		g.set(\gate, 0);
		6.wait;
		g = Synth(\warpEnv,
			[\bufName, b, \attack, 12, \release, 12, \shift, -12, \lowShelfFreq, 264, \lowShelfGain, 9, \cutoff, 600, \amp, 0.3]);
		6.wait;
		f.set(\gate, 0);
		9.wait;
	}
}).play;

/*r ({
	loop {
		h = Synth(\warpEnv,
			[\bufName, a, \attack, 14, \release, 14, \shift, -24, \lowShelfFreq, 110, \lowShelfGain, 11, \cutoff, 200, \amp, 0.5]);
		8.wait;
		i.set(\gate, 0);
		10.wait;
		i = Synth(\warpEnv,
			[\bufName, b, \attack, 14, \release, 14, \shift, -24, \lowShelfFreq, 132, \lowShelfGain, 11, \cutoff, 200, \amp, 0.5]);
		10.wait;
		h.set(\gate, 0);
		12.wait;
	}
}).play;*/


s.meter


Pbindef(\bass,
	\instrument, \ratioSaw,
	\atk, 0.05,
	\sus, Pseq([10, 10, 20], inf),
	\rel, 0.05,
	\legato, 1,
	\dur, Pseq([10, 10, 20], inf),
	\root, Pseq([5], inf),
	\degree, Pseq([0, 1, 2], inf),
	\octave, 2,
	\amp, 0.3,
	\filterMul, 2
)

Pbindef(\bass).play
Pbindef(\bass).stop

s.meter
s.makeWindow

~chordOne.init