/*
Monday, December 3rd 2012
endFade.scd
prm
*/

~boyMake[\endFade] = r({ | val |
	var time = 60;
	loop{
		~ohm.turnBlue(val);
		~boyBus[\endFade] = (
			\volume: Bus.control
		);
		~boySynth[\endFade] = Synth(\ctlLinLine, [\out, ~boyBus[\endFade], \start, -8.dbamp, \end, 0, \dur, time],
			~group[\control], \addToTail);
		~boySynth[\randBell].at(\fader).set(\amp, ~boyBus[\endFade].at(\volume).asMap);
		{
			~boy[\randBell].kill;
			~boyBus[\endFade].free;
			["you're dead, you fucker"].postln;
		}.defer(time).yield;
	};
});