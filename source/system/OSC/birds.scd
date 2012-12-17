/*
Thursday, November 8th 2012
between Chicago, IL and Detroit, MI
birds.scd
prm
*/

// creates OSC defs for where the birds must be drunk to be amidst the unknown spray and skies

OSCdef(\bed, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~birdsMake[\bed].value; }
	{ id == \play } { ~birdsMake[\bedPlay].value; }
	{ id == \toggle } { ~birdsMake[\bedToggle].value; }
	{ id == \volume } { ~birdsSynth[\bed].fader.set(\amp, val); }
}, \bed, ~scLang);

OSCdef(\birdsMicVerb, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~birdsMake[\birdsMicVerb].value; }
	{ id == \toggle } { ~birdsMake[\birdsMicVerbToggle].value; }
	{ id == \volume } {	~birdsSynth[\birdsMicVerb].fader.set(\amp, val); }
}, \birdsMicVerb, ~scLang);


OSCdef(\eqgtr, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~birdsMake[\eqgtr].value; }
	{ id == \toggle } { ~birdsMake[\eqgtrToggle].value; }
	{ id == \shift } { ~birdsMake[\distShift].value; }
	{ id == \volume } {	~birdsSynth[\eqgtr].fader.set(\amp, val); }
}, \eqgtr, ~scLang);

OSCdef(\noiseSynth, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~birdsMake[\noiseSynth].value; }
	{ id == \play } { ~birdsMake[\noiseSynthPlay].value; }
	{ id == \shift } { ~birdsMake[\noiseSynthShift].value; }
	{ id == \volume } { ~birdsSynth[\noiseSynth].fader.set(\amp, val); }
}, \noiseSynth, ~scLang);

OSCdef(\tremgtr, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~birdsMake[\tremgtr].value; }
	{ id == \toggle } { ~birdsMake[\tremgtrToggle].value; }
	{ id == \shift } { ~birdsMake[\tremShift].value; }
	{ id == \volume } { ~birdsSynth[\tremgtr].fader.set(\amp, val); }
}, \tremgtr, ~scLang);


OSCdef(\wobble, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~birdsMake[\wobble].value; }
	{ id == \toggle } { ~birdsMake[\wobbleToggle].value; }
	{ id == \volume } { ~birdsSynth[\wobble].fader.set(\amp, val); }
}, \wobble, ~scLang);

OSCdef(\birdsTransport, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~birdsMake[\seeTransport].value; }
}, \birdsTransport, ~scLang);