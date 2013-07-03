/*
Thursday, September 20th 2012
ohmInit.scd
prm
Initializes Ohm RGB Control Surface and creates basic functions to provide
visual feedback
*/

(
var ohm;
MIDIIn.connectAll;
ohm = MIDIOut.newByName("OhmRGB", "Controls");
ohm.latency = 0;

~ohm = { };
~ohm.addUniqueMethod(\turnOff, { | func, val |
	ohm.noteOn(16, val, 0)});
~ohm.addUniqueMethod(\turnRed, { | func, val |
	ohm.noteOn(16, val, 16)});
~ohm.addUniqueMethod(\turnGreen, { | func, val |
	ohm.noteOn(16, val, 127)});
~ohm.addUniqueMethod(\turnBlue, { | func, val |
	ohm.noteOn(16, val, 32)});
~ohm.addUniqueMethod(\turnYellow, { | func, val |
	ohm.noteOn(16, val, 64)});
~ohm.addUniqueMethod(\turnCyan, { | func, val |
	ohm.noteOn(16, val, 4)});
~ohm.addUniqueMethod(\turnPurple, { | func, val |
	ohm.noteOn(16, val, 8)});
~ohm.addUniqueMethod(\turnWhite, { | func, val |
	ohm.noteOn(16, val, 1)});


// 'legacy' values:
~ohm.addUniqueMethod(\turnLavender, { | func, val |
	ohm.noteOn(16, val, 1)});
~ohm.addUniqueMethod(\turnPink, { | func, val |
	ohm.noteOn(16, val, 8)});


~ohm.addUniqueMethod(\clearAll, { | func, val |
	MIDIdef.freeAll;
	127.do({ | i | ~ohm.turnOff(i);});});


~ohm.addUniqueMethod(\blink, { | func, val, color, time |
	case
	{ color == \lavender } {
		~ohm.turnLavender(val);
		{ ~ohm.turnOff(val) }.defer(time);}
	{ color == \blue } {
		~ohm.turnBlue(val);
		{ ~ohm.turnOff(val) }.defer(time);}
	{ color == \pink } {
		~ohm.turnPink(val);
		{ ~ohm.turnOff(val) }.defer(time); }
	{ color == \red } {
		~ohm.turnRed(val);
		{ ~ohm.turnOff(val) }.defer(time); }
	{ color == \purple } {
		~ohm.turnPurple(val);
		{ ~ohm.turnOff(val) }.defer(time); }
	{ color == \yellow } {
		~ohm.turnYellow(val);
		{ ~ohm.turnOff(val) }.defer(time); }
	{ color == \green } {
		~ohm.turnGreen(val);
		{ ~ohm.turnOff(val) }.defer(time); }
});


~ohm.addUniqueMethod(\splash, { | func, val |
	Routine({
		64.do({ | i |
		~ohm.turnRed(i);
		0.01.wait;
	});
	0.25.wait;
	64.do({ | i | ~ohm.turnGreen(i); });
	0.5.wait;
	127.do({ | i | ~ohm.turnOff(i); });
	"Ohm initialized".postln;
	}).play(AppClock);
});


// creates function dictionary to hold different pages
~page = ( );




"Ohm Functions Added".postln;
)

		