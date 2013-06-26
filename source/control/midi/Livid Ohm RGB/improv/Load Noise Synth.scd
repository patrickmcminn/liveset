/*
Sunday, June 23rd 2013
Load Noise Synth.scd
prm
*/

{
	s.sync;

	"/noise synth/Noise Synth Page.scd".loadRelative;
	"/noise synth/noiseSynthOhm.scd".loadRelative;
	"/noise synth/keyboard.scd".loadRelative;
	"/noise synth/controls.scd".loadRelative;
	"/noise synth/outputSet.scd".loadRelative;

	s.sync;

	~restoreOhm.improv.noiseSynth = ( );
	~restoreOhm.improv.noiseSynth.page = Array.fill(81, nil);
	~improvOhm.noiseSynth.makeOSC;

}.fork;