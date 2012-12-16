/*
Thursday, November 1st 2012
Between Denver, Colorado and Lawrence, Kansas
bed.scd
prm
*/


~birdsMake[\bed] = Routine({
	loop{
		~birds[\bed].value;
		~scLang.sendMsg(\control, \bed);
		["bed Synths created, Onset Detection Active"].postln.yield;

		~birds[\bed].kill;
		~birdsMake[\bedPlay].reset;
		~scLang.sendMsg(\control, \bed);
		["bed Synths killed, patterns stopped"].postln.yield;
	}
});



~birdsMake[\bedPlay] = r ({

	Pbindef(\bedCSharp).play;
	~scLang.sendMsg(\control, \bedPlay);
	["C# bed playing"].postln.yield;


	Pbindef(\bedGSharp).play;
	~scLang.sendMsg(\control, \bedPlay);
	["G# bed playing"].postln.yield;


	Pbindef(\bedFSharp).play;
	~scLang.sendMsg(\control, \bedPlay);
	["F# bed playing"].postln.yield;


	Pbindef(\bedA).play;
	~scLang.sendMsg(\control, \bedPlay);
	["A bed playing"].postln.yield;


	Pbindef(\bedB).play;
	~scLang.sendMsg(\control, \bedPlay);
	["B bed playing"].postln.yield;


	Pbindef(\bedE).play;
	~scLang.sendMsg(\control, \bedPlay);
	["E bed playing"].postln.yield;


	loop {
		~scLang.sendMsg(\control, \bedPlay);
		["all beds playing"].postln.yield;
	};
});



~birdsMake[\bedToggle] = r ({
	loop{
		~birds[\bed].playBed;
		~scLang.sendMsg(\control, \bedToggle);
		["all beds on"].postln.yield;

		~birds[\bed].stopBed;
		~scLang.sendMsg(\control, \bedToggle);
		["all beds off"].postln.yield;
	}
});



/*
signal flow:
recorded buffers
lots of reverb
Hi-Cut
more verb
granulation
*/