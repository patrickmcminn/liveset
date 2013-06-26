/*
Sunday, June 23rd 2013
keyboard.scd
prm
*/

var oct1, oct2, oct3, oct4;
var oct1Offset, oct2Offset, oct3Offset, oct4Offset;

oct1 = 36;
oct2 = 48;
oct3 = 60;
oct4 = 72;

oct4Offset = 1;
oct3Offset = 3;
oct2Offset = 5;
oct1Offset = 7;

~improvOhm.noiseSynth.keyboard = (

	state: 0,
	notePos: [0, 7, 8, 15, 16, 24, 31, 32, 39, 40, 47, 48, 56],

	spawn: { | self |
		if ( self.state == 0, { self.init; }, { self.kill; } );
		self;
	},

	init: { | self |
		self.makeKeyboard;
		self;
	},

	kill: { | self |
		self.killKeyboard;
		self;
	},

	makeOct4: { | self |
		self.notePos.do({ | pos, i |
			~ohm.turnBlue(pos + oct4Offset);
			MIDIdef.noteOn(("improvNoiseSynth" ++ (pos + oct4Offset)).asSymbol, {
				~scLang.sendMsg(\improvNoiseSynth, \play, (oct4 + i)) }, (pos + oct4Offset));
			MIDIdef.noteOff(("improvNoiseSynthRel" ++ (pos + oct4Offset)).asSymbol, {
				~scLang.sendMsg(\improvNoiseSynth, \stop, (oct4 + i)) }, (pos + oct4Offset));
		});
		self;
	},

	makeOct3: { | self |
		self.notePos.do({ | pos, i |
			~ohm.turnPurple(pos + oct3Offset);
			MIDIdef.noteOn(("improvNoiseSynth" ++ (pos + oct3Offset)).asSymbol, {
				~scLang.sendMsg(\improvNoiseSynth, \play, (oct3 + i));
			}, (pos + oct3Offset));
			MIDIdef.noteOff(("improvNoiseSynthRel" ++ (pos + oct3Offset)).asSymbol, {
				~scLang.sendMsg(\improvNoiseSynth, \stop, (oct3 + i)) }, (pos + oct3Offset));
			i.postln;
		});
		self;
	},

	makeOct2: { | self |
		self.notePos.do({ | pos, i |
			~ohm.turnYellow(pos + oct2Offset);
			MIDIdef.noteOn(("improvNoiseSynth" ++ (pos + oct2Offset)).asSymbol, {
				~scLang.sendMsg(\improvNoiseSynth, \play, (oct2 + i)) }, (pos + oct2Offset));
			MIDIdef.noteOff(("improvNoiseSynthRel" ++ (pos + oct2Offset)).asSymbol, {
				~scLang.sendMsg(\improvNoiseSynth, \stop, (oct2 + i)) }, (pos + oct2Offset));
		});
		self;
	},

	makeOct1: { | self |
		self.notePos.do({ | pos, i |
			~ohm.turnRed(pos + oct1Offset);
			MIDIdef.noteOn(("improvNoiseSynth" ++ (pos + oct1Offset)).asSymbol, {
				~scLang.sendMsg(\improvNoiseSynth, \play, (oct1 + i)) }, (pos + oct1Offset));
			MIDIdef.noteOff(("improvNoiseSynthRel" ++ (pos + oct1Offset)).asSymbol, {
				~scLang.sendMsg(\improvNoiseSynth, \stop, (oct1 + i)) }, (pos + oct1Offset));
		});
		self;
	},

	makeKeyboard: { | self |
		self.makeOct1;
		self.makeOct2;
		self.makeOct3;
		self.makeOct4;
		self;
	},

	killKeyboard: { | self |

		self;
	},
)