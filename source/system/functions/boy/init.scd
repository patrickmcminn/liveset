/*
Thursday, November 13th 2012
on the road to Boston, MA
init.scd
prm
*/

// creates a Dictionary to store functions for Connections
~boy = ( );

// creates a dictionary to store the spawning functions for Connections
~boyMake = ( );

// creates a dictionary to store Synths in Connections
~boySynth = ( );

// creates a dictionary to store Buses
~boyBus = ( );

// creates a dictionary to store buffers:
~boyBuf = ( );

// creates a dictionary to store patterns used in the piece
Pdef.removeAll;
Pbindef.removeAll;
~boyPatterns = ( );

// creates a tempo clock:
~boy[\transport] = TempoClock.new;
~boy[\transport].tempo = 82/60;


// creates shared buffers for piece:

~boyBuf[\bellsPath] = thisProcess.nowExecutingPath.dirname;
~boyBuf[\bells] = Array.fill(15, { | i |
		Buffer.read(s,
			(~boyBuf[\bellsPath] ++ "/bells/" ++ (i + 60) ++ ".wav").postln; )
	});
~boyBuf[\noiseSynthPath] = thisProcess.nowExecutingPath.dirname;
~boyBuf[\noiseSynth] = Array.fill(53, { | i |
		Buffer.read(s,
			(~boyBuf[\noiseSynthPath] ++ "/Noise Synth/" ++ (i + 32) ++ ".wav").postln; )
	});



// sets up a function to clear the piece
~boy[\clear] = {

	~boySynth.do({ | i | i.free });
	~boyBus.do({ | i | i.free; });
	~boyBuf.do({ | i | i.free; });

};


