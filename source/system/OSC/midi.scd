/*
Thursday, October 18th 2012
midi.scd
prm
*/

OSCdef(\page, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);

	case
	{ id == \top } { ~page[\top].value }
	{ id == \connections } { ~page[\connections].value; }
	{ id == \theBoy } { ~page[\theBoy].value; }
	{ id == \birds } { ~page[\birds].value; }

}, \page, ~scLang);