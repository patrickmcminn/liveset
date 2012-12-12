/*
Saturday, October 13th 2012
edited 12/12/2012
- reflects new control surface handling
airSputters.scd
prm
*/


~connections[\airSputters] = { | val |
	var sputterMake;

	//creates buse
	~connectBus[\airSputters] = (
		\gran: Bus.audio,
		\del: Bus.audio(s, 2)
	);

	// allocates buffers to be played into
	~connectBuf[\airSputters] = Buffer.allocConsecutive(4, s, s.sampleRate * 0.4, 1);

	// creates granulator and delay synths after the buffer players
	~connectSynth[\airSputters] = (

		\gran: Synth(\granulator,
			[
				\in, ~connectBus[\airSputters].gran,
				\out, ~connectBus[\airSputters].del,
				\bufLength, 3,
				\pan, 0,
				\panOffset, 0.7,
				\grainDur, 0.01,
				\granDurOffset, 0.15,
				\env, ~grainBufs[\rexpodec],
				\trigRate, 45,
				\amp, 2
			],
			~group[\fx], \addToTail),

		\del: Synth(\delayStereo, [\in, ~connectBus[\airSputters].del, \out, ~mixer[\s1],
			\maxDelay, 3, \delayTime, 3, \decayTime, 15, \amp, -6.dbamp, \mix, 0.75],
			~group[\fx], \addToTail),

		\onset: Synth(\onsetDetectorTrig, [\in, ~inst[\mute], \id, 0, \thresh, 0.1, \fastMul, 0.65],
			~group[\fx], \addToTail)

	);

	Pbindef(\sputterOne,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\airSputters].at(0),
		\out, ~connectBus[\airSputters].gran,
		\group,		~connectSynth[\airSputters].gran,
		\addAction,	\addBefore,
		\attack, 0.05,
		\sustain, 0.7,
		\release, 0.05,
		\amp, 0.8,
		\dur, 0.125,
		\note, Pseq([1, 1, 1, \r, \r, 1, 1, 1, \r, \r, 1, 1, 1, \r, \r, \r], inf),
		\rate,  Pstep(
			Prand([-1, -1, -1, -1, -1, -1, -0.5, -0.5, -0.5, 0.5, 1, 1,
				1.1, 1.1, 1.1, 1.1, 1.2, 1.2, 1.2, 1.3, 1.3, 1.3, 1.3, 1.3, 2, 2, 2, 2, 2], inf),
			1, inf),
		\startPos, Pif(Pkey(\rate).isPositive, 0, s.sampleRate*0.4));

	Pbindef(\sputterTwo,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\airSputters].at(1),
		\out, ~connectBus[\airSputters].gran,
		\group, ~connectSynth[\airSputters].gran,
		\addAction,	\addBefore,
		\attack, 0.05,
		\sustain, 0.7,
		\release, 0.05,
		\amp, 0.8,
		\dur, 0.125,
		\note, Pseq([1, 1, \r, \r, \r, \r, \r, 1, 1, \r, \r, \r, \r, \r, 1, 1], inf),
		\rate, Pstep(
			Prand([-2, -2, -2, -2, -2, -2, -0.5, -0.5, -0.5, 3, 1.7, 1.7, 1.1, 1.1, 1.1, 1.1, 2.4, 2.4, 2.4,
				2, 2, 2, 2, 2, 2, 2, 2, 2, 2], inf),
			1, inf),
		\startPos, Pif(Pkey(\rate).isPositive, 0, s.sampleRate*0.4));

	Pbindef(\sputterThree,
		\instrument, \playBuf,
		\bufName, ~connectBuf[\airSputters].at(2),
		\out, ~connectBus[\airSputters].gran,
		\group, ~connectSynth[\airSputters].gran,
		\addAction, \addBefore,
		\attack, 0.05,
		\sustain, 0.7,
		\release, 0.05,
		\amp, 0.8,
		\dur, 0.125,
		\note, Pseq([1, \r, \r, \r], inf),
		\rate, Pstep(
			Prand([0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, -0.5, -0.5, -0.5, 1, 1, 1.1, 1.1, 1.1, 1.1,
				0.6, 0.6, 0.6, 0.4, 0.4, 0.4, 0.4], inf),
			1, inf),
		\startPos,	Pif(Pkey(\rate).isPositive, 0, s.sampleRate*0.4));

	Pbindef(\sputterFour,
		\instrument,	\playBuf,
		\bufName, ~connectBuf[\airSputters].at(3),
		\out,		~connectBus[\airSputters].gran,
		\group,		~connectSynth[\airSputters].gran,
		\addAction,	\addBefore,
		\attack, 0.05,
		\sustain, 0.7,
		\release, 0.05,
		\amp, 0.8,
		\dur, 0.125,
		\note, Pseq([1, \r, \r, 1, \r, \r, 1, \r, \r, 1, \r, \r, \r], inf),
		\rate, 0.25);

	~sputterMake = Routine({

		Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\airSputters].at(0)],
			~group[\fx], \addToTail);
		{ Pbindef(\sputterOne).play; }.defer(0.4);
		~scLang.sendMsg(\control, \sputterMake);
		["first breath recorded"].postln.yield;


		Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\airSputters].at(1)],
			~group[\fx], \addToTail);
		{ Pbindef(\sputterTwo).play; }.defer(0.4);
		~scLang.sendMsg(\control, \sputterMake);
		["second breath recorded"].postln.yield;


		Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\airSputters].at(2)],
			~group[\fx], \addToTail);
		{ Pbindef(\sputterThree).play; }.defer(0.4);
		~scLang.sendMsg(\control, \sputterMake);
		["third breath recorded"].postln.yield;


		Synth(\recordBuf, [\in, ~inst[\mute], \bufName, ~connectBuf[\airSputters].at(3)],
			~group[\fx], \addToTail);
		{ Pbindef(\sputterFour).play; }.defer(0.4);
		~scLang.sendMsg(\control, \sputterMake);
		["fourth breath recorded"].postln.yield;


		OSCdef(\airRespond).free;
		~scLang.sendMsg(\control, \sputterMake);
		["done with breath attacks"].postln.yield;

	});

	OSCdef(\airRespond, { ~sputterMake.next.postln; }, '/tr');
};

~connections[\airSputters].addUniqueMethod(\kill, {

	~connectBus[\airSputters].do({ | i | i.free; });
	~connectSynth[\airSputters].do({ | i | i.free; });
	~connectBuf[\airSputters].do({ | i | i.free; });

	Pbindef(\sputterOne).stop;
	Pbindef(\sputterTwo).stop;
	Pbindef(\sputterThree).stop;
	Pbindef(\sputterFour).stop;

	Pbindef(\sputterOne).clear;
	Pbindef(\sputterTwo).clear;
	Pbindef(\sputterThree).clear;
	Pbindef(\sputterFour).clear;

	OSCdef(\airRespond).free;
});

~connections[\airSputters].addUniqueMethod(\stopSputters, {
	Pbindef(\sputterOne).stop;
	Pbindef(\sputterTwo).stop;
	Pbindef(\sputterThree).stop;
	Pbindef(\sputterFour).stop;
});

~connections[\airSputters].addUniqueMethod(\playSputters, {
	Pbindef(\sputterOne).play;
	Pbindef(\sputterTwo).play;
	Pbindef(\sputterThree).play;
	Pbindef(\sputterFour).play;
});



~connectMake[\airSputters] = r { | main |
	var val, toggle, vol;
	val = main.at(0);
	toggle = main.at(1);
	vol = main.at(2);
	loop {
		~connections[\airSputters].value(val);
		~scLang.sendMsg(\control, \airSputters);
		["Air Sputters Active"].postln.yield;

		~connections[\airSputters].kill;
		~scLang.sendMsg(\control, \airSputters);
		["Air Sputters Stopped and Freed"].postln.yield;
	};
};

~connectMake[\airSputtersToggle] = r { | val |
	loop {
		~connections[\airSputters].stopSputters;
		~scLang.sendMsg(\control, \airSputtersToggle);
		["Air Sputters Stopped"].postln.yield;

		~connections[\airSputters].playSputters;
		~scLang.sendMsg(\control, \airSputtersToggle);
		["Air Sputters Playing"].postln.yield;
	};
};


/*
(
~airSputters = {
	var sputterMake;
	Pbindef.removeAll;
	~sputterBus = (
		\gran:	Bus.audio,
		\del:	Bus.audio(s, 2));
	~airBufs = Buffer.allocConsecutive(4, s, s.sampleRate * 0.4, 1);
	~sputterGran = Synth(\granulator, [
					\in,				~sputterBus.at(\gran),
					\out,			~sputterBus.at(\del),
					\bufLength,		3,
					\pan,			0,
					\panOffset,		0.7,
					\grainDur,		0.01,
					\grainDurOffset,	0.15,
					\env,			~grainBufs.at(\rexpodec),
					\trigRate,		45,
					\amp, 			2],
					~fx, \addToTail);
	~sputterDel = Synth(\delayStereo, [\in, ~sputterBus.at(\del), \out, ~outBusOne,
					\maxDelay, 3, \delayTime, 3, \decayTime, 15, \amp, 1, \mix, 0.75],
					~fx, \addToTail);
	Pbindef(\sputterOne,
		\instrument,	\playBuf,
		\bufName,		~airBufs.at(0),
		\out,		~sputterBus.at(\gran),
		\group,		~sputterGran,
		\addAction,	\addBefore,
		\attack,		0.05,
		\sustain, 	0.7,
		\release,		0.05,
		\amp,		0.8,
		\dur,		0.125,
		\note,		Pseq([1, 1, 1, \r, \r, 1, 1, 1, \r, \r, 1, 1, 1, \r, \r, \r], inf),
		\rate, 		Pstep(
						Prand([-1, -1, -1, -1, -1, -1, -0.5, -0.5, -0.5, 0.5, 1, 1,
							1.1, 1.1, 1.1, 1.1, 1.2, 1.2, 1.2, 1.3, 1.3, 1.3, 1.3, 1.3,
							2, 2, 2, 2, 2], inf),
						1, inf),
		\startPos,	Pif(Pkey(\rate).isPositive, 0, s.sampleRate*0.4));
	Pbindef(\sputterTwo,
		\instrument,	\playBuf,
		\bufName,		~airBufs.at(1),
		\out,		~sputterBus.at(\gran),
		\group,		~sputterGran,
		\addAction,	\addBefore,
		\attack,		0.05,
		\sustain, 	0.7,
		\release,		0.05,
		\amp,		0.8,
		\dur,		0.125,
		\note,		Pseq([1, 1, \r, \r, \r, \r, \r, 1, 1, \r, \r, \r, \r, \r, 1, 1], inf),
		\rate,		Pstep(
						Prand([-2, -2, -2, -2, -2, -2, -0.5, -0.5, -0.5, 3, 1.7, 1.7,
								1.1, 1.1, 1.1, 1.1, 2.4, 2.4, 2.4, 2, 2, 2, 2, 2, 2, 2, 2,
								2, 2], inf),
						1, inf),
		\startPos,	Pif(Pkey(\rate).isPositive, 0, s.sampleRate*0.4));
	Pbindef(\sputterThree,
		\instrument,	\playBuf,
		\bufName,		~airBufs.at(2),
		\out,		~sputterBus.at(\gran),
		\group,		~sputterGran,
		\addAction,	\addBefore,
		\attack,		0.05,
		\sustain, 	0.7,
		\release,		0.05,
		\amp,		0.8,
		\dur,		0.125,
		\note,		Pseq([1, \r, \r, \r], inf),
		\rate,		Pstep(
						Prand([0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5
								 -0.5, -0.5, -0.5, 1, 1, 1.1, 1.1, 1.1, 1.1, 0.6, 0.6, 0.6,
								 0.4, 0.4, 0.4, 0.4], inf),
						1, inf),
		\startPos,	Pif(Pkey(\rate).isPositive, 0, s.sampleRate*0.4));
	Pbindef(\sputterFour,
		\instrument,	\playBuf,
		\bufName,		~airBufs.at(3),
		\out,		~sputterBus.at(\gran),
		\group,		~sputterGran,
		\addAction,	\addBefore,
		\attack,		0.05,
		\sustain, 	0.7,
		\release,		0.05,
		\amp,		0.8,
		\dur,		0.125,
		\note,		Pseq([1, \r, \r, 1, \r, \r, 1, \r, \r, 1, \r, \r, \r], inf),
		\rate,		0.25);

	sputterMake = Routine({
		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~airBufs.at(0)], ~fx, \addToTail);
		{ Pbindef(\sputterOne).play; }.defer(0.4);
		["first breath recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~airBufs.at(1)], ~fx, \addToTail);
		{ Pbindef(\sputterTwo).play; }.defer(0.4);
		["second breath recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~airBufs.at(2)], ~fx, \addToTail);
		{ Pbindef(\sputterThree).play; }.defer(0.4);
		["third breath recorded"].yield;

		Synth(\recordBuf, [\in, ~muteBus, \bufName, ~airBufs.at(3)], ~fx, \addToTail);
		{ Pbindef(\sputterFour).play; }.defer(0.4);
		["fourth breath recorded"].yield;

		~airRespond.free;
		["done with breath attacks"].yield;
	});
	~airRespond.free;
	~airRespond = OSCFunc({ sputterMake.next.postln; }, '/tr', s.addr);
	~airOnset = Synth(\onsetDetectorTrig, [\in, ~muteBus, \id, 0, \thresh, 0.1, \fastMul, 0.65],
				~fx, \addToTail)
};


~airSputtersFree = {
	Pbindef(\sputterOne).stop;
	Pbindef(\sputterTwo).stop;
	Pbindef(\sputterThree).stop;
	Pbindef(\sputterFour).stop;
	~sputterBus.do({ | i | i.free });
	~airBufs.size.do({ | i | ~airBufs.at(i).free});
	~sputterGran.free;
	~sputterDel.free;
	~airOnset.free;
};
);
*/
