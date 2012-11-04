/*
Wednesday, October 10th 2012
init.scd
prm
*/

// creates a Dictionary to store functions for Connections
~birds = ( );

// creates a dictionary to store the spawning functions for Connections
~birdsMake = ( );

// creates a dictionary to store Synths in Connections
~birdsSynth = ( );

// creates a dictionary to store Buses
~birdsBus = ( );

// creates a dictionary to store buffers:
~birdsBuf = ( );

// creates shared buffers for piece:

~birdsBuf[\noiseSynthPath] = thisProcess.nowExecutingPath.dirname;
~birdsBuf[\noiseSynth] = Array.fill(53, { | i |
		Buffer.read(s,
			(~birdsBuf[\noiseSynthPath] ++ "/Noise Synth/" ++ (i + 32) ++ ".wav").postln; )
	});

// creates a tempo clock:
~birds[\transport] = TempoClock;
~birds[\transport].tempo = 60/60;

// defines mode:
~birds[\mode] = Scale.aeolian;

// sets up a function to clear the piece
~birds[\clear] = {

	~birdsSynth.do({ | i | i.free });
	~birdsBus.do({ | i | i.free; });
	~birdsBuf.do({ | i | i.free; });

	~birdsMake.clear;
	~birdsSynth.clear;
	~birdsBus.clear;
	~birdsBuf.clear;
	~birds.clear;
};


