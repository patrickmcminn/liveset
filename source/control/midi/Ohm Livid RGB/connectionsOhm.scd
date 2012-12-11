/*
Tuesday, December 11 2012
connectionsOhm.scd
prm
*/




/*
/control/connections/ohm/droner

OSCdef(\liffle, { | msg |
	var id = msg.at(1);
	case
	{ id == '/connections/ohm/droner' } { "dongs".postln; }
	{ id == '/connections/quneo/droner' } { "diffles".postln; }
}, \control);

~scLang.sendMsg(\control, '/connections/ohm/droner')
~scLang.sendMsg(\control, '/connections/quneo/droner')
*/