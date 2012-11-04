/*
Tuesday, October 9th 2012
instruments.scd
prm
defines external inputs to the system
*/


	var amp = 1;

	// define dictionary to store instrument busses:
	~inst = ();

	// define dictionary to store instruments:
	~instI = ();

	// input busses:
	~inst[\trick] = Bus.audio;
	~inst[\guitarInit] = Bus.audio;
	~inst[\mute] = Bus.audio;
	~inst[\mic] = Bus.audio;
    ~inst[\guitar] = Bus.audio;


	// instrument inputs:
	~instI[\guitarInit] = Synth(\instIn, [\in, 0, \out, ~inst[\guitar], \amp, amp], ~group[\input], \addToTail);
	~instI[\mute] = Synth(\instIn, [\in, 1, \out, ~inst[\mute], \amp, amp], ~group[\input], \addToTail);
	~instI[\mic] = Synth(\instIn, [\in, 2, \out, ~inst[\mic], \amp, amp], ~group[\input], \addToTail);
