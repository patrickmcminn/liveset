/*
Wednesday, October 10th 2012
server.scd
prm
*/

// creates a set of functions for Server handling
~server = { };

~server.addUniqueMethod(\boot, {
	s.boot;
});

~server.addUniqueMethod(\quit, {
	s.quit;
});

~server.addUniqueMethod(\memSize, { | func, size |
	var serverOptions;
	serverOptions = Server.local.options;
	serverOptions.memSize = size;
});

~server.addUniqueMethod(\setNumAudioBusses, { | func, num = 1024 |
  var serverOptions;
  serverOptions = Server.default.options;
  serverOptions.numAudioBusChannels = num;
});

~server.memSize(131072);
~server.setNumAudioBusses(1024);
~server.boot;