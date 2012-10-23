/*
Wednesday, October 10th 2012
init.scd
prm
*/

// creates a Dictionary to store functions for Connections
~connections = ( );

// creates a dictionary to store the spawning functions for Connections
~connectMake = ( );

// creates a dictionary to store Synths in Connections
~connectSynth = ( );

// creates a dictionary to store Buses
~connectBus = ( );

// creates a dictionary to store buffers:
~connectBuf = ( );

// creates shared buffers for piece:
~connectBuf[\note] = Buffer.allocConsecutive(5, s, s.sampleRate * 3.2, 1);
~connectBuf[\cascade] = Buffer.allocConsecutive(3, s, s.sampleRate*0.5, 1);
~connectBuf[\chord] = Buffer.allocConsecutive(6, s, s.sampleRate*1, 1);

// creates a tempo clock:
~connections[\transport] = TempoClock;
~connections[\transport].tempo = 75/60;


// sets up a function to clear the piece
~connections[\clear] = {

	~connectSynth.do({ | i | i.free });
	~connectBus.do({ | i | i.free; });
	~connecBuf.do({ | i | i.free; });

	~connectMake.clear;
	~connectSynth.clear;
	~connectBus.clear;
	~connectBuf.clear;
	~connections.clear;
};


/*
~seeTransport =
	~connections[\transport].schedAbs(~connections[\transport].nextBar, {
	[~connections[\transport].bar, (~connections[\transport].beatInBar + 1)].postln; 1;});
*/



