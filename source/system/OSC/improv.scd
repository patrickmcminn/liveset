/*
Sunday, January 13th 2012
improvOSC.scd
prm
*/

OSCdef(\gendy, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~gendyMake.value; }
	{ id == \toggle } { ~gendyToggle.value; }
	{ id == \reset } { ~gendy.gendy.set(\shift, 0);}
	{ id == \shift } { ~gendy.gendy.set(\shift, val); }
	{ id == \volume } { ~gendy.gendy.set(\amp, val); }
}, \gendy);

~gendyMake = r ({
	loop {
		~gendy.init(~inst[\mute], ~mixer[\s1], ~group[\fx]);
		~scLang.sendMsg(\control, \gendy);
		["gendy synth active"].yield;

		~gendy.kill;
		~scLang.sendMsg(\control, \gendy);
		["gendy synth freed"].yield;
			};
		});

~gendyToggle = r({
	loop {
		~gendy.mute;
		~scLang.sendMsg(\control, \gendyToggle);
		["gendy input muted"].yield;

		~gendy.unmute;
		~scLang.sendMsg(\control, \gendyToggle);
		["gendy input unmuted"].yield;
	}
});

OSCdef(\pings, { | msg |
	var id, val;
	id = msg.at(1);
	val = msg.at(2);
	case
	{ id == \main } { ~pingsMake.value; }
	{ id == \toggle } { ~pingsToggle.value; }
	{ id == \volume } { ~pings.fader.set(\amp, val); }
	{ id == \loScale } { ~pings.scale.set(\rangeOutLo, val); }
	{ id == \hiScale } { ~pings.scale.set(\rangeOutHi, val); }
}, \pings);

~pingsMake = r ({
	loop {
		~pings.init(~inst[\mute], ~mixer[\s1], ~group[\fx]);
		~scLang.sendMsg(\control, \pings);
		["pings synth active"].postln.yield;

		~pings.kill;
		~scLang.sendMsg(\control, \pings);
		["pings synth freed"].postln.yield;
	};
});

~pingsToggle = r ({
	loop {
		~pings.mute;
		~scLang.sendMsg(\control, \pingsToggle);
		["pings input muted"].yield;

		~pings.unmute;
		~scLang.sendMsg(\control, \pingsToggle);
		["pings input unmuted"].yield;
	};
});




