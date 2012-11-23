/*
Thursday, November 8th 2012
between Chicago, IL and Detroit, MI
birds.scd
prm
*/

// creates OSC defs for where the birds must be drunk to be amidst the unknown spray and skies

OSCdef(\bed, { | msg |
	var id, val, play, toggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	play = msg.at(3);
	toggle =  msg.at(4);
	vol = msg.at(5);
	case
	{ id == \main } { ~birdsMake[\bed].value([val, play, toggle, vol]); }
	{ id == \play } { ~birdsMake[\bedPlay].value(val); }
	{ id == \toggle } { ~birdsMake[\bedToggle].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, 1.0);
		~birdsSynth[\bed].fader.set(\amp, amp); }
}, \bed, ~scLang);

OSCdef(\birdsMicVerb, { | msg |
	var id, val, toggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	vol = msg.at(4);
	case
	{ id == \main } { ~birdsMake[\birdsMicVerb].value([val, toggle, vol]); }
	{ id == \toggle } { ~birdsMake[\birdsMicVerbToggle].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, 1.0);
		~birdsSynth[\birdsMicVerb].fader.set(\amp, amp); }
}, \birdsMicVerb, ~scLang);

OSCdef(\eqgtr, { | msg |
	var id, val, toggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	vol = msg.at(4);
	case
	{ id == \main } { ~birdsMake[\eqgtr].value([val, toggle, vol]); }
	{ id == \toggle } { ~birdsMake[\eqgtrToggle].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0, 1.0);
		~birdsSynth[\eqgtr].fader.set(\amp, amp); }
}, \eqgtr, ~scLang);

OSCdef(\noiseSynth, { | msg |
	var id, val, play, shift, vol;
	id = msg.at(1);
	val = msg.at(2);
	play = msg.at(3);
	shift = msg.at(4);
	vol = msg.at(5);

	case
	{ id == \main } { ~birdsMake[\noiseSynth].value([val, play, shift, vol]); }
	{ id == \play } { ~birdsMake[\noiseSynthPlay].value(val); }
	{ id == \shift } { ~birdsMake[\noiseSynthShift].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0.0, 1.0);
		~birdsSynth[\noiseSynth].fader.set(\amp, amp); }
}, \noiseSynth, ~scLang);

OSCdef(\tremgtr, { | msg |
	var id, val, toggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	vol = msg.at(4);
	case
	{ id == \main } { ~birdsMake[\tremgtr].value([val, toggle, vol]); }
	{ id == \toggle } { ~birdsMake[\tremgtrToggle].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0.0, 1.0);
		~birdsSynth[\tremgtr].fader.set(\amp, amp); }
}, \tremgtr, ~scLang);

OSCdef(\wobble, { | msg |
	var id, val, toggle, vol;
	id = msg.at(1);
	val = msg.at(2);
	toggle = msg.at(3);
	vol = msg.at(4);
	case
	{ id == \main } { ~birdsMake[\wobble].value([val, toggle, vol]); }
	{ id == \toggle } { ~birdsMake[\wobbleToggle].value(val); }
	{ id == \volume } {
		var amp = val.linlin(0, 127, 0.0, 1.0);
		~birdsSynth[\wobble].fader.set(\amp, amp); }
}, \wobble, ~scLang);

OSCdef(\birdsTransport, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~birdsMake[\seeTransport].value(val); }
}, \transport, ~scLang);